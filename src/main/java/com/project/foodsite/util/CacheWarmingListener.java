package com.project.foodsite.util;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CacheWarmingListener {
    private final TrendingService ts;

    @EventListener(ApplicationReadyEvent.class)
    public void initCache(){
        //서버 재실행시 최근 검색어에 상관없이 검색한 단어가 많은거 10개 검색
        ts.initCache();
    }
}
