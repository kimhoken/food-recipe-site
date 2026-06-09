package com.project.foodsite.controller;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.CategoryDAO;
import com.project.foodsite.vo.CategoryVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class FoodController {

    private final CategoryDAO categoryDao;

    @GetMapping("/category.do")
    @ResponseBody
    public Map<String, Object> getCategory(String category) {
        Map<String, Object> map = new HashMap<>();
        //카테고리 리스트 안에 전부 넣어서 넘김
        List<CategoryVO> list = categoryDao.selectCategoryFood(category);
        map.put("catList", list);

        //정렬순서를 사용한다면?
        

        // map.put("catList", catList);
        // map.put("foodList", foodList);

        return map;
    }

}
