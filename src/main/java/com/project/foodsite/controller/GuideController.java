package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.GuideDAO;
import com.project.foodsite.dto.GuideDTO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class GuideController {

     private final GuideDAO guideDao;

    @GetMapping("/guide_list.do")
    public String guideList(){
        return "guide/guide_list";
    }

    @ResponseBody
    @GetMapping("/guide_tab.do")
    public List<GuideDTO> guideTab(String tab) {

        return guideDao.guideTab(tab);

    }

 
}
