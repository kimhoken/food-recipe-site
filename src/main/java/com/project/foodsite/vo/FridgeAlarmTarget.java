package com.project.foodsite.vo;

import java.time.LocalDate;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Alias("target")
public class FridgeAlarmTarget {
    // 알림 보낼 대상의 푸시 구독 정보
    private String endpoint;
    private String p256dh;
    private String auth;
    
    // 알림 내용에 채워 넣을 냉장고 재료 정보
    private String ingredientName;
    private LocalDate expireDate;
    private String member_id;
}
