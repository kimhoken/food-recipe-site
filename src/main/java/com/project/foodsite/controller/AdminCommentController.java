package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.common.AdminUtil;
import com.project.foodsite.common.Paging;
import com.project.foodsite.dao.CommentDAO;
import com.project.foodsite.dto.AdminCommentDTO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminCommentController {
    private final HttpSession httpSession;
    private final CommentDAO commentDAO;
    private final AdminUtil adminUtil;

    // 댓글 페이징 함수 ( 검색 까지 들어가 있음 )
    private void commentPaging(Model model, AdminCommentDTO Comment){
        if(Comment.getPage() <= 0){
            Comment.setPage(1);
        }

        int totalcount = commentDAO.commentCount(Comment);

        Paging paging = new Paging(Comment.getPage(), 5, totalcount);

        Comment.setOffset(paging.getOffset());
        Comment.setSize(paging.getSize());

        List<AdminCommentDTO> list = commentDAO.CommentSearch(Comment);
        
        model.addAttribute("list", list);
        model.addAttribute("totalcount", totalcount );
        model.addAttribute("paging", paging);
        model.addAttribute("admincomment", Comment);

    }

    // 댓글 관리 페이지 이동 함수 
    @GetMapping("/admin/comment")
    public String commentlist(Model model, AdminCommentDTO Comment){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        model.addAttribute("profileuser",user);

        commentPaging(model, Comment);

        adminUtil.setContentPage(model, "comment");
        return "member/adminpage";
    }

    




}
