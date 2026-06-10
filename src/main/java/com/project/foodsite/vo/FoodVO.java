package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("food")
public class FoodVO {
    private int food_id; //음식번호(PK)
    private String food_name; // 소분류(음식명-김치찌개...)
    private String category_id; //카테고리번호(FK)
}
