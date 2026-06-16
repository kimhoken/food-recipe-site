package com.project.foodsite;

import java.util.concurrent.TimeUnit;

import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.github.benmanes.caffeine.cache.Caffeine;

@Configuration
@EnableCaching
public class CacheConfigure {
    private final int MAX_SIZE = 10;

    @Bean
    public CacheManager cacheManager(){
        CaffeineCacheManager cacheManager = new CaffeineCacheManager("trendingKeywords");
        cacheManager.setCaffeine(
            Caffeine.newBuilder()
            //유지시간을 1시간 기준으로 잡음 -> 1시간뒤 삭제 후 다시 생김
            .expireAfterWrite(1, TimeUnit.HOURS)
            //Key-Value 기준으로 최대 사이즈 MAX_SIZE개까지 저장
            .maximumSize(MAX_SIZE)
        );

        return cacheManager;
    }
}
