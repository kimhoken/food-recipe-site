package com.project.foodsite.common;

import java.io.IOException;
import java.util.Map;

import org.springframework.security.core.Authentication;
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
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication) throws IOException,ServletException{
            
           // 네이버에서 데이터 가져오기
           MemberVO socialUser = getNaverUser(authentication);

           // DB 조회
           MemberVO member = memberDAO.getSocialUser(socialUser.getProvider(),socialUser.getProvider_id());

           
           // 회원가입 여부 판단
           if(member == null){
                request.getSession().setAttribute("socialUser", socialUser);

                response.sendRedirect("/register_form.do");
                return;
           }



            }

    private MemberVO getNaverUser(Authentication authentication){

        OAuth2User oauthuser = (OAuth2User) authentication.getPrincipal();

        Map<String,Object> attributes = oauthuser.getAttributes();

        Map<String,Object> naver = (Map<String,Object>) attributes.get("response");

        MemberVO vo = new MemberVO();

        vo.setProvider("naver");
        vo.setProvider_id((String) naver.get("id"));
        vo.setEmail((String) naver.get("email"));
        vo.setName((String) naver.get("name"));
        vo.setNickname((String) naver.get("nickname"));

        return vo;

    }        

}
