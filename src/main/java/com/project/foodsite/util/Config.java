package com.project.foodsite.util;

import java.security.Security;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import jakarta.annotation.PostConstruct;

@Configuration
public class Config{
    @Value("${vapid.public-key}")
    private String publicKey;

    @Value("${vapid.private-key}")
    private String privateKey;

    @Value("${vapid.subject}")
    private String subject;

    @PostConstruct
    public void init() {
        // 암호화 프로바이더 등록 (서버 뜰 때 최초 1회 무조건 실행돼야 함)
        if (Security.getProvider(BouncyCastleProvider.PROVIDER_NAME) == null) {
            System.out.println("--------------------------key load success!!!----------------------------");
            Security.addProvider(new BouncyCastleProvider());
        }
    }

    // 다른 서비스에서 키값을 불러다 쓸 수 있게 getter 만들어두기
    public String getPublicKey() {
        return publicKey;
    }

    public String getPrivateKey() {
        return privateKey;
    }

    public String getSubject() {
        return subject;
    }

}
