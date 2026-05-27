package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.BoardVO;

public interface BoardDAO {

    List<BoardVO> selectAll();
    List<BoardVO> search(String search);
    
}
