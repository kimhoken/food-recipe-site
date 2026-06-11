package com.project.foodsite.controller;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.util.Recommand;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class FoodSiteController {
    
    private final Recommand rec;

    @Autowired
    public HttpSession session;
    
    @GetMapping( value={"/", "/main_list.do"})
    public String food_main(Model model){
        //레시피테이블에서 조회수 기준으로 불러옴 join으로 member테이블에 nickname까지 불러오기
        //조회수 기준으로 5개 불러오기          view_recipes -> 조회수 별로 순위도 매기기
        //등록일자 기준으로 5개 불러오기        reg_recipes
        //레시피중에 랜덤으로 하나 불러오가     today
        
        //등록일자 기준으로 레시피를 불러옴
        model.addAttribute("reg_recipes", rec.recentlyList());
        
        //오늘의 레시피를 한개 불러옴
        model.addAttribute("today", rec.randomList());

        //조회수를 기준으로 레시피를 불러옴
        model.addAttribute("view_recipes", rec.viewCountList());

        List<String> list = new LinkedList<>();
        
        Queue<String> currentQueue = (Queue<String>)session.getAttribute("searchList");
        List<String> list = new LinkedList<>();

        while(!currentQueue.isEmpty()){
            list.
        }

        model.addAttribute("searchList", list);
        model.addAttribute("currentSearchList", currentList);
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

    @GetMapping("/hidden.do")
    public String hidden(){
        return "fridge/hidden";
    }
    

}
