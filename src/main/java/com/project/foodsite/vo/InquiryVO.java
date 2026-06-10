package com.project.foodsite.vo;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Alias("inquiry")
public class InquiryVO {

    private Integer inquiryId, member_id, admin_id;
    private String title, content, status, answer_content, guest_name, guest_email, guest_password, type;

    private Date createdDate;

}
