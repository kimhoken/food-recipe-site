package com.project.foodsite.controller;

import java.io.File;
import java.security.SecureRandom;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

            @RequestParam(value = "image", required = false) MultipartFile[] images,

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

        String inquiryCode = createInquiryCode(vo.getInquiry_id());

        vo.setInquiry_code(inquiryCode);

        inquiryDao.updateInquiryCode(vo);

        if (images != null && images.length > 0) {
            
            String savePath = "/Users/shinyeyoung/upload/";

            File dir = new File(savePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            for (MultipartFile image : images) {

                if (image == null || image.isEmpty()) {
                    continue;
                }

                String filename = image.getOriginalFilename();

                long time = System.currentTimeMillis();
                filename = time + "_" + filename;

                File saveFile = new File(savePath, filename);

                image.transferTo(saveFile);

                ImgVO img = new ImgVO();
                img.setImage_list(filename);
                img.setInquiry_id(vo.getInquiry_id());

                imgDao.img_insert(img);
            }
        }

        return "redirect:/main_list.do";
    }

    @GetMapping("/guest/inquiry/check")
    public String guestInquiryPasswordForm(
            @RequestParam("code") String inquiry_code,
            Model model
    ) {

        model.addAttribute("inquiry_code", inquiry_code);
        return "inquiry/guestInquiryPasswordForm";
    }

    @PostMapping("/guest/inquiry/check")
    public String guestInquiryCheck(
            @RequestParam("inquiry_code") String inquiry_code,
            @RequestParam("guest_password") String guest_password,
            Model model
    ) {

        InquiryVO vo = inquiryDao.guestInquiryCode(inquiry_code);

        if (vo == null) {

            model.addAttribute("msg", "존재하지 않는 문의입니다.");
            model.addAttribute("inquiry_code", inquiry_code);
            return "inquiry/guestInquiryPasswordForm";
        }

        boolean pwdCheck = pwdSecurity.pwdDecoding(guest_password, vo.getGuest_password());

        if (!pwdCheck) {
            model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
            model.addAttribute("inquiry_code", inquiry_code);
            return "inquiry/guestInquiryPasswordForm";
        }
        

        List<ImgVO> imgList = imgDao.img_select_inquiry(vo.getInquiry_id());

        model.addAttribute("vo", vo);


        model.addAttribute("imgList", imgList);

        return "inquiry/guestInquiryDetail";
    }

    private String createToken() {
        SecureRandom secureRandom = new SecureRandom();

        byte[] bytes = new byte[16];
        secureRandom.nextBytes(bytes);

        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(bytes);
    }

    private String createInquiryCode(Integer inquiryId) {
        String date = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        String token = createToken();

        return "INQ-" + date + "-" + inquiryId + "-" + token;
    }
}