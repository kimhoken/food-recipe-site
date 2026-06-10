package com.project.foodsite.dao;

import com.project.foodsite.vo.ImgVO;

public interface ImgDAO {   

    int img_insert(ImgVO vo);

    ImgVO img_select(int img_id);

}
