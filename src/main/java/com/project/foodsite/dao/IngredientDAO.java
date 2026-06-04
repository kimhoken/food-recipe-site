package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.IngredientVO;

public interface IngredientDAO {
    List<IngredientVO> selectList(int recipe_id);
}
