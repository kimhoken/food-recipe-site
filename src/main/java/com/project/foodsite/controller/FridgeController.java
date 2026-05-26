package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.FridgeItemDAO;
import com.project.foodsite.vo.FridgeItemVO;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
@RequiredArgsConstructor
public class FridgeController {
    
    private final FridgeItemDAO fdao;

    /**
     * 추후 파라미터로 member_ID를 받아서 진행
     * @return
     */
    @GetMapping(value={"/", "/fridge_list.do"})
    public String firdgeList(Model model) {
        int id=1;   //member_id
        List<FridgeItemVO> list = fdao.selectList(id);
        model.addAttribute("list", list);
        return "fridge/fridge_list";
    }
    
    @GetMapping("/food_insert.do")
    public String foodInsert(int id, Model model) {
        model.addAttribute("id", id);
        return "fridge/insert_form";
    }
    
    @PostMapping("/food_insert.do")
    @ResponseBody
    public Map<String, Object> insertFin(@RequestBody Map<String, Object> map){
        int res = fdao.insertFridge(map);

        if(res == 1){
            map.put("res", "success");
        }else{
            map.put("res", "fail");
        }

        return map;
    }//insertFin
    
}
