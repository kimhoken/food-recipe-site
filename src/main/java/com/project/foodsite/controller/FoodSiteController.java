package com.project.foodsite.controller;

import org.springframework.stereotype.Controller;


@Controller
public class FoodSiteController {
    
    @GetMapping( value={"/", "/main_list.do"})
    public String food_main(){
        return "main";
    }

}
