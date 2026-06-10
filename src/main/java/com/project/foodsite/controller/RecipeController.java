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

}
