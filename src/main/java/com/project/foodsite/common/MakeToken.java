package com.project.foodsite.common;

import java.security.SecureRandom;
import java.util.Base64;

public class MakeToken {

    public String createToken() {
    SecureRandom secureRandom = new SecureRandom();

    byte[] bytes = new byte[32];
    secureRandom.nextBytes(bytes);

    return Base64.getUrlEncoder()
                 .withoutPadding()
                 .encodeToString(bytes);
}
    
    
}
