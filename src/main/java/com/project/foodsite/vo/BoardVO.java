package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("board")
public class BoardVO {
    
    private int board_id, member_id, view_count, recipe_id, img_id;
    private String title, content, status, created_date, updated_date, nickname;
    private String board_type;

    private int score = 0;
    public void addScore(int score){
        this.score += score;
    }
}
