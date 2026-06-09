package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.foodsite.dao.BoardDAO;
import com.project.foodsite.vo.BoardVO;

import lombok.RequiredArgsConstructor;

import com.project.foodsite.dto.RecipeDTO;


@Controller
@RequiredArgsConstructor 
public class BoardController {
    
    private final BoardDAO boardDao;

    //board list 조회
    @GetMapping("/list.do" )
    public String boardList(Model model){
        List<BoardVO> list = boardDao.selectAll();
        model.addAttribute("list", list);
        return "board/board_list";
    }

    //board 검색
    @PostMapping("/search.do")
    public String boardSearch(Model model, String search){
        List<BoardVO> list = boardDao.search(search);

        model.addAttribute("list", list);
        model.addAttribute("searchWord", search);  //검색어 보관
        return "board/board_list";
    }

    //recipe 등록 폼
    @GetMapping("/regiRecipe.do")
    public String recipeForm(Model model, String id){
        model.addAttribute("id", id); 
        return "board/board_regiRecipe";
    }

    //내 레시피 등록하기
    @PostMapping("/myrecipe.do")
    public String registerRecipe(RecipeDTO dto){
        //등록 데이터 잘 들어오는지 확인용
        System.out.println("등록하려는 레시피의 제목" + dto.getTitle());
        System.out.println("등록하려는 레시피의 재료" + dto.getVegetableName().size());  
        System.out.println("등록하려는 재료의 양" + dto.getAmountV()); 
        
        boardDao.insertRecipe(dto); //레시피테이블에 레시피 등록
        /**
         * 레시피테이블에 제목이랑 썸네일 이미지 등록 후 방금 등록한 레시피 ID가져오기
         * 재료테이블에 재료를 넣고, 조리순서 테이블에 조리순서, 이미지를 넣어 아까 만든 레시피 ID와 연결
         * 게시판 테이블에 레시피ID, member_id를 참조하게 하고 제목, 내용 넣기  
         */
        
        return "redirect:/list.do";
    }
 
}
