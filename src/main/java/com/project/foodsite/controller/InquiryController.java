package com.project.foodsite.controller;

import java.io.File;
import java.security.SecureRandom;
import java.time.LocalDate; 
import java.time.format.DateTimeFormatter; 
import java.util.Base64; 

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.common.pwdSecurity;
import com.project.foodsite.dao.ImgDAO;
import com.project.foodsite.dao.InquiryDAO;
import com.project.foodsite.vo.ImgVO;
import com.project.foodsite.vo.InquiryVO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class InquiryController {

    private final InquiryDAO inquiryDao;
    private final ImgDAO imgDao;
    private final pwdSecurity pwdSecurity;

    @GetMapping("/inquiry")
    public String inquiryform() {
        return "inquiry/inquiryForm";
    }

    @PostMapping("/inquiry")
    public String insertInquiry(
            InquiryVO vo,
            @RequestParam(value = "image", required = false) MultipartFile image,
            HttpSession session
    ) throws Exception {

        MemberVO user = (MemberVO) session.getAttribute("user");

        vo.setStatus("n");

        if (user != null) {

            vo.setMember_id(user.getMember_id());

            vo.setGuest_name(null);
            vo.setGuest_email(null);
            vo.setGuest_password(null);
        } else {
            String encPwd = pwdSecurity.pwdEncoding(vo.getGuest_password());
            vo.setGuest_password(encPwd);
        }

        inquiryDao.insertInquiry(vo);

        System.out.println("생성된 inquiry_id = " + vo.getInquiry_id());

        String inquiryCode = createInquiryCode(vo.getInquiry_id());

        vo.setInquiry_code(inquiryCode);

        inquiryDao.updateInquiryCode(vo);

        if (image != null && !image.isEmpty()) {

            String savePath = "/Users/shinyeyoung/upload/";

            File dir = new File(savePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String filename = image.getOriginalFilename();

            // 파일명 중복 방지를 위해 시간
            long time = System.currentTimeMillis();
            filename = time + "_" + filename;

            File saveFile = new File(savePath, filename);

            image.transferTo(saveFile);

            ImgVO img = new ImgVO();
            img.setImage_list(filename);
            img.setInquiry_id(vo.getInquiry_id());

            imgDao.img_insert(img);
        }

        return "redirect:/main_list.do";
    }

    // 랜덤 토큰 생성 (메일 토큰 있는거 아는데.. 너무 길어서 줄인거 수정예정)
    private String createToken() {
        SecureRandom secureRandom = new SecureRandom();

        byte[] bytes = new byte[16];
        secureRandom.nextBytes(bytes);

        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(bytes);
    }

    // 문의코드 생성 (INQ+ 문의 작성 날짜+ inquiry_id+ 랜덤토큰생성)
    private String createInquiryCode(Integer inquiryId) {
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String token = createToken();

        return "INQ-" + date + "-" + inquiryId + "-" + token;
    }
}