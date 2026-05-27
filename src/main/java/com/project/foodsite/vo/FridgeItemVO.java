package com.project.foodsite.vo;

import java.time.LocalDate;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("fridge")
public class FridgeItemVO {
    private int fridge_id;
    private String ingredient_name;
    private String quantity;
    private LocalDate expire_date;
    private LocalDate created_date;
    private boolean freezer;
    private int memberId;
}
