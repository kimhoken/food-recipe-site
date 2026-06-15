package com.project.foodsite.controller;

import java.util.*;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class SearchRanking {
    
    @PostMapping("/api/ranking")
    public Map<?, ?> getRanking(){
        //DB에서 최근 시간걸로 불러와서 10개 넘겨주기
        return null;
    }
}
