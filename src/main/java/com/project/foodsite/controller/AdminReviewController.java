package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.common.AdminUtil;
import com.project.foodsite.common.Paging;
import com.project.foodsite.dao.ReviewDAO;
import com.project.foodsite.dto.AdminReviewDTO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminReviewController {
    private final HttpSession httpSession;
    private final ReviewDAO reviewDAO;
    private final AdminUtil adminUtil;

    private void ReviewPaging(Model model,AdminReviewDTO Review){

        if(Review.getPage() <= 0){
            Review.setPage(1);
        }

        int totalcount = reviewDAO.ReviewCount(Review);

        Paging paging = new Paging(Review.getPage(), 5 , totalcount);

        Review.setSize(paging.getSize());
        Review.setOffset(paging.getOffset());

        List<AdminReviewDTO> list = reviewDAO.ReviewSearch(Review);
        
        model.addAttribute("list",list);
        model.addAttribute("paging",paging);
        model.addAttribute("totalcount",totalcount);
        model.addAttribute("adminreview",Review);

    }

    @GetMapping("/admin/review")
    public String recipecommentpage(Model model, AdminReviewDTO Review){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        model.addAttribute("profileuser", user);   

        adminUtil.setContentPage(model, "review");

        ReviewPaging(model, Review);

        return "member/adminpage";
    }




}
