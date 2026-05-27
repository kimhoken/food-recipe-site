package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.ChatbotVO;

public interface ChatbotDAO {
    
    List<ChatbotVO> selectParent();
    List<ChatbotVO> selectSub(int parentId);
}
