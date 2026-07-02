package com.project.foodsite.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.project.foodsite.vo.ReviewVO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@EqualsAndHashCode(callSuper = true)
@AllArgsConstructor
@NoArgsConstructor
@Alias("reviewdetail")
public class ReviewDetailDTO extends ReviewVO {
    private String recipe_title;
    private String recipe_thumbnail;

    private String image_list;
    private List<String> imgList;
    private boolean owner;

}
