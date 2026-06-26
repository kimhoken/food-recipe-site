package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.foodsite.dao.ReportDAO;
import com.project.foodsite.vo.BoardVO;
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
    public String reportForm(ReportVO vo, Model model) {

        if (vo.getBoard_id() != null) {
            BoardVO board = reportDao.selectBoardForReport(vo.getBoard_id());
            model.addAttribute("board", board);
        }

        return "report/report_form";
    }

    @PostMapping("/report/insert.do")
    public String reportInsert(ReportVO vo) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login.do";
        }

        vo.setMember_id(user.getMember_id());

        boolean noTarget =
                vo.getBoard_id() == null &&
                vo.getComment_id() == null &&
                vo.getRecipe_id() == null &&
                vo.getReview_id() == null;

        if (noTarget) {
            return "redirect:/main_list.do";
        }

        System.out.println("===== 신고 등록 값 확인 =====");
        System.out.println("target_type = " + vo.getTarget_type());
        System.out.println("board_id = " + vo.getBoard_id());
        System.out.println("comment_id = " + vo.getComment_id());
        System.out.println("recipe_id = " + vo.getRecipe_id());
        System.out.println("review_id = " + vo.getReview_id());
        System.out.println("member_id = " + vo.getMember_id());
        
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