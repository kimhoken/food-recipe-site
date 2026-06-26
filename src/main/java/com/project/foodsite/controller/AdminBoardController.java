package com.project.foodsite.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.project.foodsite.common.AdminUtil;
import com.project.foodsite.common.Paging;
import com.project.foodsite.dao.BoardDAO;
import com.project.foodsite.dto.AdminBoardDTO;
import com.project.foodsite.vo.MemberVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminBoardController {
    @Autowired
    HttpSession httpSession;

    private final BoardDAO boardDAO;
    private final AdminUtil adminUtil;

    private void BoardPaging(Model model, AdminBoardDTO Board ){
        if(Board.getPage() <= 0){
            Board.setPage(1);
        }

        int totalcount = boardDAO.boardCount(Board);

        Paging paging = new Paging(Board.getPage(), 5, totalcount);

        Board.setOffset(paging.getOffset());
        Board.setSize(paging.getSize());

        List<AdminBoardDTO> list = boardDAO.BoardSearch(Board);
        
        model.addAttribute("list", list);
        model.addAttribute("totalcount", totalcount );
        model.addAttribute("paging", paging);
        model.addAttribute("admincomment", Board);

    }

    @GetMapping("/admin/board")
    public String boardpage(Model model, AdminBoardDTO Board){
        
        MemberVO user = (MemberVO)httpSession.getAttribute("user");
        
        model.addAttribute("profileuser", user);        

        adminUtil.setContentPage(model, "board");

        BoardPaging(model, Board);

        return "member/adminpage";
    }

    @PostMapping("/admin/board/view")
    @ResponseBody
    public AdminBoardDTO board_view(int board_id){

        return boardDAO.adminboarddetail(board_id);
    }


}
