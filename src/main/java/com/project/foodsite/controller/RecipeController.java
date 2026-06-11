package com.project.foodsite.controller;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.dto.RecipeSearchDTO;
import com.project.foodsite.vo.RecipeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class RecipeController {

    private final RecipeDAO recipeDao;

    private HttpSession session;

    @GetMapping("/recipe_list.do")
    public String recipeList(RecipeSearchDTO searchDTO, Model model) {
        String category = searchDTO.getCategory();

        // 카테고리 미선택 시 빈 상태 반환
        if (category == null || category.isEmpty()) {
            model.addAttribute("recipeList", new ArrayList<>());
            model.addAttribute("totalPage", 0);
            model.addAttribute("recipeSearchDTO", searchDTO);
            return "recipe/recipe_list";
        }

        List<String> times = searchDTO.getCookTimes();

        // 조리시간 선택 시 최대값 계산
        if (times != null && !times.isEmpty()) {
            int max = 0;
            for (String t : times) {
                int currentTime = Integer.parseInt(t);
                if (currentTime == 61) {
                    max = 9999;
                    break;
                }
                if (currentTime > max)
                    max = currentTime;
            }
            searchDTO.setMaxCookTime(max);
        } else {
            searchDTO.setMaxCookTime(0); // 조리시간 미선택 = 전체
        }
        // 페이징 처리
        int totalCount = recipeDao.selectRecipeCount(searchDTO);
        model.addAttribute("totalPage", (totalCount + 8) / 9);

        List<RecipeVO> recipeList = recipeDao.selectRecipeList(searchDTO);
        model.addAttribute("recipeList", recipeList);
        model.addAttribute("recipeSearchDTO", searchDTO);

        // 조리시간 선택 후 결과 없을 때 메시지
        if (times != null && !times.isEmpty() && recipeList.isEmpty()) {
            model.addAttribute("emptyMsg",
                    "'" + category + "' 카테고리의 선택한 조리시간에 해당하는 레시피가 없습니다.");
        }

        return "recipe/recipe_list";
    }

    /**
     * 레시피 검색 <미완성>
     * @param model binding을 위한 model
     * @param search 검색어
     * @return  jsp
     */
    @PostMapping("/search_recipe.do")
    public String recipeSearch(Model model, String search){
        //검색어를 입력받아 검색어로 유사 검색 후 결과 리턴
        //최근검색어는 큐로 저장해 5개 유지 및 오래된 검색어 삭제
        @SuppressWarnings("unchecked")
        Queue<String> searchQueue = (Queue<String>) session.getAttribute("searchQueue");
        
        if (searchQueue == null) {
            searchQueue = new LinkedList<>();
        }

        if(searchQueue.size() >= 5){
            //크기가 5이상이면 가장 먼저 검색한 검색어 삭제
            searchQueue.poll();
        }
        searchQueue.add(search);
        session.setAttribute("searchQueue", searchQueue);
        
        return "common/search_nav";
    }

    

}
