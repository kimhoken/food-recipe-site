package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.InquiryVO;

public interface InquiryDAO {

    int insertInquiry(InquiryVO vo);

    List<InquiryVO> selectInquiryList();
    
}
