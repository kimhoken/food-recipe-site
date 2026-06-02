package com.project.foodsite.dao;

import java.util.List;
import java.util.Map;

import com.project.foodsite.dto.RecipeDTO;
import com.project.foodsite.vo.RecipeVO;

public interface RecipeDAO {
    int size();
    RecipeVO selectOne(int num);
    List<RecipeVO> selectAll();
    int insertRecipe(RecipeDTO dto);
    
    //레시피 테이블 아이디
    int getLastRecipeId();
    
    //재료담기
    int insertVegetable(Map<?, ?> map);
    int insertMeat(Map<?, ?> map);
    int insertSeasoning(Map<?, ?> map);
} 
