package com.project.foodsite.common;

import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class AdminUtil {
    

    // 카테고리 매핑 함수
    public String categorymapping(String category) {

        if (category == null || category.isBlank()) {
            return null;
        }
        switch (category) {
            case "korean":
                return "한식";
            case "recommend":
                return "상황별추천";
            case "western":
                return "양식";
            case "chinese":
                return "중식";
            case "japanese":
                return "일식";
            case "asian":
                return "아시안";
            case "healthy":
                return "건강식/다이어트";
            case "quick":
                return "초간단요리";
            case "dessert":
                return "디저트";
            case "baking":
                return "베이킹";
            case "beverage":
                return "음료/차";
            default:
                return null;
        }
    }


    // 관리자 페이지 contentPage 설정 함수
    public void setContentPage(Model model, String menu) {

        String contentPage = "/WEB-INF/views/member/admin/admin_home.jsp";

        if (menu.equals("member")) {
            contentPage = "/WEB-INF/views/member/admin/admin_member.jsp";
        } else if (menu.equals("recipe")) {
            contentPage = "/WEB-INF/views/member/admin/admin_recipe.jsp";
        } else if (menu.equals("status")) {
            contentPage = "/WEB-INF/views/member/admin/admin_stats.jsp";
        } else if (menu.equals("inquiry")) {
            contentPage = "/WEB-INF/views/member/admin/admin_inquiry.jsp";
        } else if (menu.equals("report")) {
            contentPage = "/WEB-INF/views/member/admin/admin_report.jsp";
        } else if (menu.equals("info")) {
            contentPage = "/WEB-INF/views/member/admin/admin_info.jsp";
        } else if (menu.equals("notice")) {
            contentPage = "/WEB-INF/views/member/admin/admin_notice.jsp";
        } else if (menu.equals("comment")){
            contentPage = "/WEB-INF/views/member/admin/admin_comment.jsp";
        } else if(menu.equals("recipecomment")){
            contentPage = "/WEB-INF/views/member/admin/admin_recipe_comment.jsp";            
        } else if(menu.equals("board")){
            contentPage = "/WEB-INF/views/member/admin/admin_board.jsp";            
        }

        model.addAttribute("contentPage", contentPage);

    }

}
