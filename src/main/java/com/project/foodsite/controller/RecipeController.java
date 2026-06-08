package com.project.foodsite.controller;

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
    public String recipeList( RecipeSearchDTO searchDTO, Model model){
        List<RecipeVO> recipeList = recipeDao.selectRecipeList(searchDTO);
        model.addAttribute("recipeList", recipeList);
        return "recipe/recipe_list";
    
    
    }

    

}
