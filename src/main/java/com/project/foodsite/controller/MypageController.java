package com.project.foodsite.controller;

import java.io.File;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {

    @Autowired
    HttpSession httpSession;

    private final MemberDAO memberDAO;

    @GetMapping("/mypage.do")
    public String gomypage(Model model, String menu, String sel) {

        MemberVO user = (MemberVO) httpSession.getAttribute("User");

        model.addAttribute("user", user);

        model.addAttribute("sel", sel);

        if (menu == null || menu.equals("account")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_info.jsp");
        } else if (menu.equals("activity")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_activity.jsp");
        } else if (menu.equals("inquiry")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_inquiry.jsp");
        } else if (menu.equals("update")) {
            model.addAttribute("contentPage", "/WEB-INF/views/member/mypage/mypage_modify.jsp");
        }

        return "member/mypage";
    }

    @PostMapping("/mypage.do")
    @ResponseBody
    public String update(MemberVO vo) {

        String savePath = "C:/upload";

        MultipartFile photo = vo.getPhoto();

        try {

            if (photo != null && !photo.isEmpty()) {

                File dir = new File(savePath);

                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String filename = photo.getOriginalFilename();

                File saveFile = new File(savePath, filename);

                if (saveFile.exists()) {
                    filename = System.currentTimeMillis() + "_" + filename;
                    saveFile = new File(savePath, filename);
                }

                // 실제 저장
                photo.transferTo(saveFile);

                // DB에 저장할 경로
                vo.setProfile_img("/upload/" + filename);
            }

            int res = memberDAO.userUpdate(vo);

            return res > 0 ? "fin" : "no";

        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

}
