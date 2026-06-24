package com.project.foodsite.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.common.AdminUtil;
import com.project.foodsite.dao.RecipeCommentDAO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminRecipeCommentController {
    @Autowired
    HttpSession httpSession;

    private final RecipeCommentDAO recipeCommentDAO;
    private final AdminUtil adminUtil;

    @GetMapping("/admin/recipecomment")
    public String recipecommentpage(Model model){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        model.addAttribute("user", user);

        adminUtil.setContentPage(model, "recipecomment");

        return "member/adminpage";
    }




}
