package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.NoticeVO;

public interface NoticeDAO {

    List<NoticeVO> selectAll();
    NoticeVO noticeView(int notice_id);
    int notice_insert(NoticeVO vo);
}
