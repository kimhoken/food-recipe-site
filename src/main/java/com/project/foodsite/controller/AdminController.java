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
import com.project.foodsite.dto.AdminRecipeDTO;
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

    // 카테고리 매핑 함수
    private String categorymapping(String category) {

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

    // 레시피 페이징 함수
    private void RecipePaging(Model model, AdminRecipeDTO adminRecipeDTO) {

        if (adminRecipeDTO.getPage() <= 0) {
            adminRecipeDTO.setPage(1);
        }

        adminRecipeDTO.setCategory(categorymapping(adminRecipeDTO.getCategory_name()));

        int totalcount = recipeDAO.RecipeCount(adminRecipeDTO);

        Paging paging = new Paging(adminRecipeDTO.getPage(), 5, totalcount);

        adminRecipeDTO.setOffset(paging.getOffset());
        adminRecipeDTO.setSize(paging.getSize());

        List<RecipeVO> list = recipeDAO.RecipeList(adminRecipeDTO);

        model.addAttribute("list", list);
        model.addAttribute("paging", paging);
        model.addAttribute("totalcount", totalcount);
        model.addAttribute("searchrecipe", adminRecipeDTO);
    }

    // 관리자 페이지 contentPage 설정 함수
    public void setContentPage(Model model, String menu) {

        String contentPage = "/WEB-INF/views/member/admin/admin_home.jsp";

        if (menu.equals("user")) {
            contentPage = "/WEB-INF/views/member/admin/admin_user.jsp";
        } else if (menu.equals("recipe")) {
            contentPage = "/WEB-INF/views/member/admin/admin_recipe.jsp";
        } else if (menu.equals("stats")) {
            contentPage = "/WEB-INF/views/member/admin/admin_stats.jsp";
        } else if (menu.equals("inquiry")) {
            contentPage = "/WEB-INF/views/member/admin/admin_inquiry.jsp";
        } else if (menu.equals("report")) {
            contentPage = "/WEB-INF/views/member/admin/admin_report.jsp";
        } else if (menu.equals("info")) {
            contentPage = "/WEB-INF/views/member/admin/admin_info.jsp";
        } else if (menu.equals("notice")) {
            contentPage = "/WEB-INF/views/member/admin/admin_notice.jsp";
        }

        model.addAttribute("contentPage", contentPage);

    }

    // 관리자 페이지 이동 함수
    @GetMapping("/admin")
    public String adminpage(Model model) {

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        List<RecipeVO> recentlyRecipe = recipeDAO.recentlyrecipe();

        model.addAttribute("profileuser", user);
        model.addAttribute("list",recentlyRecipe);
        model.addAttribute("contentPage", "/WEB-INF/views/member/admin/admin_home.jsp");

        return "member/adminpage";

    }

    // 레시피 페이지 검색 및 조회
    @GetMapping("/admin/recipe")
    public String adminrecipepage(AdminRecipeDTO adminRecipeDTO, Model model) {

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        model.addAttribute("profileuser", user);

        RecipePaging(model, adminRecipeDTO);

        setContentPage(model, "recipe");
        return "member/adminpage";
    }

    // 레시피 상세 조회 함수
    @PostMapping("/admin/recipe")
    @ResponseBody
    public Map<String, Object> recipedetail(int recipe_id) {

        RecipeVO recipe = recipeDAO.selectrecipe(recipe_id);
        List<CookOrderVO> list = cookOrderDAO.cookorderList(recipe_id);

        Map<String, Object> map = new HashMap<>();
        map.put("recipe", recipe);
        map.put("list", list);
        return map;
    }

    // 레시피 검색 및 페이징 처리 
    @PostMapping("/admin/recipe/search")
    @ResponseBody
    public Map<String, Object> recipesearch(AdminRecipeDTO adminRecipeDTO, Model model) {

        System.out.println("keyword = " + adminRecipeDTO.getKeyword());
        System.out.println("status = " + adminRecipeDTO.getStatus());
        
        
        if (adminRecipeDTO.getPage() <= 0) {
            adminRecipeDTO.setPage(1);
        }
        adminRecipeDTO.setCategory_name(categorymapping(adminRecipeDTO.getCategory_name()));
        System.out.println("category = " + adminRecipeDTO.getCategory_name());
        
        int totalcount = recipeDAO.RecipeCount(adminRecipeDTO);

        Paging paging = new Paging(adminRecipeDTO.getPage(), 5, totalcount);

        adminRecipeDTO.setOffset(paging.getOffset());
        adminRecipeDTO.setSize(paging.getSize());

        List<RecipeVO> list = recipeDAO.RecipeList(adminRecipeDTO);

        Map<String, Object> map = new HashMap<>();

        map.put("list", list);
        map.put("totalcount", totalcount);
        map.put("paging", paging);

        return map;
    }   

    // 레시피 추천 등록/ 해제 함수
    @PostMapping("/admin/recipe/recommend")
    @ResponseBody
    public Map<String, Object> reciperecommend(int recipe_id){
        RecipeVO recipe = recipeDAO.selectrecipe(recipe_id);
        if(recipe.isRecommend()){
            recipe.setRecommend(false);
        }else{
            recipe.setRecommend(true);
        }

        int res = recipeDAO.updateRecipe(recipe);

        Map<String,Object> map = new HashMap<>();

        map.put("result",res );
        map.put("title",recipe.getTitle());
        map.put("recommend",recipe.isRecommend());

        return map;
        }

    // 레시피 공개/비공개 함수
    @PostMapping("/admin/private")
    @ResponseBody
    public Map<String, Object> recipestatus(int recipe_id) {

        RecipeVO recipe = recipeDAO.selectrecipe(recipe_id);
        if (recipe.getStatus().equals("public")) {
            recipe.setStatus("private");
        } else if (recipe.getStatus().equals("private")) {
            recipe.setStatus("public");
        }

        int res = recipeDAO.updateStatus(recipe);

        Map<String, Object> map = new HashMap<>();

        map.put("result", res);
        map.put("title", recipe.getTitle());
        return map;

    }

    // 레시피 삭제/복원 함수
    @PostMapping("/admin/recipedel")
    @ResponseBody
    public Map<String, Object> recipe_delete(int recipe_id) {

        RecipeVO recipe = recipeDAO.selectrecipe(recipe_id);
        if (!recipe.getStatus().equals("delete")) {
            recipe.setStatus("delete");
        } else {
            recipe.setStatus("public");
        }

        int res = recipeDAO.updateStatus(recipe);

        Map<String, Object> map = new HashMap<>();

        map.put("result", res);
        map.put("title", recipe.getTitle());
        map.put("status", recipe.getStatus());

        return map;
    }

}
