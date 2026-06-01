package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.foodsite.dao.NoticeDAO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.NoticeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeDAO noticeDao;
    private final HttpSession session;

    @GetMapping("/notice.do")
    public String getArticleList(Model model) {
        List<NoticeVO> notice = noticeDao.selectAll();
        model.addAttribute("notice", notice);
        return "notice/notice_list";
    }

    @GetMapping("/notice_detail.do")
    public String viewNotice(Model model, int notice_id) {
        NoticeVO vo = noticeDao.noticeView(notice_id);
        model.addAttribute("notice", vo);
        return "notice/detail_view";
    }

    @GetMapping("/notice_add.do")
    public String noticeAdd_form() {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:notice.do";
        }

        return "notice/add_form";
    }

    @PostMapping("/notice_add.do")
    public String noticeAdd_fin(NoticeVO vo) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:notice.do";
        }

        vo.setMember_id(user.getMember_id());

        noticeDao.notice_insert(vo);

        return "redirect:notice.do";
    }

    @GetMapping("/notice_delete.do")
    public String noticeDelete(int notice_id) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/notice.do";
        }

        noticeDao.notice_delete(notice_id);

        return "redirect:/notice.do";
    }

    @GetMapping("/notice_update.do")
    public String noticeUpdate_form(int notice_id, Model model) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/notice.do";
        }

        NoticeVO vo = noticeDao.noticeView(notice_id);
        model.addAttribute("notice", vo);

        return "notice/update_form";
    }

    @PostMapping("/notice_update.do")
    public String noticeUpdate_fin(NoticeVO vo) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/notice.do";
        }

        noticeDao.notice_update(vo);

        return "redirect:/notice_detail.do?notice_id=" + vo.getNotice_id();
    }
}