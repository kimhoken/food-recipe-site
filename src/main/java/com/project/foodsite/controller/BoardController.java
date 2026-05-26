package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.foodsite.dao.BoardDAO;
import com.project.foodsite.vo.BoardVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor 
public class BoardController {
    
    private final BoardDAO boardDao;

    //board list 조회
    @GetMapping(value={"/", "/list.do"} )
    public String boardList(Model model){
        List<BoardVO> list = boardDao.selectAll();
        model.addAttribute("list", list);
        return "/board/board_list";
    }

    //board 검색
    @PostMapping("/search.do")
    public String boardSearch(Model model, String search){
        List<BoardVO> list = boardDao.search(search);
        model.addAttribute("list", list);
        return "/board/board_list";
    }

}
