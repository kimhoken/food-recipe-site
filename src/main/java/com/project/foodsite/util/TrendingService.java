package com.project.foodsite.util;

import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.project.foodsite.dao.SearchLogDAO;

import lombok.RequiredArgsConstructor;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TrendingService {
    private final SearchLogDAO searchLogDAO;

    @Cacheable(cacheNames="trendingKeywords", key ="'all'")
    public List<String> getTrendingKeywords(){
        //캐시에 값이 없을때만 DB에서 값을 가져옴
        return searchLogDAO.selectTrendingKeywords();
    }

    @CachePut(cacheNames="trendingKeywords", key ="'all'")
    public List<String> updateTrendingKeywords(){
        //호출시 무조건 실행되서 DB조회를 새로 해서 캐시에 새로 담음
        return searchLogDAO.selectTrendingKeywords();
    }

}
