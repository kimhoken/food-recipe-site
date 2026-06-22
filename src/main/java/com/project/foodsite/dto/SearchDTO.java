package com.project.foodsite.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchDTO {
    private String keyword,status,sort;
    private int page,size,offset;
    
}
