package com.project.foodsite.common;

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

    public MailSendService(JavaMailSender javaMailSender) {
        this.javaMailSender = javaMailSender;
    }

    // 인증번호 생성
    public void makeRandomNumber() {
        Random rand = new Random();
        // 111111 ~ 999999
        authNumber = rand.nextInt(999999 - 111111 + 1) + 111111;

    }
    
    //메일 발송 
    public String joinEmail( String email ){
        
        makeRandomNumber();
        
        String setForm = "kimhk441@naver.com";
        String toMail = email;
        String title = "FoodSite 인증 이메일 입니다.";

        StringBuffer content = new StringBuffer();
        content.append("<h3>요청하신 인증번호 입니다.</h3>");
        content.append("<h1><b>["+authNumber+"]</b></h1>");
        content.append("<p>감사합니다.</p>");


        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(setForm, "FoodSite");
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText( content.toString(),true );

            javaMailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return String.valueOf(authNumber);
    }
}
