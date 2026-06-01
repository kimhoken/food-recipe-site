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
     * @param member_id jsp에서 넘어오는 member_Id
     * @param model binding을 위한 model
     * @return jsp 페이지 forwarding
     */
    @GetMapping("/fridge_list.do")
    public String firdgeList(Model model, String member_id) {
        int id = 0;
        //로그인을 안해도 페이지로는 넘어가게 처리, 페이지에서 로그인 여부 확인함
        if(member_id != null && !member_id.isEmpty())
            id = Integer.parseInt(member_id);     

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
    public Map<String, Object> insertFin(@RequestBody List<FridgeItemVO> list){
        Map<String, Object> map = new HashMap<>();

        int res = fdao.insertFridge(list);
        
        if(res != 0){
            map.put("res", "success");
        }else{
            map.put("res", "fail");
        }

        return map;
    }//insertFin

    @PostMapping("/delete_fridge.do")
    @ResponseBody
    public Map<String, String> del(@RequestBody Map<String, String> map){
        int res = fdao.deleteFridge(map.get("id"));
        String result = "fail";

        if(res == 1){
            result = "success";
        }
        map.put("result", result);

        return map;
    }//del

    @PostMapping("/modity.do")
    @ResponseBody
    public Map<String, String> modi(@RequestBody Map<String, String> map) {
        int res = fdao.modify(map);
        String result = "fail";

        if(res != 0){
            result = "success";
        }
        
        map.put("result", result);
        return map;
    }

    @GetMapping("/fridge_recommend.do")
    public String rec(int id, Model model){
        //레시피테이블에서 현재 있는 레시피가 포함된 재료를 불러옴
        model.addAttribute("id", id);
        return "fridge/fridge_recommend";
    }
    
    
}
