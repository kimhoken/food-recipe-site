package com.project.foodsite.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {

    @Autowired
    HttpSession httpSession;
    
    @GetMapping("/mypage.do")
    public String gomypage(Model model){

        MemberVO user = (MemberVO)httpSession.getAttribute("User");

        model.addAttribute("user", user);
        
        return "member/mypage";
    }

    @GetMapping("/mypage_info.do")
    public String goinfo(String sel, Model model){

        model.addAttribute("sel",sel);
        return "member/mypage-info";

    }


}
