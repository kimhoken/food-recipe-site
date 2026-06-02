package com.project.foodsite.dao;

import java.util.*;

import com.project.foodsite.vo.FridgeItemVO;

public interface FridgeItemDAO {
    List<FridgeItemVO> selectList(int id);
    int insertFridge(List<FridgeItemVO> list);
    int deleteFridge(String id);
    int modify(Map<?, ?> map);
} 
