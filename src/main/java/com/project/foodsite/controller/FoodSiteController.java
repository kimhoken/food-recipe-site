package com.project.foodsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class FoodSiteController {
    
    @GetMapping( value={"/", "/main_list.do"})
    public String food_main(){
        //레시피테이블에서 조회수 기준으로 불러옴 join으로 member테이블에 nickname까지 불러오기
        //DTO를 만들어야겟지....
        //조회수 기준으로 5개 불러오기          view_recipes
        //등록일자 기준으로 5개 불러오기        reg_recipes
        //레시피중에 랜덤으로 하나 불러오가     today
        return "main";
    }

}
