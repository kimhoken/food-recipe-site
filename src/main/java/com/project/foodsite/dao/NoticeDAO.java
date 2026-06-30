package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.ImgVO;
import com.project.foodsite.vo.NoticeVO;

public interface NoticeDAO {

    List<NoticeVO> selectList(int start, int pageSize, String search_text);

    int notice_count(String search_text);

    NoticeVO noticeView(int notice_id);

    int notice_insert(NoticeVO vo);

    int notice_img_insert(ImgVO img);

    ImgVO notice_img_select(int notice_id);

    int notice_img_update(ImgVO img);

    int notice_img_delete(int notice_id);

    int notice_delete(int notice_id);

    int notice_update(NoticeVO vo);
}