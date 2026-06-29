package com.project.foodsite.dao;

import java.util.List;
import java.util.Map;


import com.project.foodsite.vo.SeasonsVO;

public interface SeasonsDAO {
   
   // 계절별 음식 목록 조회
    List<SeasonsVO> seasonFoodList(Map<String, Object> map);

    // 계절별 배너 정보 조회
    SeasonsVO seasonBanner(Map<String, Object> map);

}
