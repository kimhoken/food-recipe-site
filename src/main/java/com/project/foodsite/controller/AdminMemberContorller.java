package com.project.foodsite.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.common.AdminUtil;
import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminMemberContorller {
    
    @Autowired
    HttpSession httpSession;

   
    private final AdminUtil adminUtil;

    @GetMapping("/admin/member")
    public String memberpage(Model model){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");
        
        model.addAttribute("profileuser",user);

        adminUtil.setContentPage(model, "member");

        return "member/adminpage";
    }

}
