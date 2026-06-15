package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.ImgVO;

public interface ImgDAO {   

    int img_insert(ImgVO vo);

    ImgVO img_select(int img_id);

    List<ImgVO> img_select_inquiry(int inquiry_id); 
}
