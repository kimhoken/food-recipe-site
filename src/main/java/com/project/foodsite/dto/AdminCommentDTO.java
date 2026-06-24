package com.project.foodsite.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
@Alias("admincomment")
public class AdminCommentDTO extends SearchDTO {
    private String nickname, title, content, created_date;
}
