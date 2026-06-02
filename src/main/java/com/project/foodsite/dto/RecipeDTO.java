package com.project.foodsite.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //getter, setter
@AllArgsConstructor
@NoArgsConstructor
@Alias("RecipeDTO")
public class RecipeDTO {
    
    private String title;

    private int memberId;

    private int recipeId;
    //img (메인, 조리순서), input name=img를 list로 받아
    private MultipartFile mainImg;
    private String mainImgName;
    private List<MultipartFile> img;

    //채소
    private List<String> vegetableName;
    private List<String> amountV;
    private List<String> unitV;

    //육류
    private List<String> meatName;
    private List<String> amountM;
    private List<String> unitM;

    //양념
    private List<String> seasoningName;
    private List<String> amountS;
    private List<String> unitS;

    //조리순서
    private List<String> step; 
}
