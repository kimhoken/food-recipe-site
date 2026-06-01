package com.project.foodsite.dao;

import com.project.foodsite.vo.TokenVO;

public interface TokenDAO {

    int insertToken(TokenVO vo);

    TokenVO getToken(String token);
    
}
