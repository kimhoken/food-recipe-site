package com.project.foodsite.util;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.project.foodsite.dao.SearchLogDAO;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;

import java.util.*;

@Component
@RequiredArgsConstructor
public class TrendingScheduler {
    private final TrendingService trendingService;
    private final SearchLogDAO logDAO;

    private List<String> defaultRank = Arrays.asList("스팸마요", "치킨마요", "햄버거", "피자", "치킨", "카레", "김치찜", "수육", "족발", "후라이드 치킨");
    private List<String> lastRank = defaultRank;

    @PostConstruct
    public void init(){
        trendingService.initCache();
        System.out.println("=================초기 실시간 검색어 세팅 완료=================");
    }

    @Scheduled(fixedDelay = 300000)
    public void autoRefresh(){
        List<String> dbRank = logDAO.selectTrendingKeywords();
        Set<String> combinedSet = new LinkedHashSet<>();
        if(dbRank != null){
            for(String val : dbRank){
                if(combinedSet.size() < 10){
                    combinedSet.add(val);
                }
            }
        }
        //리스트가 10개가 되지 않을 경우 이전의 리스트에서 채움
        for(String val : lastRank){
            if(combinedSet.size() >= 10){
                break;
            }
            combinedSet.add(val);
        }

        List<String> finalRank = new ArrayList<>(combinedSet);
        lastRank = finalRank;

        trendingService.updateTrendingKeywords(finalRank);
        System.out.println("=================실시간 검색어 업데이트 완료=================");
    }


}
