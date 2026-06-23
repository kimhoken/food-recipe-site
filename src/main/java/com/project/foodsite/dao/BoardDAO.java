package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.BoardVO;
import com.project.foodsite.vo.CookOrderVO;
import com.project.foodsite.vo.IngredientVO;
import com.project.foodsite.dto.RecipeDTO;

public interface BoardDAO {

    List<BoardVO> selectAll();

    List<BoardVO> search(String search);

    int insertRecipe(RecipeDTO dto);

    BoardVO selectOne(int board_id);

    void updateViewCount(int board_id); // 조회수 증가

    int update(BoardVO vo); // 수정

    int delete(int board_id); // 삭제

    int insertBoard(BoardVO vo); // 커뮤니티 글쓰기

    int insertIngredient(IngredientVO vo); //재료추가 
    int insertCookOrder(CookOrderVO vo); //조리과정 추가
}
