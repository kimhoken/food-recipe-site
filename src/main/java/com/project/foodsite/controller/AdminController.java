package com.project.foodsite.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.foodsite.dao.CommentDAO;
import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.RecipeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminController {
    
    @Autowired
    HttpSession httpSession;

    private final MemberDAO memberDAO;
    private final RecipeDAO recipeDAO;
    private final CommentDAO commentDAO;

    // 관리자 페이지 contentPage 설정 함수
    public void setContentPage(Model model, String menu){

        String contentPage = "/WEB-INF/views/member/admin/admin_home.jsp";
        //레시피 일단 조회하는거 넣어놈 수정예정
        List<RecipeVO> list = recipeDAO.recentlyrecipe();
        model.addAttribute("list",list);

        if(menu.equals("user")){    
            contentPage = "/WEB-INF/views/member/admin/admin_user.jsp";
        } else if(menu.equals("recipe")) {
            contentPage = "/WEB-INF/views/member/admin/admin_recipe.jsp";        
        } else if(menu.equals("stats")) {
            contentPage = "/WEB-INF/views/member/admin/admin_stats.jsp";        
        } else if(menu.equals("inquiry")) {
            contentPage = "/WEB-INF/views/member/admin/admin_inquiry.jsp";
        } else if(menu.equals("report")) {
            contentPage = "/WEB-INF/views/member/admin/admin_report.jsp";
        } else if(menu.equals("info")) {
            contentPage = "/WEB-INF/views/member/admin/admin_info.jsp";
        } else if(menu.equals("notice")) {
            contentPage = "/WEB-INF/views/member/admin/admin_notice.jsp";
        }

        model.addAttribute("contentPage",contentPage);

    }  

    // 관리자 페이지 이동 함수
    @GetMapping("/admin")
    public String adminpage(Model model, String menu){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        if(user == null){
            setContentPage(model, menu);
            return "member/adminpage";
        }
        if(menu == null){
            menu = "home";
        }

        

        model.addAttribute("profileuser",user);
        model.addAttribute("menu",menu);

        setContentPage(model, menu);
        return "member/adminpage";

    }


}
