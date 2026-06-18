package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.common.Paging;
import com.project.foodsite.dao.CommentDAO;
import com.project.foodsite.dao.CookOrderDAO;
import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.dto.AdminRecipeDetailDTO;
import com.project.foodsite.dto.RecipeSearchDTO;
import com.project.foodsite.vo.CookOrderVO;
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
    private final CookOrderDAO cookOrderDAO;
    
  

     //레시피 페이징 함수
    private void RecipePaging(int page, Model model){
        

        int totalcount = recipeDAO.RecipeCount();

        Paging paging = new Paging(page, 5, totalcount);

        Map<String,Object> map = new HashMap<>();
        
        map.put("offset", paging.getOffset());
        map.put("size", paging.getSize());

        List<RecipeVO> list = recipeDAO.RecipeList(map);

        model.addAttribute("list", list);
        model.addAttribute("paging", paging);
        model.addAttribute("totalcount", totalcount);
    }


    // 관리자 페이지 contentPage 설정 함수
    public void setContentPage(Model model, String menu, int page){

        String contentPage = "/WEB-INF/views/member/admin/admin_home.jsp";
        //레시피 일단 조회하는거 넣어놈 수정예정
        List<RecipeVO> list = recipeDAO.recentlyrecipe();
        model.addAttribute("list",list);

        if(menu.equals("user")){    
            contentPage = "/WEB-INF/views/member/admin/admin_user.jsp";
        } else if(menu.equals("recipe")) {            
            RecipePaging(page, model);
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
    public String adminpage(Model model, String menu, Integer page){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");
        
        if(page == null){
            page = 1;
        }
        if(user == null){
            setContentPage(model, menu, page);
            return "member/adminpage";
        }
        if(menu == null){
            menu = "home";
        }
        

        model.addAttribute("profileuser",user);
        model.addAttribute("menu",menu);

        setContentPage(model, menu, page);
        return "member/adminpage";

    }

    @PostMapping("/admin/recipe")
    @ResponseBody
    public Map<String, Object> recipedetail(int recipe_id){


       

        RecipeVO recipe = recipeDAO.selectrecipe(recipe_id);
        List<CookOrderVO> list=cookOrderDAO.cookorderList(recipe_id);

        Map<String, Object> map = new HashMap<>();
        map.put("recipe",recipe);
        map.put("list",list);
        return map;
    }

}
