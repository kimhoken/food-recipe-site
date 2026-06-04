package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.RecipeVO;

public interface RecipeDAO {
    int size();
    RecipeVO selectOne(int num);
    List<RecipeVO> selectAll();
    List<RecipeVO> selectAny(String ingredient_name);
} 
