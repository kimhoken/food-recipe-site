package com.project.foodsite.dao;

import java.util.List;
import java.util.Map;

import com.project.foodsite.vo.CommentVO;

public interface CommonCommentDAO {

    int insertComment(Map<?, ?> map);

    List<CommentVO> getRecipeList(int recipe_id);

    List<CommentVO> getBoardList(int board_id);

    int deleteComment(int comment_id);

    int update(Map<?, ?> map);
}