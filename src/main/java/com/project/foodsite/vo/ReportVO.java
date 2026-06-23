package com.project.foodsite.vo;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("report")
public class ReportVO {

    private int report_id, member_id, board_id, admin_id, comment_id, recipe_id, reported_count, report_count;
    private String target_type, reason, detail, status, admin_memo;
    private Data created_date, processed_date;
    
}
