package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import lombok.RequiredArgsConstructor;

@Controller
public class GuideController {


    @GetMapping("/guide_list.do")
    public String guideList(){
        return "guide/guide_list";
    }

 
}
