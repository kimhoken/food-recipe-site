package com.project.foodsite.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;




@RequiredArgsConstructor
@Controller
public class memberController {

    @Autowired
    HttpSession httpSession;

    private final MemberDAO memberDAO;
    
    //회원 리스트 출력
    @GetMapping(value = {"/member_list.do"})
    public String selectlist(Model model) {

        List<MemberVO> list = memberDAO.selectList();

        model.addAttribute("list", list);

        return "/member/member_list";
    }
    

    //로그인 페이지
    @GetMapping(value = {"/","/login.do"})
    public String loginpage() {
        return "/member/login";
    }

    //로그인
    @PostMapping("/login.do")
    @ResponseBody
    public Map<String, String> loginCheck(MemberVO vo){

        MemberVO user = memberDAO.getUserById(vo.getLogin_id());

        Map<String, String> map = new HashMap<>();

        String login_res = "no_id";   

        if ( user != null ) {

            login_res = "no_pwd";
            //암호화 후 수정 예정 

            if( user.getPassword().equals(vo.getPassword()) ) {
                httpSession.setAttribute("user", user);
                httpSession.setMaxInactiveInterval(3600);
                map.put("nick", user.getNickname());
                login_res = "login";
            }

        }
        
        map.put("res", login_res);

        return map;

    }
    

    //회원 가입 페이지
    @GetMapping("/register_form.do")
    public String registerpage(){
        return "/member/register_form";
    }

    @GetMapping("/main_page.do")
    public String mainPage(){
        return "/member/main_page_test";
    }


}
