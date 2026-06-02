package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.ImgVO;
import com.project.foodsite.vo.NoticeVO;

public interface NoticeDAO {
    //전체공지
    List<NoticeVO> selectList(int start, int pageSize);
    int notice_count();
    //공지상세정보
    NoticeVO noticeView(int notice_id);
    // 조회 기록 추가
    int viewHistory(int notice_id, int member_id);
    // 조회수 증가
    int userViewCount(int notice_id);
    //공지추가
    int notice_insert(NoticeVO vo);
    int img_insert(ImgVO img);
    //공지삭제
    int notice_delete(int notice_id);
    //공지수정
    int notice_update(NoticeVO vo);
   
   
}
