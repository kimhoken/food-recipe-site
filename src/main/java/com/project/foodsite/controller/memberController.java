package com.project.foodsite.controller;


import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.common.MailSendService;
import com.project.foodsite.common.pwdSecurity;
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
    private final MailSendService mss;
    private final pwdSecurity pwdSecurity;
    
    //회원 리스트 출력
    @GetMapping(value = {"/member_list.do"})
    public String selectlist(Model model) {

        List<MemberVO> list = memberDAO.selectList();

        model.addAttribute("list", list);

        return "/member/member_list";
    }
    

    //로그인 페이지
    @GetMapping("/login.do")
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

   @PostMapping("/register.do")
   @ResponseBody
   public Map<String,Integer> register(MemberVO vo) throws Exception {

        //비밀번호 암호화
        String enc_pwd = pwdSecurity.pwdEncoding(vo.getPassword());
        vo.setPassword(enc_pwd);
        String filename ="no_file";
        
        vo.setFilename(filename);
        vo.setRole("User");
        vo.setStatus("Active");
        
        int res = memberDAO.userInsert(vo);

        Map<String,Integer> map = new HashMap<>();
        map.put("res", res);
        return map;
   } 



}
