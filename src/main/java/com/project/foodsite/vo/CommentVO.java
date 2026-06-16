package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("comment")
public class CommentVO {
    private int comment_id, rating, recipe_id, member_id;
    private String content, status, created_date;
}
