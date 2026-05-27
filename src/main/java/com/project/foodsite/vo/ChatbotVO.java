package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("chatbot")
public class ChatbotVO {

    private int id, parent_id, depth, sort_order;
    private String question, answer, use_yn;
    
}
