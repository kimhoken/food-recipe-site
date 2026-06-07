package com.project.foodsite.common;

import java.io.IOException;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class OAuth2SuccessHandler implements AuthenticationSuccessHandler {

    private final MemberDAO memberDAO;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        OAuth2AuthenticationToken token = (OAuth2AuthenticationToken) authentication;

        String provider = token.getAuthorizedClientRegistrationId();

        OAuth2User oauthuser = (OAuth2User) authentication.getPrincipal();

        Map<String, Object> attributes = oauthuser.getAttributes();

        MemberVO socialUser = null;

        if (provider.equals("naver")) {
            socialUser = getNaverUser(attributes);
        } else if (provider.equals("kakao")) {
            socialUser = getKakaoUser(attributes);
        } else if (provider.equals("google")) {
            socialUser = getGoogleUser(attributes);
        }

        System.out.println("provider = " + provider);
        System.out.println("attributes = " + attributes);

        if (socialUser == null) {
            response.sendRedirect("/login.do?error");
            return;
        }   

        // DB 조회
        MemberVO member = memberDAO.getSocialUser(socialUser.getProvider(), socialUser.getProvider_id());

        // 회원가입 여부 판단
        if (member == null) {
            request.getSession().setAttribute("socialUser", socialUser);

            response.sendRedirect("/register_form.do");
            return;
        }

        request.getSession().setAttribute("user", member);
        response.sendRedirect("/main_list.do");

    }

    private MemberVO getNaverUser(Map<String, Object> attributes) {

        Map<String, Object> naver = (Map<String, Object>) attributes.get("response");

        MemberVO vo = new MemberVO();

        vo.setProvider("naver");
        vo.setProvider_id((String) naver.get("id"));
        vo.setEmail((String) naver.get("email"));
        vo.setName((String) naver.get("name"));
        vo.setNickname((String) naver.get("nickname"));
        vo.setLogin_type("Social");

        return vo;

    }

    private MemberVO getKakaoUser(Map<String,Object> attributes) {

        Map<String,Object> kakao = (Map<String, Object>) attributes.get("kakao_account");

        Map<String,Object> profile =(Map<String, Object>) kakao.get("profile");

        MemberVO vo = new MemberVO();

        vo.setProvider("kakao");
        vo.setProvider_id(String.valueOf(attributes.get("id")));
        vo.setEmail((String) kakao.get("email"));        
        vo.setNickname((String) profile.get("nickname"));
        vo.setLogin_type("Social");

        return vo;
    }

    private MemberVO getGoogleUser(Map<String, Object> attributes) {

        MemberVO vo = new MemberVO();

        vo.setProvider("google");
        vo.setProvider_id((String) attributes.get("sub"));
        vo.setEmail((String) attributes.get("email"));
        vo.setName((String) attributes.get("name"));
        vo.setNickname((String) attributes.get("name"));
        vo.setLogin_type("Social");

        return vo;
    }

}
