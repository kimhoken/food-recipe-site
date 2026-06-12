package com.project.foodsite.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
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

    private final String savePath = "/Users/shinyeyoung/upload/";

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

            if (result == 0) {
                noticeDao.userViewCount(notice_id);
                noticeDao.viewInsert(notice_id, user.getMember_id());
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

        ImgVO img = noticeDao.notice_img_select(notice_id);

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

            @RequestParam(value = "images", required = false) List<MultipartFile> images
    ) throws Exception {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:notice.do";
        }

        vo.setMember_id(user.getMember_id());

        noticeDao.notice_insert(vo);

        File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        List<String> fileNames = new ArrayList<>();

        if (images != null && !images.isEmpty()) {
            for (MultipartFile image : images) {

                if (image == null || image.isEmpty()) {
                    continue;
                }

                String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                File saveFile = new File(savePath, filename);

                if (saveFile.exists()) {
                    filename = System.currentTimeMillis() + "_" + filename;
                    saveFile = new File(savePath, filename);
                }

                image.transferTo(saveFile);
                fileNames.add(filename);
            }
        }

        if (!fileNames.isEmpty()) {
            ImgVO img = new ImgVO();
            img.setNotice_id(vo.getNotice_id());

            img.setImage_list(String.join(",", fileNames));

            noticeDao.notice_img_insert(img);
        }

        return "redirect:notice.do";
    }

    @GetMapping("/notice_update.do")
    public String noticeUpdate_form(int notice_id, Model model) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/notice.do";
        }

        NoticeVO vo = noticeDao.noticeView(notice_id);
        ImgVO img = noticeDao.notice_img_select(notice_id);

        model.addAttribute("notice", vo);
        model.addAttribute("img", img);

        return "notice/update_form";
    }

    @PostMapping("/notice_update.do")
    public String noticeUpdate_fin(
            NoticeVO vo,

            @RequestParam(value = "images", required = false) List<MultipartFile> images,

            @RequestParam(value = "delete_image", required = false) List<String> delete_image
    ) throws Exception {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:/notice.do";
        }

        noticeDao.notice_update(vo);

        File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        ImgVO oldImg = noticeDao.notice_img_select(vo.getNotice_id());

        List<String> fileNames = new ArrayList<>();

        if (oldImg != null
                && oldImg.getImage_list() != null
                && !oldImg.getImage_list().trim().isEmpty()) {

            // 콤마 기준으로 분리
            fileNames.addAll(Arrays.asList(oldImg.getImage_list().split(",")));
        }

        // X 누른 기존 이미지 제거
        if (delete_image != null && !delete_image.isEmpty()) {
            fileNames.removeAll(delete_image);
        }

        if (images != null && !images.isEmpty()) {
            for (MultipartFile image : images) {

                if (image == null || image.isEmpty()) {
                    continue;
                }

                String filename = System.currentTimeMillis() + "_" + image.getOriginalFilename();
                File saveFile = new File(savePath, filename);

                if (saveFile.exists()) {
                    filename = System.currentTimeMillis() + "_" + filename;
                    saveFile = new File(savePath, filename);
                }

                image.transferTo(saveFile);
                fileNames.add(filename);
            }
        }

        if (fileNames.isEmpty()) {
            noticeDao.notice_img_delete(vo.getNotice_id());

        } else {
            ImgVO img = new ImgVO();
            img.setNotice_id(vo.getNotice_id());

            img.setImage_list(String.join(",", fileNames));

            if (oldImg == null) {
                noticeDao.notice_img_insert(img);
            } else {
                noticeDao.notice_img_update(img);
            }
        }

        return "redirect:/notice_detail.do?notice_id=" + vo.getNotice_id();
    }

    @GetMapping("/notice_delete.do")
    public String noticeDelete(int notice_id) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            return "redirect:notice.do";
        }

        noticeDao.notice_img_delete(notice_id);
        noticeDao.notice_delete(notice_id);

        return "redirect:notice.do";
    }
}