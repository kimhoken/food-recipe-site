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
    @GetMapping("/list.do" )
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
        model.addAttribute("searchWord", search);  //검색어 보관
        return "/board/board_list";
    }

    //recipe 등록
    @GetMapping("/regiRecipe.do")
    public String recipeForm(Model model){
        String id = "1";
        model.addAttribute("id", id); 
        return "/board/board_regiRecipe";
    }
}
