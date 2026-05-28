package com.project.foodsite.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.foodsite.vo.FridgeAlarmTarget;
import com.project.foodsite.vo.WebPushSubscriptionVO;

@Mapper
public interface WebPushDAO {
    // 기존에 만든 구독 정보 저장 메서드
    void upsertSubscription(WebPushSubscriptionVO subscription);
    
    // 유통기한이 N일 남은 알림 대상자 목록 조회 (핵심!)
    List<FridgeAlarmTarget> selectExpiringItems(int daysLeft);
    
} 
