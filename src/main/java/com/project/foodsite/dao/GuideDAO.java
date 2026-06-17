package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.dto.GuideDTO;

public interface GuideDAO {
    
    List<GuideDTO> guideTab(String tab);
}
