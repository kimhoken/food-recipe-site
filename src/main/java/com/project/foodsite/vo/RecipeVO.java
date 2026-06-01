package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("recipe")
public class RecipeVO {
    //레시피 테이블
    private int recipe_id;
    private String title;
    private String thumbnail;
    private String cooking_time;
    private String diffuculty;
    private int view_count;
    private int like_count;
    private String status;
    private String created_date;
    private String updated_date;
    private int member_id;
    private int bookmark_id;
    private int nutrition_id;
    private int category_id;

    //불러올때 필요한것 추가
    private String nickname;    //member_id로 닉네임 불러옴

}
