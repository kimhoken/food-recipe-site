package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.InquiryVO;

public interface InquiryDAO {

    int insertInquiry(InquiryVO vo);

    int updateInquiryCode(InquiryVO vo);
    
    InquiryVO guestInquiryCode(String inquiry_code);

    List<InquiryVO> adminInquiryList();

    InquiryVO adminInquiryDetail(int inquiry_id);

    int answerInquiry(InquiryVO vo);

    List<InquiryVO> myInquiryList(int member_id);
}
