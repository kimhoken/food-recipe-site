package com.project.foodsite.controller;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.common.Fileupload;
import com.project.foodsite.common.pwdSecurity;
import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {

    @Value("${file.upload.path}")
    private String uploadPath;

    @Autowired
    HttpSession httpSession;

    private final MemberDAO memberDAO;
    private final pwdSecurity pwdSecurity; 
    private final Fileupload fileupload;

    @GetMapping("/mypage.do")
    public String gomypage(Model model, String menu) {

        MemberVO user = (MemberVO) httpSession.getAttribute("User");

        model.addAttribute("user", user);

        model.addAttribute("menu", menu);

        if (menu == null || menu.equals("account")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_info.jsp");
        } else if (menu.equals("activity")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_activity.jsp");
        } else if (menu.equals("inquiry")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_inquiry.jsp");
        } else if (menu.equals("update")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_modify.jsp");
        } else if (menu.equals("pwd")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_pwd.jsp");
        } else if (menu.equals("del")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_del.jsp");
        }

        return "member/mypage";
    }

    @PostMapping("/mypage_update.do")
    public String update(MemberVO vo, String filechange) throws Exception{

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        MemberVO olduser = memberDAO.getUserByMemberId(user.getMember_id());


        String savePath = uploadPath + "/profile" ;
        
        String filename = user.getProfile_img();

        MultipartFile photo = vo.getPhoto();
        // 기존이미지 삭제
        if(filechange.equals("yes")){

            fileupload.deleteFile(savePath, filename);

            filename ="no_file.png";

        }else if(photo != null && !photo.isEmpty()){

            fileupload.deleteFile(savePath, filename);
            filename = fileupload.saveFile(photo, savePath);

        }else{
            filename = user.getProfile_img();
        }

        vo.setMember_id(user.getMember_id());
        vo.setFilename(filename);

        int res = memberDAO.userUpdate(vo);

        if(res>0){
            MemberVO updateduser = memberDAO.getUserByMemberId(vo.getMember_id());
            httpSession.setAttribute("user", updateduser);

            return "redirect:/mypage.do?menu=account";
        }else{
            return "redirect:/mypage.do?menu=update";

        }
          
            

       
    }

    @PostMapping("/userpwdcheck.do")
    @ResponseBody
    public String userpwdcheck(String currpwd){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");
        System.out.println(user);
        System.out.println(currpwd+" / "+ user.getPassword());
     
        if(pwdSecurity.pwdDecoding(currpwd, user.getPassword())){
            return "ok";
        }
        return "no";

    }

    @PostMapping("/resetpwdpage.do")
    @ResponseBody
    public String userrestpassword(String password){

        String enc_pwd = pwdSecurity.pwdEncoding(password);

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        MemberVO vo = new MemberVO();
        
        vo.setMember_id(user.getMember_id());
        
        vo.setPassword(enc_pwd);
        
        int res = memberDAO.userPwdUpdate(vo);
        
        if( res>0){
            return "success";
        } else{
            return "fail";
        }
    }


    @PostMapping("/secessionUser.do")
    @ResponseBody
    public String secessionuser( MemberVO vo){

        String savePath = uploadPath+"/profile";

        fileupload.deleteFile(savePath, vo.getProfile_img());

        vo.setStatus("no");
        vo.setLogin_id(null);
        vo.setPassword(null);
        vo.setNickname("탈퇴회원_"+vo.getMember_id());
        vo.setEmail("withdraw_"+ vo.getMember_id()+"@delete.com");
        vo.setProvider(null);
        vo.setProvider_id(null);
        vo.setMember_intro(null);
        vo.setName("탈퇴");
        vo.setProfile_img("no_file.png");
        
        int res = memberDAO.secessionUser(vo);

        if( res > 0 ){
            httpSession.removeAttribute("user");
            return "yes";
        }else{
            return "no";
        }
        
        
    }
}
