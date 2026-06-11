package com.project.foodsite.controller;

import com.project.foodsite.util.WebPushService;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.WebPushSubscriptionVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/push") // 모든 주소 앞에 /api/push 가 붙음
@RequiredArgsConstructor
public class WebPushController {
    private WebPushService webPushService;

    private HttpSession session;

    // 1. 프런트(JSP)에서 "알림 허용" 누르면 기기 정보를 받아서 DB에 저장하는 주소
    // JSP 코드의 fetch('/api/push/register') 이 부분이랑 연결
    @PostMapping("/register")
    public ResponseEntity<?> registerSubscription(@RequestBody Map<String, Object> payload) {
        try {
            WebPushSubscriptionVO subscription = new WebPushSubscriptionVO();
            MemberVO user = (MemberVO)session.getAttribute("user");
            subscription.setMember_id(user.getMember_id()); 
            subscription.setEndpoint((String) payload.get("endpoint")); // 2.최상위 endpoint값 추출
            
            // 3. 내부 중첩 객체인 keys 안에 들어있는 p256dh와 auth 추출
            @SuppressWarnings("unchecked")
            Map<String, String> keys = (Map<String, String>) payload.get("keys");
            if (keys != null) {
                subscription.setP256dh(keys.get("p256dh"));
                subscription.setAuth(keys.get("auth"));
            }

            // 4. 추출한 값들을 서비스로 넘겨서 DB에 저장
            webPushService.saveSubscription(subscription);
            return ResponseEntity.ok().body("{\"message\": \"구독 정보가 성공적으로 저장되었습니다.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    // 2. [당장 테스트용] 브라우저 주소창에 치면 즉시 알림을 발송해주는 주소
    // 주소창에 http://localhost:5000/api/push/test-send 치면 바로 발송
    @GetMapping("/test-send")
    public ResponseEntity<String> testSend() {
        System.out.println("=== 임시 테스트 발송 시작 ===");
        
        // 우리가 WebPushService에 만들어 둔 3일 임박 알림 메서드 강제 실행
        webPushService.sendAllExpirationAlarms(); 
        
        return ResponseEntity.ok("푸시 발송 신호를 보냈습니다! 브라우저 화면이나 PC 우측 하단을 확인해보세요.");
    }
}