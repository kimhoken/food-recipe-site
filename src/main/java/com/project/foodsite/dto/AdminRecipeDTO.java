package com.project.foodsite.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("adminrecipe")
public class AdminRecipeDTO extends SearchDTO {
    private String category_name, category;

}
