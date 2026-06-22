package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.RecipeCommentVO;

public interface RecipeCommentDAO {
    int insertComment(RecipeCommentVO vo);
    List<RecipeCommentVO> getList(int recipeId);
}
