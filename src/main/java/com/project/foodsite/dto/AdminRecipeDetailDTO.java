package com.project.foodsite.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.project.foodsite.vo.CookOrderVO;
import com.project.foodsite.vo.RecipeVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("adminrecipe")
public class AdminRecipeDetailDTO {
    
    private RecipeVO recipe;
    
    private List<CookOrderVO> cookOredrList;

}
