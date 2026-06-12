package com.project.foodsite.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {

    private final HttpSession httpSession;

    private final MemberDAO memberDAO;

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
    public String update(MemberVO vo, String filechange) {

        MemberVO olduser = memberDAO.getUserByMemberId(vo.getMember_id());
        String oldfilename = olduser.getProfile_img();

        // 맥경로: /Users/사용자명/upload/
        String savePath = "C:/upload/";
        String filename = "";

        MultipartFile photo = vo.getPhoto();
        

        try {
            // 
            if (filechange.equals("yes")) {
                filename = "no_file.png";
            } else if (photo != null && !photo.isEmpty()) {

                File dir = new File(savePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                filename = photo.getOriginalFilename();

                File saveFile = new File(savePath, filename);

                if (saveFile.exists()) {

                    System.out.println("같은 친구 발견!!");
                    filename = System.currentTimeMillis() + "_" + filename;
                    saveFile = new File(savePath, filename);
                    
                }

                // 실제 저장
                photo.transferTo(saveFile);

                
            } else{
                filename=oldfilename;
            }
            // DB에 저장할 경로
            vo.setFilename(filename);

            int res = memberDAO.userUpdate(vo);

            if (res > 0 ) {
                
                if(!oldfilename.equals(vo.getFilename())){
                    File delfile = new File(savePath,oldfilename);
                    if(delfile.exists()){
                        delfile.delete();
                    }
                }
                MemberVO user = memberDAO.getUserByMemberId(vo.getMember_id());

                httpSession.setAttribute("user", user);
                return "redirect:/mypage.do?menu=account";
            } else {
                return "redirect:/mypage.do?menu=update";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
