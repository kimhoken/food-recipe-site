package com.project.foodsite.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("adminmember")
public class AdminMemberDTO extends SearchDTO {
    private String nickname, email, login_id, name, role, created_date, profile_img, memberintro, provider;
    private int member_id, report_count, recipe_count, like_count, bookmark_count, comment_count;
}
