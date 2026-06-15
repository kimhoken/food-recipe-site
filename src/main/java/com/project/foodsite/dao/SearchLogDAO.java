package com.project.foodsite.dao;

import java.util.List;

public interface SearchLogDAO {
    int insertKeyWord(String search);
    List<String> selectTrendingKeywords();
    int deleteLog();
}
