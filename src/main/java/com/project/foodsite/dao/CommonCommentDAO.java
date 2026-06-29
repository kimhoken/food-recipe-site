package com.project.foodsite.dao;

import java.util.List;
import java.util.Map;

import com.project.foodsite.vo.CommentVO;

public interface CommonCommentDAO {
    int insertComment(CommentVO vo);
    List<CommentVO> getList(int recipe_id);
    int deleteComment(int commentId);
    int update(Map<?, ?> map);
}
