package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.ReviewVO;

public interface ReviewDAO {

      // 최신순
    List<ReviewVO> reviewLatest();

    // 조회수순(전체, 주간, 월간)
    List<ReviewVO> reviewPopular(String period);

    // 별점순(평점순)
    List<ReviewVO> reviewRating();

}
