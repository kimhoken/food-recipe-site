package com.project.foodsite.dto;

import java.util.Date;

import lombok.Data;

@Data
public class GuideDTO {
    
    private long guide_id; //가이드번호
    private String title;  //제목
    private String sub_title; //작은제목
    private String image; //대표이미지
    private String tab;          // storage, trim, tip, etc
    private String content;      // 상세 설명
    private Date created_at;     // 등록일

}
