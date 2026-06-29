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

    private int seasonId;
    private String seasonName;  //봄,여름,가을,겨울
    private String bannerTitle; //배너 메인 타이틀
    private String bannerDesc; //배너 서브 설명
    private long foodId; //음식ID
    private String subDesc; //음식 한 줄 설명
    private String customImage; //이미지

    private String foodName; //food 테이블 음식명 
}
