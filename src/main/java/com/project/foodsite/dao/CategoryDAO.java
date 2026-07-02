package com.project.foodsite.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.project.foodsite.vo.CategoryVO;
import com.project.foodsite.vo.FoodVO;

@Mapper
public interface CategoryDAO {

    List<CategoryVO> getCategoryList(String category);
    List<FoodVO> foodListCategory(String category);
    List<CategoryVO> selectCategoryFood(String category);
    List<CategoryVO> getSubName(String category);
    List<CategoryVO> getCategoryName();
    List<FoodVO> getFoodName(String categoryId);
}
