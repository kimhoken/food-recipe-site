package com.project.foodsite.dao;

import java.util.List;
import java.util.Map;

import com.project.foodsite.dto.GuideDTO;

public interface GuideDAO {
    
    List<GuideDTO> guideTab(Map<String, Object> map);
    
}
