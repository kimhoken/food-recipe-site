package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("category")
public class CategoryVO {
    private int category_id, sort_order;            // 카테고리번호, 출력순서
    private String categoryName, subCategoryName;   //중분류, 소분류
    private String foodName;
}
