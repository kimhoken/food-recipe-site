package com.project.foodsite.vo;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("category")
public class CategoryVO {
    private int category_id,sort_order; // 카테고리번호, 출력순서
    private String category_name, sub_category_name; //대분류,중분류
    
}
