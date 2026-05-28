package com.project.foodsite.controller;

import com.project.foodsite.util.WebPushService;
import com.project.foodsite.vo.WebPushSubscriptionVO;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/push") // 모든 주소 앞에 /api/push 가 붙어
public class WebPushController {

    @Autowired
    private WebPushService webPushService;

    // 1. 프런트(JSP)에서 "알림 허용" 누르면 기기 정보를 받아서 DB에 저장하는 주소
    // JSP 코드의 fetch('/api/push/register') 이 부분이랑 연결되는 거야!
    @PostMapping("/register")
    public ResponseEntity<?> registerSubscription(@RequestBody Map<String, Object> payload) {
    try {
        WebPushSubscriptionVO subscription = new WebPushSubscriptionVO();
        
        // 1. 임시로 테스트 유저 ID 세팅 (나중에 로그인 연동)
        subscription.setMember_id(1); 
        
        // 2. 최상위 endpoint 값 추출
        subscription.setEndpoint((String) payload.get("endpoint"));
        
        // 3. 내부 중첩 객체인 keys 안에 들어있는 p256dh와 auth 추출
        Map<String, String> keys = (Map<String, String>) payload.get("keys");
        if (keys != null) {
            subscription.setP256dh(keys.get("p256dh"));
            subscription.setAuth(keys.get("auth"));
        }

        // 값 검증용 콘솔 로그 (서버 콘솔에 정상적으로 찍히는지 확인용)
        System.out.println("=== 구독 정보 매핑 결과 ===");
        System.out.println("Endpoint: " + subscription.getEndpoint());
        System.out.println("P256dh: " + subscription.getP256dh());
        System.out.println("Auth: " + subscription.getAuth());

        // 4. 추출한 값들을 서비스로 넘겨서 DB에 저장
        webPushService.saveSubscription(subscription);
        
        return ResponseEntity.ok().body("{\"message\": \"구독 정보가 성공적으로 저장되었습니다.\"}");
    } catch (Exception e) {
        e.printStackTrace();
        return ResponseEntity.badRequest().body("{\"error\": \"" + e.getMessage() + "\"}");
    }
}

    // 2. [당장 테스트용] 브라우저 주소창에 치면 즉시 알림을 발송해주는 주소
    // 주소창에 http://localhost:5000/api/push/test-send 치면 바로 발송됨!
    @GetMapping("/test-send")
    public ResponseEntity<String> testSend() {
        System.out.println("=== 임시 테스트 발송 시작 ===");
        
        // 우리가 WebPushService에 만들어 둔 3일 임박 알림 메서드 강제 실행
        webPushService.sendAllExpirationAlarms(); 
        
        return ResponseEntity.ok("푸시 발송 신호를 보냈습니다! 브라우저 화면이나 PC 우측 하단을 확인해보세요.");
    }
}