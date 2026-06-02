package com.project.foodsite.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.foodsite.vo.CategoryVO;

@Mapper
public interface CategoryDAO {

    List<CategoryVO> getCategoryList(String category);
    
}
