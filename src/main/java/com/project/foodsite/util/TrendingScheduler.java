package com.project.foodsite.util;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.foodsite.dao.SearchLogDAO;

import lombok.RequiredArgsConstructor;

import java.util.*;

@Component
@RequiredArgsConstructor
public class TrendingScheduler {
    private final TrendingService trendingService;
    private final SearchLogDAO logDAO;

    private List<String> lastRank = Arrays.asList("스팸마요", "치킨마요", "햄버거", "피자", "치킨", "카레", "김치찜", "수육", "족발");
    private boolean isExclude = false;

    @Scheduled(fixedDelay = 300000)
    public void autoRefresh(){
        //최초 한번만 실행
        if(!isExclude){
            trendingService.initCache();
            isExclude = true;
        }
        //5분마다 캐시에 업데이트
        System.out.println("캐시 업데이트 완료 " + LocalDate.now() + "/" + LocalTime.now());
        List<String> rank = logDAO.selectTrendingKeywords();
        if(rank == null || rank.isEmpty() || rank.size() < 9){
            rank = lastRank;
        }else{
            lastRank = rank;
        }

        trendingService.updateTrendingKeywords(rank); 
    }


}
