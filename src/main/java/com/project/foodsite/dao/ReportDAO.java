package com.project.foodsite.dao;

import java.util.List;

import com.project.foodsite.vo.ReportVO;

public interface ReportDAO {

    int reportInsert(ReportVO vo);

    List<ReportVO> reportList();

    
}
