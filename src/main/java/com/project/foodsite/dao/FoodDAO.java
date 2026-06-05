package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.FoodVO;

public interface FoodDAO {

    //현재 선택한 대분류에 속하는 모든 음식 리스트
    List<FoodVO> foodListCategory(String category);

    //음식 전체 목록 조회
    List<FoodVO> foodListAll();

    
}
