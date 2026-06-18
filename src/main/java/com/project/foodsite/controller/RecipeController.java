package com.project.foodsite.controller;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.dao.BoardDAO;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.dao.SearchLogDAO;
import com.project.foodsite.dto.RecipeDetailDTO;
import com.project.foodsite.dto.RecipeSearchDTO;
import com.project.foodsite.util.TrendingService;
import com.project.foodsite.vo.CookOrderVO;
import com.project.foodsite.vo.IngredientVO;
import com.project.foodsite.vo.RecipeVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class RecipeController {

    private final RecipeDAO recipeDao;
    private final HttpSession session;
    private final SearchLogDAO searchLogDAO;
    private final BoardDAO boardDAO;
    private final TrendingService trendingService;

    @GetMapping("/recipe_list.do")
    public String recipeList(RecipeSearchDTO searchDTO, Model model) {

        String category = searchDTO.getCategory();

        // 1. 카테고리 미선택 시 빈 상태 반환
        if (category == null || category.isEmpty()) {
            model.addAttribute("recipeList", new ArrayList<>());
            model.addAttribute("totalPage", 0);
            model.addAttribute("recipeSearchDTO", searchDTO);
            return "recipe/recipe_list";
        }

        // 2. 선택된 대분류에 속하는 소분류 음식 데이터들을 조회하여 Model에 저장
        List<Map<String, Object>> foodList = recipeDao.selectFoodListByCategory(category);
        model.addAttribute("foodList", foodList);

        // 2. 정렬 값 기본값 설정 (파라미터가 없으면 기본값 세팅)
        if (searchDTO.getSort() == null || searchDTO.getSort().isEmpty()) {
            searchDTO.setSort("latest");
        }

        List<String> times = searchDTO.getCookTimes();

        // 3. 페이징 처리 및 데이터 조회
        int totalCount = recipeDao.selectRecipeCount(searchDTO);
        model.addAttribute("totalPage", (totalCount + 8) / 9);

        List<RecipeVO> recipeList = recipeDao.selectRecipeList(searchDTO);

        // 디버깅
        System.out.println("조회 개수 : " + recipeList.size());

        for (RecipeVO r : recipeList) {
            System.out.println(
                    r.getRecipe_id()
                            + " / "
                            + r.getTitle()
                            + " / "
                            + r.getCategory_id()
                            + " / "
                            + r.getFood_id());
        }

        String sort = searchDTO.getSort();
        if (sort.equals("latest")) {
            Collections.sort(recipeList, (e1, e2) -> {
                return e1.getCreated_date().compareTo(e2.getCreated_date());
            });
        } else if (sort.equals("view")) {
            Collections.sort(recipeList, (e1, e2) -> {
                return e2.getView_count() - e1.getView_count();
            });
        } else if (sort.equals("like")) {
            Collections.sort(recipeList, (e1, e2) -> {
                return e2.getLike_count() - e1.getLike_count();
            });
        } else {
            Collections.sort(recipeList, (e1, e2) -> {
                return e1.getTitle().compareTo(e2.getTitle());
            });
        }

        model.addAttribute("recipeList", recipeList);
        model.addAttribute("recipeSearchDTO", searchDTO);
        model.addAttribute("sort", sort);
        // 4. 조리시간 선택 후 결과가 아예 없을 때 메시지 처리
        if (times != null && !times.isEmpty() && recipeList.isEmpty()) {

            // 단일 선택했을 때 (체크박스를 딱 하나만 골랐는데 데이터가 없을 때)
            if (times.size() == 1) {
                String selectedVal = times.get(0);
                String timeText = "";

                switch (selectedVal) {
                    case "10":
                        timeText = "10분 이하";
                        break;
                    case "20":
                        timeText = "10~20분";
                        break;
                    case "30":
                        timeText = "20~30분";
                        break;
                    case "60":
                        timeText = "30~60분";
                        break;
                    case "61":
                        timeText = "60분 이상";
                        break;
                    default:
                        timeText = "선택한";
                        break;
                }

                // 60분 이상을 포함하여 모든 단일 선택 시
                model.addAttribute("emptyMsg",
                        "'" + category + "' 카테고리의 " + timeText + " 조리시간에 해당하는 레시피가 없습니다.");
            }
            // 복수 선택했을 때
            else {
                model.addAttribute("emptyMsg",
                        "'" + category + "' 카테고리의 선택한 조리시간에 해당하는 레시피가 없습니다.");
            }
        }
        @SuppressWarnings("unchecked")
        Queue<String> currentQueue = (Queue<String>) session.getAttribute("searchQueue");
        List<String> currentList = new LinkedList<>();

        if (currentQueue != null && !currentQueue.isEmpty()) {
            for (String val : currentQueue) {
                currentList.add(val);
            }
        }

        session.setAttribute("searchList", trendingService.getTrendingKeywords());
        session.setAttribute("currentSearchList", currentList);

        return "recipe/recipe_list";
    }

    /**
     * 레시피 검색
     * 
     * @param model  binding을 위한 model
     * @param search 검색어
     * @return jsp
     */
    @PostMapping("/search_recipe.do")
    public String recipeSearch(Model model, String search, HttpServletRequest req, String select) {
        // 검색어를 입력받아 검색어로 유사 검색 후 결과 리턴
        // 최근검색어는 큐로 저장해 5개 유지 및 오래된 검색어 삭제
        // 검색어를 받아 검색어 테이블에 저장

        // ip를 키, 검색어를 value로 저장
        @SuppressWarnings("unchecked")
        HashMap<String, List<String>> map = session.getAttribute("searchMap") == null ? new HashMap<>()
                : (HashMap<String, List<String>>) session.getAttribute("searchMap");

        // IP가 같은 키 값이 없을 경우
        if (!map.containsKey(req.getRemoteAddr())) {
            searchLogDAO.insertKeyWord(search);
            map.computeIfAbsent(req.getRemoteAddr(), k -> new ArrayList<>()).add(search);
            // 세션에 저장
            session.setAttribute("searchMap", map);
            session.setMaxInactiveInterval(3600);
        } else {
            boolean flag = true;
            for (String val : map.get(req.getRemoteAddr())) {
                if (val.equals(search)) {
                    flag = false;
                    break;
                }
            }

            // 맵에서 value가 search랑 같은 값이 없을 경우
            if (flag) {
                searchLogDAO.insertKeyWord(search);
                map.computeIfAbsent(req.getRemoteAddr(), k -> new ArrayList<>()).add(search);
                // 세션에 저장
                session.setAttribute("searchMap", map);
                session.setMaxInactiveInterval(3600);
            }
        }

        @SuppressWarnings("unchecked")
        Queue<String> searchQueue = (Queue<String>) session.getAttribute("searchQueue") == null ? new LinkedList<>()
                : (Queue<String>) session.getAttribute("searchQueue");

        // 겹치는 단어를 큐의 맨 뒤로 보냄
        for (String val : searchQueue) {
            if (val.equals(search)) {
                searchQueue.remove(search);
                break;
            }
        }

        if (searchQueue.size() >= 5) {
            // 크기가 5이상이면 가장 먼저 검색한 검색어 삭제
            searchQueue.poll();
        }

        searchQueue.add(search);

        // 기존 세션의 값 삭제
        session.removeAttribute("searchQueue");

        // 세션에 값을 새로 저장
        session.setAttribute("searchQueue", searchQueue);
        session.setAttribute("searchWord", search);
        session.setAttribute("select", select);

        @SuppressWarnings("unchecked")
        Queue<String> currentQueue = (Queue<String>) session.getAttribute("searchQueue");
        List<String> currentList = new LinkedList<>();

        if (currentQueue != null && !currentQueue.isEmpty()) {
            for (String val : currentQueue) {
                currentList.add(val);
            }
        }

        session.setAttribute("searchList", trendingService.getTrendingKeywords());
        session.setAttribute("currentSearchList", currentList);

        if (select.equals("review")) {
            model.addAttribute("list", boardDAO.search(search));
            return "board/board_list";
        } else {
            model.addAttribute("recipeList", recipeDao.search(search));
        }

        return "recipe/recipe_list";
    }

    @GetMapping("/recipe_detail.do")
    public String recipeDetail(Model model, int recipeId) {
        model.addAttribute("recipeId", recipeId);
        RecipeDetailDTO dto = recipeDao.getRecipe(recipeId);

        List<IngredientVO> ilist = dto.getIngredientList();
        List<CookOrderVO> olist = dto.getCookOrderList();
        Collections.sort(olist, (e1, e2) -> {
            return e1.getOrder() - e2.getOrder();
        });

        for (IngredientVO vo : ilist) {
            System.out.println(vo.getIngredient_name());
            System.out.println(vo.getQuantity() + " " + vo.getUnit());
        }
        System.out.println("==========================================================================");
        for (CookOrderVO vo : olist) {
            System.out.println(vo.getOrder() + " " + vo.getDescription());
        }

        model.addAttribute("dto", dto);
        model.addAttribute("orderList", olist);
        model.addAttribute("ingredients", ilist);
        model.addAttribute("size", ilist.size());
        return "recipe/recipe_detail";
    }

}
