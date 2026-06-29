package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.common.AdminUtil;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.RecipeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminController {
    private final HttpSession httpSession;
    private final RecipeDAO recipeDAO;
    private final AdminUtil adminUtil;
    
    // 관리자 페이지 이동 함수
    @GetMapping("/admin")
    public String adminpage(Model model) {

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        List<RecipeVO> recentlyRecipe = recipeDAO.recentlyrecipe();

        model.addAttribute("profileuser", user);
        model.addAttribute("list",recentlyRecipe);
        model.addAttribute("contentPage", "/WEB-INF/views/member/admin/admin_home.jsp");

        return "member/adminpage";

    }

    @GetMapping("/admin/mypage")
    public String adminmypage(Model model){

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        model.addAttribute("profileuser",user);
        
        adminUtil.setContentPage(model, "mypage");

        return "member/adminpage";

    } 

    

    

}
