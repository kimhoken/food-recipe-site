package com.project.foodsite.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.dao.ChatbotDAO;
import com.project.foodsite.vo.ChatbotVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ChatbotController {

    private final ChatbotDAO chatbotDao;
    

    @GetMapping(value = {"/","/chatbot"})
    public String chatbotmain(){
        return "chatbot/chatbot_main";
    }
    

    @GetMapping("/chatbot/parent")
    @ResponseBody
    public List<ChatbotVO> parent() {
        return chatbotDao.selectParent();
    }

    @GetMapping("/chatbot/sub")
    @ResponseBody
    public List<ChatbotVO> sub(int id) {
        return chatbotDao.selectSub(id);
    }   
}
