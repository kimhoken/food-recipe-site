package com.project.foodsite.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data //getter, setter
@AllArgsConstructor
@NoArgsConstructor
@Alias("RecipeSearchDTO")
public class RecipeSearchDTO {     // 사용자가 레시피 목록 페이지에서 선택하는 검색 조건(카테고리 필터, 조리시간 필터, 정렬(최신순..), 검색창)
     // 카테고리
    private String category;

    // 조리시간 (체크박스 여러 개 선택 가능)
    private List<String> cookTimes;

    //조리시간 가장 큰 시간 담을 곳
    private int maxCookTime;
    //조리시간 가장 작은 시간 
    private int minCookTime;

    // 정렬
    // latest : 최신순
    // view   : 조회수순
    // like   : 좋아요순
    private String sort;

    // 검색창용
    private String keyword;  

    //페이징 처리
    private int page = 1;  //기본값 1페이지
    public int getOffset() { 
        return (this.page - 1) * 9; }


}
