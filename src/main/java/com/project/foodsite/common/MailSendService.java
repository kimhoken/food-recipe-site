package com.project.foodsite.common;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;


import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import jakarta.mail.internet.MimeMessage;

@Component
@Service
public class MailSendService {

    private final JavaMailSender javaMailSender;
    private int authNumber;
    private String token;

    public MailSendService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    // 사이트 주소+토큰 
    public void makeToken(){
        
    }

    // 인증번호 생성
    public void makeRandomNumber() {
        Random rand = new Random();
        // 111111 ~ 999999
        authNumber = rand.nextInt(999999 - 111111 + 1) + 111111;

    }

    //메일 함수
    public String sendEmail(String email,String val){

        String setForm = "kimhk441@naver.com";
        String toMail = email;
        Map<String,String> emailMap = new HashMap<>();

        if(val.equals("authnumber")){

            emailMap = joinEmail();

        }else if(val.equals("resetpwd")){
            emailMap = resetEmail();
        }

        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(setForm, "FoodSite");
            helper.setTo(toMail);
            helper.setSubject(emailMap.get("title"));
            helper.setText( emailMap.get("content"),true );

            javaMailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if(val.equals("authnumber")){
            return emailMap.get("authNumber");
        }else{
            return "success";
        }

    }
    
    //인증 번호 메일 발송 
    public Map<String,String> joinEmail(){
        
        makeRandomNumber();
        
        
        String title = "FoodSite 인증 이메일 입니다.";

        StringBuffer content = new StringBuffer();
        content.append("<h3>요청하신 인증번호 입니다.</h3>");
        content.append("<h1><b>["+authNumber+"]</b></h1>");
        content.append("<p>감사합니다.</p>");

        Map<String,String> email = new HashMap<>();
        email.put("title", title);
        email.put("content", content.toString());
        email.put("authNumber", String.valueOf(authNumber));
        
        return email;
    }

    //비밀번호 재설정 페이지 전송 함수
    public Map<String,String> resetEmail(){

        String title = "FoodSite 비밀번호 재설정 이메일 입니다.";

        StringBuffer content = new StringBuffer();
        content.append("<h3>비밀번호 재설정 링크입니다.</h3>");
        content.append("<h1><b>["+" 사이트 주소 "+"]</b></h1>");
        content.append("주저리 주저리 인정해라 휴먼 너가 졌다!");

        Map<String,String> email = new HashMap<>();
        email.put("title", title);
        email.put("content", content.toString());

        return email;

    }
}
