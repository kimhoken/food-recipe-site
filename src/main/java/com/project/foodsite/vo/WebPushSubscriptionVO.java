package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("WebPushSubscription")
public class WebPushSubscriptionVO {
    private int member_id; 
    private String endpoint;
    private String p256dh;
    private String auth;
}
