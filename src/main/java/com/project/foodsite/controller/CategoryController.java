package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.CategoryDAO;
import com.project.foodsite.vo.CategoryVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CategoryController {
    
    private final CategoryDAO categoryDao;

    //사이드바 카테고리 메뉴 선택  
     @GetMapping("/category.do")
     @ResponseBody
     public Map<String, Object> getCategory(String category){
        Map<String, Object> resultMap = new HashMap<>();

        List<CategoryVO> catList = categoryDao.getCategoryList(category); //소분류 리스트 

        resultMap.put("catList", catList);

        return resultMap;
        
     }


}
