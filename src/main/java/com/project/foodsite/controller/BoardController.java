package com.project.foodsite.controller;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.foodsite.dao.BoardDAO;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.dao.ReviewDAO;
import com.project.foodsite.vo.BoardVO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.ReviewVO;

import lombok.RequiredArgsConstructor;

import com.project.foodsite.dto.RecipeDTO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequiredArgsConstructor
public class BoardController {

    private final BoardDAO boardDao;
    private final HttpSession session;
    private final ReviewDAO reviewDao;

    // board list 조회
    @GetMapping("/list.do")
    public String boardList(Model model) {
        List<BoardVO> list = boardDao.selectAll();
        model.addAttribute("list", list);

        // 레시피 후기 탭의 조회 
        List<ReviewVO> reviewList = reviewDao.reviewLatest();
        model.addAttribute("reviewList", reviewList);

        return "board/board_list";
    }

    // board 검색
    @PostMapping("/search.do")
    public String boardSearch(Model model, String search) {
        List<BoardVO> list = boardDao.search(search);

        model.addAttribute("list", list);
        model.addAttribute("searchWord", search); // 검색어 보관
        return "board/board_list";
    }
    ///////////////////////////////////////////////////////////////////////////////////////
    // --------------이거 전체 레시피쪽으로 가서 수정해야함----------------------

    /* recipe 등록 */

    // recipe 등록 폼
    @GetMapping("/regiRecipe.do")
    public String recipeForm(Model model, String id) {
        model.addAttribute("id", id);
        return "board/board_regiRecipe";
    }

    // 내 레시피 등록하기
    @PostMapping("/myrecipe.do")
    public String registerRecipe(RecipeDTO dto) {
        // 등록 데이터 잘 들어오는지 확인용
        System.out.println("등록하려는 레시피의 제목" + dto.getTitle());
        System.out.println("등록하려는 레시피의 재료" + dto.getVegetableName().size());
        System.out.println("등록하려는 재료의 양" + dto.getAmountV());

        boardDao.insertRecipe(dto); // 레시피테이블에 레시피 등록
        /**
         * 레시피테이블에 제목이랑 썸네일 이미지 등록 후 방금 등록한 레시피 ID가져오기
         * 재료테이블에 재료를 넣고, 조리순서 테이블에 조리순서, 이미지를 넣어 아까 만든 레시피 ID와 연결
         * 게시판 테이블에 레시피ID, member_id를 참조하게 하고 제목, 내용 넣기
         */

        return "redirect:/list.do";
    }


//여기서 부터 커뮤니티 상세보기

    @GetMapping("/view.do")
    public String boardView(int board_id, Model model, HttpServletRequest req) {
        @SuppressWarnings("unchecked")
        HashMap<String, LinkedList<Integer>> map = session.getAttribute("viewMap") == null ? new HashMap<>() : 
            (HashMap<String, LinkedList<Integer>>) session.getAttribute("viewMap");

        //세션에서 IP, 게시글 ID를 확인해 없을경우 조회수 증가
        if(map.get(req.getRemoteAddr()) == null && !map.get(req.getRemoteAddr()).contains(board_id)){
            // 조회수 증가
            boardDao.updateViewCount(board_id);
            map.computeIfAbsent(req.getRemoteAddr(), k -> new LinkedList<>()).add(board_id);
            session.setAttribute("viewMap", map);
            session.setMaxInactiveInterval(3600);
        }

        // 게시글 조회
        BoardVO board = boardDao.selectOne(board_id);

        model.addAttribute("board", board);

        return "board/board_view";
    }

    // 상세보기 수정 폼
    @GetMapping("/update_form.do")
    public String updateForm(int board_id, HttpSession session, Model model) {
        BoardVO board = boardDao.selectOne(board_id);
        model.addAttribute("board", board);
        return "board/board_update";
    }

    // 상세보기 수정
    @PostMapping("/update.do")
    public String update(BoardVO vo) {

        int res = boardDao.update(vo);

        System.out.println("수정 결과 : " + res);

        return "redirect:/view.do?board_id=" + vo.getBoard_id();
    }

    // 상세보기 삭제
    @GetMapping("/delete.do")
    public String delete(int board_id,
            HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        BoardVO board = boardDao.selectOne(board_id);

        System.out.println("로그인 사용자 : " + user.getMember_id());
        System.out.println("게시글 작성자 : " + board.getMember_id());

        int res = boardDao.delete(board_id);

        System.out.println("삭제 결과 : " + res);

        return "redirect:/list.do";
    }

    //커뮤니티 글쓰기 폼
    @GetMapping("/community_form.do")
    public String communityForm() {
        return "board/community_form";
    }

    //커뮤니티 글쓰기
    @PostMapping("/community_write.do")
    public String write(BoardVO vo, HttpSession session) {

        MemberVO user = (MemberVO) session.getAttribute("user");

        vo.setMember_id(user.getMember_id());

        boardDao.insertBoard(vo);

        return "redirect:/list.do";
    }

}
