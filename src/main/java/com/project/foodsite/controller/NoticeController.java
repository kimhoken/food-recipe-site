package com.project.foodsite.controller;

import java.io.File;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.dao.NoticeDAO;
import com.project.foodsite.vo.ImgVO;
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
    public String getArticleList(
            Model model,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "search_text", defaultValue = "") String search_text) {

        int pageSize = 8;
        int pageBlock = 5;

        int start = (page - 1) * pageSize;

        List<NoticeVO> notice = noticeDao.selectList(start, pageSize, search_text);

        int totalCount = noticeDao.notice_count(search_text);

        int totalPage = (int) Math.ceil((double) totalCount / pageSize);

        int startPage = ((page - 1) / pageBlock) * pageBlock + 1;
        int endPage = startPage + pageBlock - 1;

        if (endPage > totalPage) {
            endPage = totalPage;
        }

        String pageMenu = "";

        if (startPage > 1) {
            pageMenu += "<a href='notice.do?page=" + (startPage - 1)
                    + "&search_text=" + search_text + "'>◀</a> ";
        }

        for (int i = startPage; i <= endPage; i++) {
            if (i == page) {
                pageMenu += "<b>" + i + "</b> ";
            } else {
                pageMenu += "<a href='notice.do?page=" + i
                        + "&search_text=" + search_text + "'>" + i + "</a> ";
            }
        }

        if (endPage < totalPage) {
            pageMenu += "<a href='notice.do?page=" + (endPage + 1)
                    + "&search_text=" + search_text + "'>▶</a>";
        }

        model.addAttribute("notice", notice);
        model.addAttribute("page", page);
        model.addAttribute("pageMenu", pageMenu);
        model.addAttribute("search_text", search_text);
        model.addAttribute("totalCount", totalCount);

        return "notice/notice_list";
    }

    @GetMapping("/notice_detail.do")
    public String viewNotice(Model model, int notice_id) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user != null) {
            int result = noticeDao.viewHistory(notice_id, user.getMember_id());

            if (result > 0) {
                noticeDao.userViewCount(notice_id);
            }

        } else {
            String viewedNotice = (String) session.getAttribute("viewedNotice");

            if (viewedNotice == null) {
                viewedNotice = "";
            }

            String currentNotice = "[" + notice_id + "]";

            if (!viewedNotice.contains(currentNotice)) {
                noticeDao.userViewCount(notice_id);
                viewedNotice += currentNotice;
                session.setAttribute("viewedNotice", viewedNotice);
            }
        }

        NoticeVO vo = noticeDao.noticeView(notice_id);

        ImgVO img = null;
        if (vo.getImg_id() != null) {
            img = noticeDao.img_select(vo.getImg_id());
        }

        model.addAttribute("notice", vo);
        model.addAttribute("img", img);

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
    public String noticeAdd_fin(
            NoticeVO vo,
            @RequestParam(value = "images", required = false) MultipartFile image
    ) throws Exception {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:notice.do";
        }

        vo.setMember_id(user.getMember_id());

        if (image != null && !image.isEmpty()) {

            // String savePath = "C:/upload/"; 윈도우버전

            String savePath = "/Users/shinyeyoung/upload/";

            File dir = new File(savePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String filename = image.getOriginalFilename();
            File saveFile = new File(savePath, filename);

            if (saveFile.exists()) {
                long time = System.currentTimeMillis();
                filename = time + "_" + filename;
                saveFile = new File(savePath, filename);
            }

            image.transferTo(saveFile);

            ImgVO img = new ImgVO();
            img.setImage_list(filename);

            noticeDao.img_insert(img);

            vo.setImg_id(img.getImg_id());
        }

        noticeDao.notice_insert(vo);

        return "redirect:notice.do";
    }

    @GetMapping("/notice_update.do")
    public String noticeUpdate_form(int notice_id, Model model) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/notice.do";
        }

        NoticeVO vo = noticeDao.noticeView(notice_id);

        ImgVO img = null;
        if (vo.getImg_id() != null) {
            img = noticeDao.img_select(vo.getImg_id());
        }

        model.addAttribute("notice", vo);
        model.addAttribute("img", img);

        return "notice/update_form";
    }

    @PostMapping("/notice_update.do")
    public String noticeUpdate_fin(
            NoticeVO vo,

            // 수정: 새 이미지 파일 받기
            @RequestParam(value = "images", required = false) MultipartFile image,

            // 수정: 기존 이미지 id 받기
            @RequestParam(value = "ori_img_id", required = false) Integer ori_img_id
    ) throws Exception {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/notice.do";
        }

        // 수정: 새 이미지가 있을 때
        if (image != null && !image.isEmpty()) {

            String savePath = "/Users/shinyeyoung/upload/";

            File dir = new File(savePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            String filename = image.getOriginalFilename();
            File saveFile = new File(savePath, filename);

            if (saveFile.exists()) {
                long time = System.currentTimeMillis();
                filename = time + "_" + filename;
                saveFile = new File(savePath, filename);
            }

            image.transferTo(saveFile);

            ImgVO img = new ImgVO();
            img.setImage_list(filename);

            noticeDao.img_insert(img);

            // 수정: 새 이미지 id 저장
            vo.setImg_id(img.getImg_id());

        } else {
            // 수정: 새 이미지 없으면 기존 이미지 유지
            // X 눌렀으면 ori_img_id가 null로 들어와서 이미지 제거됨
            vo.setImg_id(ori_img_id);
        }

        noticeDao.notice_update(vo);

        return "redirect:/notice_detail.do?notice_id=" + vo.getNotice_id();
    }

    @GetMapping("/notice_delete.do")
    public String noticeDelete(int notice_id) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:notice.do";
        }

        noticeDao.notice_delete(notice_id);

        return "redirect:notice.do";
    }
}