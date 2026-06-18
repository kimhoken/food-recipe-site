package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.CookOrderVO;

public interface CookOrderDAO {
    List<CookOrderVO> cookorderList(int recipe_id);
}