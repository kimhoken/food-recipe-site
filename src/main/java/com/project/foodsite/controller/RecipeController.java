package com.project.foodsite.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.dto.RecipeSearchDTO;
import com.project.foodsite.vo.RecipeVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class RecipeController {

    private final RecipeDAO recipeDao;

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

        // 2. 정렬 값 기본값 설정 (파라미터가 없으면 기본값 세팅)
        if (searchDTO.getSort() == null || searchDTO.getSort().isEmpty()) {
            searchDTO.setSort("latest");
        }

        List<String> times = searchDTO.getCookTimes();

        // 3. 페이징 처리 및 데이터 조회
        int totalCount = recipeDao.selectRecipeCount(searchDTO);
        model.addAttribute("totalPage", (totalCount + 8) / 9);

        List<RecipeVO> recipeList = recipeDao.selectRecipeList(searchDTO);
        model.addAttribute("recipeList", recipeList);
        model.addAttribute("recipeSearchDTO", searchDTO);

        // 4. 조리시간 선택 후 결과가 아예 없을 때 메시지 처리
        if (times != null && !times.isEmpty() && recipeList.isEmpty()) {
            
            // 단일 선택했을 때 (체크박스를 딱 하나만 골랐는데 데이터가 없을 때)
            if (times.size() == 1) {
                String selectedVal = times.get(0);
                String timeText = "";
                
                switch (selectedVal) {
                    case "10": timeText = "10분 이하"; break;
                    case "20": timeText = "10~20분"; break;
                    case "30": timeText = "20~30분"; break;
                    case "60": timeText = "30~60분"; break;
                    case "61": timeText = "60분 이상"; break;
                    default:   timeText = "선택한"; break;
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

        return "recipe/recipe_list";
    }

}
