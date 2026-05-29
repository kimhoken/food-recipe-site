package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.MemberVO;

public interface MemberDAO {
    //전체공지
    List<MemberVO> selectList();
    //공지상세정보
    MemberVO getUserById(String id);    
    //공지추가페이지로

    //공지추가

    //공지삭제

    //공지수정

} 