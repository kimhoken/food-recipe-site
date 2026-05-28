package com.project.foodsite.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class FoodSiteController {
    
    @Autowired
    HttpSession session;
    
    @GetMapping( value={"/", "/main_list.do"})
    public String food_main(Model model){
        //레시피테이블에서 조회수 기준으로 불러옴 join으로 member테이블에 nickname까지 불러오기
        //조회수 기준으로 5개 불러오기          view_recipes -> 조회수 별로 순위도 매기기
        //등록일자 기준으로 5개 불러오기        reg_recipes
        //레시피중에 랜덤으로 하나 불러오가     today

        return "main";
    }

    @PostMapping("/logout.do")
    @ResponseBody
    public Map<String, String> logout(@RequestBody Map<String, String> map) {
        session.invalidate();
        map.put("result", "success");
        return map;
    }

    //테스트용 매핑
    @GetMapping("/login_test.do")
    public String test(){
        MemberVO vo = new MemberVO();
        vo.setNickname("test");
        vo.setMember_id(1);
        session.setAttribute("user", vo);
        return "redirect:/main_list.do";
    }
    

}
