package com.project.foodsite.dao;

import java.util.List;
import java.util.Map;

import com.project.foodsite.vo.CommentVO;

public interface CommentDAO {

    List<CommentVO> userComment(int member_id);

    int countUserComment(int member_id);

    List<CommentVO> getUserCommentList(Map<String,Object> map);

}
