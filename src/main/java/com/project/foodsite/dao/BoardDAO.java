package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.BoardVO;
import com.project.foodsite.dto.RecipeDTO;


public interface BoardDAO {

    List<BoardVO> selectAll();
    List<BoardVO> search(String search);
    int insertRecipe(RecipeDTO dto);
}
