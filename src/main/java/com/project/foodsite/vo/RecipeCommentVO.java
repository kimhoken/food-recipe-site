package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("recipeComment")
public class RecipeCommentVO {
    private String commentId;
    private String title;
    private String content;
    private String memberId;
    private String recipeId;

    private String nickname;
}
