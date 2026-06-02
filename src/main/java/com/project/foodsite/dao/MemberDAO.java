package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.MemberVO;

public interface MemberDAO {
    
    List<MemberVO> selectList();
    
    MemberVO getUserById(String id);    
    
    int userInsert(MemberVO vo);

    MemberVO getUserNickname(String nickname);
    
    MemberVO getUserEmail(String email);

    MemberVO getUserByMemberId(int member_id);

    int userUpdate(MemberVO vo);
} 