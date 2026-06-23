package com.project.foodsite.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.foodsite.common.MailSendService;
import com.project.foodsite.common.Paging;
import com.project.foodsite.dao.ImgDAO;
import com.project.foodsite.dao.InquiryDAO;
import com.project.foodsite.vo.ImgVO;
import com.project.foodsite.vo.InquiryVO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminInquiryController {

    private final InquiryDAO inquiryDao;
    private final MailSendService mailSendService;
    private final ImgDAO imgDao;

    @GetMapping("/admin/inquiry")
    public String adminInquiryList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "") String status,
            @RequestParam(defaultValue = "") String sort,
            @RequestParam(defaultValue = "") String type,
            HttpSession session,
            Model model
    ) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/main_list.do";
        }

        if (page <= 0) {
            page = 1;
        }

        List<InquiryVO> allList = inquiryDao.adminInquiryList();

        if (!status.isBlank()) { 
            allList.removeIf(vo -> !status.equals(vo.getStatus()));
        }

        if (!type.isBlank()) { 
            allList.removeIf(vo -> !type.equals(vo.getType()));
        }

       if ("oldest".equals(sort)) {
            allList.sort((a, b) ->
                Long.compare(a.getInquiry_id(), b.getInquiry_id()));

        } else if ("title".equals(sort)) {

            allList.sort((a, b) ->
                a.getTitle().compareToIgnoreCase(b.getTitle()));

        } else {

            allList.sort((a, b) ->
                Long.compare(b.getInquiry_id(), a.getInquiry_id()));
        }

        int totalcount = allList.size();

        Paging paging = new Paging(page, 10, totalcount);

        int start = paging.getOffset();

        if (start > totalcount) {
            page = 1;
            paging = new Paging(page, 10, totalcount);
            start = paging.getOffset();
        }

        int end = Math.min(start + paging.getSize(), totalcount);

        List<InquiryVO> list = allList.subList(start, end);

        model.addAttribute("list", list);
        model.addAttribute("paging", paging);
        model.addAttribute("totalcount", totalcount);
        model.addAttribute("page", page);

        model.addAttribute("status", status);
        model.addAttribute("sort", sort);    
        model.addAttribute("type", type);     

        model.addAttribute("menu", "inquiry");
        model.addAttribute("contentPage", "/WEB-INF/views/inquiry/adminInquiryList.jsp");

        return "member/adminpage";
    }

    @GetMapping("/inquiry/admin/detail")
    public String adminInquiryDetail(
            @RequestParam("inquiry_id") int inquiry_id,
            HttpSession session,
            Model model
    ) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/main_list.do";
        }

        InquiryVO vo = inquiryDao.adminInquiryDetail(inquiry_id);

        List<ImgVO> imgList = imgDao.img_select_inquiry(inquiry_id);

        model.addAttribute("vo", vo);

        model.addAttribute("imgList", imgList);

        return "inquiry/adminInquiryDetail";
    }

    @PostMapping("/inquiry/admin/answer")
    public String answerInquiry(
            InquiryVO vo,
            HttpSession session
    ) {

        MemberVO admin = (MemberVO) session.getAttribute("user");

        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            return "redirect:/main_list.do";
        }

        vo.setAdmin_id(admin.getMember_id());

        inquiryDao.answerInquiry(vo);

        InquiryVO inquiry = inquiryDao.adminInquiryDetail(vo.getInquiry_id());

        if (inquiry.getGuest_email() != null && !inquiry.getGuest_email().isEmpty()) {

            String createdDate = new SimpleDateFormat("yyyy-MM-dd")
                    .format(inquiry.getCreated_date());

            mailSendService.sendInquiryAnswerEmail(
                    inquiry.getGuest_email(),
                    inquiry.getInquiry_code(),
                    inquiry.getTitle(),
                    inquiry.getType(),
                    createdDate
            );
        }

        return "redirect:/inquiry/admin/detail?inquiry_id=" + vo.getInquiry_id();
    }
}