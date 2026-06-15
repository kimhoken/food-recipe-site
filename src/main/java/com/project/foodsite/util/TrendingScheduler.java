package com.project.foodsite.util;

import java.time.LocalTime;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.foodsite.dao.SearchLogDAO;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class TrendingScheduler {
    private final TrendingService trendingService;
    private final SearchLogDAO searchLogDAO;

    @Scheduled(fixedDelay = 300000)
    public void autoRefresh(){
        //5분마다 캐시에 업데이트
        System.out.println("캐시 업데이트 완료" + LocalTime.now());
        trendingService.updateTrendingKeywords();
    }

    /**
     * 1시간 마다 로그 삭제
     */
    @Scheduled(fixedDelay = 36000000)
    public void deleteLog(){
        System.out.println("로그 삭제 완료");
        searchLogDAO.deleteLog();
    }

}
