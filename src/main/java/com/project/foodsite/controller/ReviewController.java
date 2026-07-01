package com.project.foodsite.controller;

import com.project.foodsite.common.ViewCount;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.foodsite.dao.ReviewDAO;
import com.project.foodsite.dto.AdminReviewDTO;
import com.project.foodsite.dto.ReviewDetailDTO;
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

    private final ViewCount viewCount;

    @Autowired
    HttpSession httpSession;
    
    private final ReviewDAO reviewDao;
    private final RecipeDAO recipeDao;
    private final Fileupload fileupload;
    private final ImgDAO imgDAO;

    // ReviewController(ViewCount viewCount) {
    //     this.viewCount = viewCount;
    // } 

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
                
                int review_id = review.getReview_id();

                if(filenames != null && !filenames.isEmpty()){

                    ImgVO img = new ImgVO();
    
                    img.setImage_list(filenames);
                    img.setReview_id(review_id);
    
                    imgDAO.img_insert_review(img);
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

    @PostMapping("/review/detail")
    @ResponseBody
    public ReviewDetailDTO reviewdetail(int review_id){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        viewCount.increaseReview(review_id);

        ReviewDetailDTO review = reviewDao.selectreview(review_id);


        if(review.getImage_list() != null && !review.getImage_list().isBlank()){
            review.setImgList(Arrays.asList(review.getImage_list().split(",")));
        }

        if(user == null){
            review.setOwner(false);
        }else{
            review.setOwner(review.getMember_id() == user.getMember_id());
        }        

        return review;
    }

    @PostMapping("/review/delete")
    @ResponseBody
    public Map<String, Object> reviewDelete( int review_id ) {
        
        Map<String, Object> map = new HashMap<>();

        ReviewDetailDTO review = reviewdetail(review_id);

        if (review.getImage_list() != null && review.getImage_list().isBlank()){
            fileupload.deleteFiles(review.getImage_list(), "review");
        }

        imgDAO.img_delete(review.getReview_id());

        map.put("title", review.getTitle());

        int res = reviewDao.deletereview(review_id);

        map.put("result", res);

        return map;


    }

    @GetMapping("/review/modify")
    public String reviewmodify( Model model, int review_id ){

        ReviewDetailDTO review = reviewDao.selectreview(review_id);

        if(review.getImage_list() != null && !review.getImage_list().isBlank()){
            review.setImgList(Arrays.asList(review.getImage_list().split(",")));
        }

        model.addAttribute("review", review);

        return "review/review_modify";

    }

    @PostMapping("/review/modify")
    @ResponseBody
    public Map<String,Object> reviewModifyFin(ReviewVO review, String deleteImages){
        Map<String,Object> map =  new HashMap<>();

        ImgVO img = imgDAO.img_select(review.getImg_id());

        img.setImage_list(deleteImages);

        imgDAO.img_update(img);
       
        return map;

    }

}
