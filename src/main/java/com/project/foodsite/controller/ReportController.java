package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.foodsite.dao.ReportDAO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.ReportVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReportController {

    private final ReportDAO reportDao;
    private final HttpSession session;

    @GetMapping("/report/form.do")
    public String reportForm() {

        return "report/report_form";
    }

    @PostMapping("/report/insert.do")
    public String reportInsert(ReportVO vo) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/report/form.do";
        }

        vo.setMember_id(user.getMember_id());

        reportDao.reportInsert(vo);

        return "redirect:/main_list.do";
    }

    @GetMapping("/report/admin/list.do")
    public String reportAdminList(Model model) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "report/report_adminList";
        }

        List<ReportVO> list = reportDao.reportList();
        model.addAttribute("list", list);

        return "report/report_adminList";
    }
}