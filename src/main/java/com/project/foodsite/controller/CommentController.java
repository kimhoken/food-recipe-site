package com.project.foodsite.controller;

import java.util.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.CommonCommentDAO;
import com.project.foodsite.vo.CommentVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CommentController {

    private final CommonCommentDAO commonCommentDAO;

    /**
     * 레시피에 댓글하는 메서드
     * @param vo {제목, 내용, 레시피ID, 멤버ID}를 넘겨줌
     * @return  성공/실패여부
     */
    @PostMapping("/api/recomment/insert")
    @ResponseBody
    public Map<?, ?> recipeInsert(@RequestBody CommentVO vo){
        int res = commonCommentDAO.insertComment(vo);
        String result = "fail";

        if(res != 0){
            result = "success";
        }
        
        Map<String, String> map = new HashMap<>();
        map.put("result", result);
        return map;
    }

    @DeleteMapping("/api/recomment/delete")
    @ResponseBody
    public Map<String, String> recommentDelete(@RequestBody Map<String, String> map){
        String result = commonCommentDAO.deleteComment(Integer.parseInt(map.get("commentId"))) != 0 ? "success" : "fail";
        map.put("result", result);
        return map;
    }
    
    @PostMapping("/api/recomment/update")
    @ResponseBody
    public Map<String, String> recommentUpdate(@RequestBody Map<String, String> map){
        map.put("result", commonCommentDAO.update(map) != 0 ? "success" : "fail");
        return map;
    }


}
