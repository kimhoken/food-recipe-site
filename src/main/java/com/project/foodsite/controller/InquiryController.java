package com.project.foodsite.controller;

import org.springframework.stereotype.Controller;

import com.project.foodsite.common.pwdSecurity;
import com.project.foodsite.dao.InquiryDAO;
import com.project.foodsite.vo.InquiryVO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
@RequiredArgsConstructor
public class InquiryController {

    private final InquiryDAO inquiryDao;
    private final pwdSecurity pwdSecurity;

    @GetMapping("/inquiry")
    public String inquiryform(){
        return "inquiry/inquiryForm";
    }

    @PostMapping("/inquiry")
    public String insertInquiry(InquiryVO vo, HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        vo.setStatus("n");

        if (user != null) {
            System.out.println(user.getMember_id());
            
            vo.setMember_id((int) user.getMember_id());

            vo.setGuest_name(null);
            vo.setGuest_email(null);
            vo.setGuest_password(null);
        } else {
            // 암호화
            String encPwd = pwdSecurity.pwdEncoding(vo.getGuest_password());
            vo.setGuest_password(encPwd);
        }

        inquiryDao.insertInquiry(vo);

        return "redirect:/main_list.do";
    }
}
    

