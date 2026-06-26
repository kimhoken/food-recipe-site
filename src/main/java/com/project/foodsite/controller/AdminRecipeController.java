package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.common.AdminUtil;
import com.project.foodsite.common.Paging;
import com.project.foodsite.dao.CookOrderDAO;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.dto.AdminRecipeDTO;
import com.project.foodsite.vo.CookOrderVO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.RecipeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminRecipeController {

    private final HttpSession httpSession;
    private final AdminUtil adminUtil;
    private final RecipeDAO recipeDAO;
    private final CookOrderDAO cookOrderDAO;


    // 레시피 페이징 함수
    private void RecipePaging(Model model, AdminRecipeDTO adminRecipeDTO) {

        if (adminRecipeDTO.getPage() <= 0) {
            adminRecipeDTO.setPage(1);
        }

        adminRecipeDTO.setCategory(adminUtil.categorymapping(adminRecipeDTO.getCategory_name()));

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


    // 레시피 페이지 검색 및 조회
    @GetMapping("/admin/recipe")
    public String adminrecipepage(AdminRecipeDTO adminRecipeDTO, Model model) {

        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        model.addAttribute("profileuser", user);

        RecipePaging(model, adminRecipeDTO);

        adminUtil.setContentPage(model, "recipe");
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
        adminRecipeDTO.setCategory_name(adminUtil.categorymapping(adminRecipeDTO.getCategory_name()));
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
