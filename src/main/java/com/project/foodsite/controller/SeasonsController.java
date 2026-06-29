package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.SeasonsDAO;
import com.project.foodsite.vo.SeasonsVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class SeasonsController {
    
    private final SeasonsDAO seasonsDao;

    // 계절별 음식 목록 조회 
    @ResponseBody
    @GetMapping("/seasons_data.do")
    public List<SeasonsVO> seasonData(@RequestParam("season") String season) { // @RequestParam 필수
        Map<String, Object> map = new HashMap<>();
        map.put("season", season);
        return seasonsDao.seasonFoodList(map);
    }

    @ResponseBody
    @GetMapping("/seasons_banner.do")
    // 배너 조회
    public SeasonsVO seasonBanner(@RequestParam("season") String season) {

        Map<String, Object> map = new HashMap<>();
        map.put("season", season);

        return seasonsDao.seasonBanner(map);
    }


}
