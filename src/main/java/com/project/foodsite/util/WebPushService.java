package com.project.foodsite.util;

import java.util.*;
import nl.martijndwars.webpush.Notification;

import org.springframework.stereotype.Service;

import com.project.foodsite.dao.WebPushDAO;
import com.project.foodsite.vo.FridgeAlarmTarget;
import com.project.foodsite.vo.WebPushSubscriptionVO;

import lombok.RequiredArgsConstructor;
import nl.martijndwars.webpush.PushService;
import tools.jackson.databind.ObjectMapper;

@Service
@RequiredArgsConstructor
public class WebPushService {
    //몇일 전에 알람을 보낼 지 지정
    private final int DAYS = 3;

    private WebPushDAO webPushDAO;

    private Config config;

    // 구독 정보 저장 또는 업데이트
    public void saveSubscription(WebPushSubscriptionVO subscription) {
        webPushDAO.upsertSubscription(subscription);
    }
    
    public void sendAllExpirationAlarms(){
        List<FridgeAlarmTarget> targets = webPushDAO.selectExpiringItems(3);
        
        //보낼사람이 없을 경우 알람을 보내지 않고 종료
        if(targets.isEmpty()){
            return ;
        }

        try{
            //키 세팅 및 제목 세팅
            PushService pushService = new PushService();
            pushService.setPublicKey(config.getPublicKey());
            pushService.setPrivateKey(config.getPrivateKey());
            pushService.setSubject(config.getSubject());
            
            //json을 받을 객체
            ObjectMapper objectMapper = new ObjectMapper();

            //알림을 보낼 유저들에게 내용을 세팅해 전달
            for(FridgeAlarmTarget target : targets){
                Map<String, String> payload = new HashMap<>();
                payload.put("title", "냉장고에 유통기한 임박 재료가 있습니다!!!");
                payload.put("body", "[" + target.getIngredientName() + "]의 유통기한이 " + DAYS + "일 남았습니다.");
                String jsonpayload = objectMapper.writeValueAsString(payload);

                Notification notification = new Notification(
                    target.getEndpoint(),
                    target.getP256dh(),
                    target.getAuth(),
                    jsonpayload
                );
                pushService.send(notification);
            }
        }catch(Exception e){
            e.printStackTrace();
        }

    }

}
