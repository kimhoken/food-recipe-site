package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.dao.ReviewDAO;
import com.project.foodsite.vo.ImgVO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.RecipeVO;
import com.project.foodsite.vo.ReviewVO;

import jakarta.servlet.http.HttpSession;

import com.project.foodsite.common.Fileupload;
import com.project.foodsite.dao.ImgDAO;
import com.project.foodsite.dao.RecipeDAO;


import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final HttpSession httpSession;
    private final ReviewDAO reviewDao;
    private final RecipeDAO recipeDao;
    private final Fileupload fileupload;
    private final ImgDAO imgDAO; 

    @GetMapping("/review/insert")
    public String review_insert_page( Model model ,int recipe_id ){

        RecipeVO recipe = recipeDao.selectOne(recipe_id);

        model.addAttribute("recipe", recipe);

        return "review/review_insert";
    }

    @PostMapping("/review/insert")
    @ResponseBody
    public Map<String, Object> reviewinsert(ReviewVO review){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        review.setMember_id(user.getMember_id());
        
        List<MultipartFile> files = review.getPhoto();

        Map<String, Object> map = new HashMap<>();

        if (files != null && !files.isEmpty()){
            try {
                String filenames = fileupload.saveFiles(files, "review");

                review.setThumbnail(filenames.split(",")[0]);

                int res = reviewDao.reviewInsert(review);

                if(res == 0){
                    map.put("result", "fail");
                    return  map;
                }
                
                long review_id = review.getRecipe_id();

                if(filenames != null && !filenames.isEmpty()){

                    ImgVO img = new ImgVO();
    
                    img.setImage_list(filenames);
                    img.setReview_id((int) review_id);
    
                    imgDAO.img_insert(img);
                }

                map.put("result", "success");

                return map;


            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                map.put("result","error");
                return map;
            }
            
        } else {
            map.put("result","error");
            return map;
        }
        


    }

}