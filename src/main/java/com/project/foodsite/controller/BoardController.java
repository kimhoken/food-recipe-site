package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.project.foodsite.dao.BoardDAO;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.vo.BoardVO;

import lombok.RequiredArgsConstructor;

import com.project.foodsite.dto.RecipeDTO;


@Controller
@RequiredArgsConstructor 
public class BoardController {
    
    private final BoardDAO boardDao;
    private final RecipeDAO recipeDAO;
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

    //recipe 등록 폼
    @GetMapping("/regiRecipe.do")
    public String recipeForm(Model model){
        String id = "1";
        model.addAttribute("id", id); 
        return "/board/board_regiRecipe";
    }

    //내 레시피 등록하기
    @PostMapping("/myrecipe.do")
    public String registerRecipe(RecipeDTO dto){
        //등록 데이터 잘 들어오는지 확인용
        System.out.println("등록하려는 레시피의 제목" + dto.getTitle());
        System.out.println("등록하려는 레시피의 재료" + dto.getVegetableName().size());  
        System.out.println("등록하려는 재료의 양" + dto.getAmountV().get(0)); 

        String mainImgName = "no_file";

        if (dto.getMainImg() != null && !dto.getMainImg().isEmpty()) {
            mainImgName = dto.getMainImg().getOriginalFilename();
        }else{
            dto.setMainImgName(mainImgName);
        }
        
        recipeDAO.insertRecipe(dto);
        
        //만들어진 레시피 테이블의 아이디
        int recipeId = recipeDAO.getLastRecipeId();
        System.out.println("등록된 레시피 ID: " + recipeId);
        dto.setRecipeId(recipeId); //레시피 아이디 DTO에 세팅
        
        //재료 담기
        int res = recipeDAO.insertVegetable(dto);
        res += recipeDAO.insertMeat(dto);
        res += recipeDAO.insertSeasoning(dto);
        System.out.println("재료 등록 결과: " + res);

        return "redirect:/list.do";
    }
 
}
