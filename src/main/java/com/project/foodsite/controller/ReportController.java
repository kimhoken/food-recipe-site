package com.project.foodsite.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ReportController {

    @GetMapping("/report/form.do")
    public String reportForm() {
        return "report/report_form"; 
    }
    
}
