package com.project.foodsite.util;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class TrendingScheduler {
    private final TrendingService trendingService;
    
    @Scheduled(fixedDelay = 300000)
    public void autoRefresh(){
        //5분마다 캐시에 업데이트
        System.out.println("캐시 업데이트 완료 " + LocalDate.now() + "/" + LocalTime.now());
        trendingService.updateTrendingKeywords();
    }


}
