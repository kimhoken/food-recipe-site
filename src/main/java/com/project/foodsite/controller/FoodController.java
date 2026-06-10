package com.project.foodsite.controller;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.CategoryDAO;
import com.project.foodsite.vo.CategoryVO;
import com.project.foodsite.vo.FoodVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class FoodController {

    private final CategoryDAO categoryDao;

    @GetMapping("/category.do")
    @ResponseBody
    public Map<String, List<String>> getCategory(String category) {
        Map<String, List<String>> map = new LinkedHashMap<>();
        List<CategoryVO> list = categoryDao.selectCategoryFood(category);

        for(CategoryVO vo : list){
            map.computeIfAbsent(vo.getSubCategoryName(), k -> new ArrayList<>()).add(vo.getFoodName());
        }

        return map;
    }

}
