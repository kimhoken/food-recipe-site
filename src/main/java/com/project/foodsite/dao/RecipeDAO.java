package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.dto.RecipeSearchDTO;
import com.project.foodsite.vo.RecipeVO;

public interface RecipeDAO {
    int size();
    RecipeVO selectOne(int num);
    List<RecipeVO> selectAll();
    List<RecipeVO> selectAny(String fridgeList);

    //레시피 목록 조회(카테고리, 조리시간, 정렬 조건 적용)
    List<RecipeVO> selectRecipeList(RecipeSearchDTO searchDTO);

    //전체 레시피 개수 조회 (페이징 처리용)
    int selectRecipeCount(RecipeSearchDTO searchDTO);

    List<RecipeVO> selectRecently();
    List<RecipeVO> selectViewCount();
    
} 
