package com.project.foodsite.dao;

import java.util.List;
import java.util.Map;

import com.project.foodsite.vo.BookmarkVO;

public interface BookmarkDAO {
    
    List<BookmarkVO> userBookmark(int member_id);

    int countUserBookmark(int member_id);

    List<BookmarkVO> getUserBookmarkList(Map<String, Object> map);    

}
