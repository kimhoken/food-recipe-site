package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("seasons")
public class SeasonsVO {

    private int season_id;
    private String season_name;  //봄,여름,가을,겨울
    private String banner_title; //배너 메인 타이틀
    private String banner_desc; //배너 서브 설명
    private long food_id; //음식ID
    private String sub_desc; //음식 한 줄 설명
    private String custom_image; //이미지

    private String food_name; //food 테이블 음식명 
}
