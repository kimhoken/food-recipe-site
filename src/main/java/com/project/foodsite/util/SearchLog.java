package com.project.foodsite.util;

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import org.springframework.stereotype.Service;

import com.project.foodsite.dao.SearchLogDAO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SearchLog {

    private final HttpSession session;
    private final TrendingService trendingService;
    private final SearchLogDAO logDAO;

    public void getSearchLog(){
        @SuppressWarnings("unchecked")
        Queue<String> currentQueue = (Queue<String>)session.getAttribute("searchQueue");
        List<String> currentList = new LinkedList<>();

        if(currentQueue != null && !currentQueue.isEmpty()){
            for(String val : currentQueue){
                currentList.add(val);
            }
        }
        
        session.removeAttribute("searchList");
        session.removeAttribute("currentSearchList");

        session.setAttribute("searchList", trendingService.getTrendingKeywords());
        session.setAttribute("currentSearchList", currentList);
        session.setAttribute("recommandSearch", logDAO.getRecommand() );
    }
}
