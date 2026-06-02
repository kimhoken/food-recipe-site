package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("cook_order")
public class CookOrderVO {
    private int cook_order_id;
    private int order;
    private String cook_image;
    private String description;
    private int recipe_id;
}
