package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public Map<String, Object> getCategory(String category) {
        Map<String, Object> map = new HashMap<>();

        //소분류(국/찌개 등) 리스트 조회
        List<CategoryVO> catList = categoryDao.getCategoryList(category);

        //대분류에 속하는 음식 리스트 조회
        // List<FoodVO> foodList = foodDao.foodListCategory(category);
        List<FoodVO> foodList = categoryDao.foodListCategory(category);

        map.put("catList", catList);
        map.put("foodList", foodList);

        return map;
    }

}
