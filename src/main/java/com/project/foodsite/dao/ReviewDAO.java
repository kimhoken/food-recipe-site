package com.project.foodsite.dao;

import java.util.*;

import com.project.foodsite.vo.ReviewVO;

public interface ReviewDAO {
    List<ReviewVO> reviewLatest();                  // 최신순
    List<ReviewVO> reviewPopular(String period);    // 조회수순(전체, 주간, 월간)
    List<ReviewVO> reviewRating();                  // 별점순(평점순)
}
