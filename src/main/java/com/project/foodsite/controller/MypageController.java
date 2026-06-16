package com.project.foodsite.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.PathVariable;

import com.project.foodsite.common.Fileupload;
import com.project.foodsite.common.Paging;
import com.project.foodsite.common.pwdSecurity;
import com.project.foodsite.dao.ActivityDAO;
import com.project.foodsite.dao.BookmarkDAO;
import com.project.foodsite.dao.CommentDAO;
import com.project.foodsite.dao.MemberDAO;
import com.project.foodsite.dao.RecipeDAO;
import com.project.foodsite.vo.BookmarkVO;
import com.project.foodsite.vo.CommentVO;
import com.project.foodsite.vo.MemberVO;
import com.project.foodsite.vo.RecipeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class MypageController {

    @Value("${file.upload.path}")
    private String uploadPath;


    private final HttpSession httpSession;    

    private final MemberDAO memberDAO;
    private final pwdSecurity pwdSecurity; 
    private final Fileupload fileupload;
    private final RecipeDAO recipeDAO;
    private final ActivityDAO activityDAO;
    private final CommentDAO commentDAO;
    private final BookmarkDAO bookmarkDAO;

    //레시피 페이징 함수
    private void userRecipePaging(int page, Model model, MemberVO user){
        

        int totalcount = recipeDAO.countUserRecipe(user.getMember_id());

        Paging paging = new Paging(page, 10, totalcount);

        Map<String,Object> map = new HashMap<>();

        map.put("member_id", user.getMember_id());
        map.put("offest", paging.getOffset());
        map.put("size", paging.getSize());

        List<RecipeVO> list = recipeDAO.getUserRecipeList(map);

        model.addAttribute("list", list);
        model.addAttribute("paging", paging);
    }

    //댓글 페이징 함수
    private void userCommentPaging(int page, Model model, MemberVO user){
        

        int totalcount = commentDAO.countUserComment(user.getMember_id());

        Paging paging = new Paging(page, 10, totalcount);

        Map<String,Object> map = new HashMap<>();

        map.put("member_id", user.getMember_id());
        map.put("offest", paging.getOffset());
        map.put("size", paging.getSize());

        List<CommentVO> list = commentDAO.getUserCommentList(map);

        model.addAttribute("list", list);
        model.addAttribute("paging", paging);
    }

    //북마크 페이징 함수
    private void userBookmarkPaging(int page, Model model, MemberVO user){
        

        int totalcount = bookmarkDAO.countUserBookmark(user.getMember_id());

        Paging paging = new Paging(page, 10, totalcount);

        Map<String,Object> map = new HashMap<>();

        map.put("member_id", user.getMember_id());
        map.put("offest", paging.getOffset());
        map.put("size", paging.getSize());

        List<BookmarkVO> list = bookmarkDAO.getUserBookmarkList(map);

        model.addAttribute("list", list);
        model.addAttribute("paging", paging);
    }

    public void userHomePage(Model model, int member_id){
        model.addAttribute("activity", activityDAO.userActivity(member_id)) ;
        model.addAttribute("recentlyRecipeList", recipeDAO.recentlyUserRecipe(member_id));
        model.addAttribute("commentList", commentDAO.userComment(member_id));
        model.addAttribute("bookmarkList", bookmarkDAO.userBookmark(member_id));
    }



    // 마이페이지 대시 카드 교체 함수 (기본값 활동내역 출력)
    private void setContentPage(Model model, String menu){

        
        String contentPage = "/WEB-INF/views/member/mypage/mypage_home.jsp";
        
        if (menu.equals("inquiry")) {
            contentPage = "/WEB-INF/views/member/mypage/mypage_inquiry.jsp";
        } else if (menu.equals("update")) {
            contentPage = "/WEB-INF/views/member/mypage/mypage_modify.jsp";            
        } else if (menu.equals("pwd")) {
            contentPage = "/WEB-INF/views/member/mypage/mypage_pwd.jsp";           
        } else if (menu.equals("del")) {
            contentPage = "/WEB-INF/views/member/mypage/mypage_del.jsp";            
        } else if (menu.equals("account" )){
            contentPage = "/WEB-INF/views/member/mypage/mypage_info.jsp";                       
        } else if (menu.equals("recipe")){
            contentPage = "/WEB-INF/views/member/mypage/mypage_myrecipe.jsp";                         
        } else if (menu.equals("comment")){
            contentPage = "/WEB-INF/views/member/mypage/mypage_mycomment.jsp";                          
        } else if (menu.equals("bookmark")){
            contentPage = "/WEB-INF/views/member/mypage/mypage_bookmark.jsp";                        
        } 
        
        model.addAttribute("contentPage",contentPage);
    }

    //회원의 레시피, 댓글, 북마크 갯수 조회하는 함수
    private void setTotalCount(int member_id,Model model){
        model.addAttribute("recipeCount", recipeDAO.countUserRecipe(member_id));
        model.addAttribute("commentCount", commentDAO.countUserComment(member_id));
        model.addAttribute("bookmarkCount", bookmarkDAO.countUserBookmark(member_id));
    }
    
    // 다른 회원 조회 기능
    @GetMapping("/user/{member_id}")
    public String viewUser(@PathVariable int member_id, Model model, String menu, Integer page){

        System.out.println("조회할 회원 ID: " + member_id);

        MemberVO profileUser = memberDAO.getUserByMemberId(member_id);

        if(page == null){
            page = 1;
        }
        
        if(menu == null){
            menu = "home";
        }
        
        if(profileUser == null){
            model.addAttribute("notfound",true);
            model.addAttribute("contentPage","/WEB-INF/views/member/mypage/mypage_profile_notfound.jsp");
            return "member/mypage/mypage_profile";
        }                      
        
        model.addAttribute("profileUser", profileUser);
        model.addAttribute(menu,"menu"); 
        
        String contentPage = "/WEB-INF/views/member/mypage/mypage_profile_home.jsp";
        userHomePage(model, member_id);

        
        if (menu.equals("recipe")){
            userRecipePaging(page, model, profileUser);
            contentPage = "/WEB-INF/views/member/mypage/mypage_profile_recipe.jsp";
        } else if(menu.equals("comment")){
            userCommentPaging(page, model, profileUser);
            contentPage = "/WEB-INF/views/member/mypage/mypage_profile_comment.jsp";
        } 

        setTotalCount(member_id, model);
        
        model.addAttribute("contentPage", contentPage);

        return "member/mypage/mypage_profile";
    }   

    //마이 페이지 조회 및 메뉴 선택 
    @GetMapping("/mypage.do")
    public String gomypage(Model model, String menu, Integer page) {        
        


        if(page == null){
            page = 1;
        }
        if(menu == null){
            menu = "home";
        }
        
        MemberVO user = (MemberVO) httpSession.getAttribute("user");

        if(user == null){
           
            setContentPage(model, menu);
            return "member/mypage";
        }
        System.out.println("회원 번호 : "+user.getMember_id());
        
        model.addAttribute("profileuser", user);
        
        model.addAttribute("menu", menu);
        
       
        
        if(menu.equals("home")){
            userHomePage(model,user.getMember_id());
        } else if(menu.equals("recipe")){
            userRecipePaging(page, model, user);
        } else if(menu.equals("comment")){
            userCommentPaging(page, model, user);
        } else if(menu.equals("bookmark")){
            userBookmarkPaging(page, model, user);
        }

        setTotalCount(user.getMember_id(), model);

        setContentPage(model, menu);
        
        return "member/mypage";
    }
   

    // 회원 정보 수정 기능
    @PostMapping("/mypage_update.do")
    public String update(MemberVO vo, String filechange) throws Exception{

        MemberVO user = (MemberVO)httpSession.getAttribute("user");
     

        String savePath = uploadPath + "/profile" ;
        System.out.println("경로:"+savePath);
        
        String filename = user.getProfile_img();

        MultipartFile photo = vo.getPhoto();
        // 기존이미지 삭제
        if(filechange.equals("yes")){

            fileupload.deleteFile(savePath, filename);

            filename ="no_file.png";

        }else if(photo != null && !photo.isEmpty()){

            fileupload.deleteFile(savePath, filename);
            filename = fileupload.saveFile(photo, savePath);

        }else{
            filename = user.getProfile_img();
        }

        vo.setMember_id(user.getMember_id());
        vo.setFilename(filename);

        int res = memberDAO.userUpdate(vo);

        if(res > 0){
            MemberVO updateduser = memberDAO.getUserByMemberId(vo.getMember_id());
            httpSession.setAttribute("user", updateduser);

            return "redirect:/mypage.do?menu=account";
        }else{
            return "redirect:/mypage.do?menu=update";

        }
                 
    }

    // 비밀번호 유효성 검사
    @PostMapping("/userpwdcheck.do")
    @ResponseBody
    public String userpwdcheck(String currpwd){

        MemberVO user = (MemberVO)httpSession.getAttribute("user");
             
        if(pwdSecurity.pwdDecoding(currpwd, user.getPassword())){
            return "ok";
        }
        return "no";

    }

    //비밀번호 재설정 기능
    @PostMapping("/resetpwdpage.do")
    @ResponseBody
    public String userrestpassword(String password){

        String enc_pwd = pwdSecurity.pwdEncoding(password);

        MemberVO user = (MemberVO)httpSession.getAttribute("user");

        MemberVO vo = new MemberVO();
        
        vo.setMember_id(user.getMember_id());
        
        vo.setPassword(enc_pwd);
        
        int res = memberDAO.userPwdUpdate(vo);
        
        if( res>0){
            return "success";
        } else{
            return "fail";
        }
    }

    //회원 탈퇴 기능
    @PostMapping("/secessionUser.do")
    @ResponseBody
    public String secessionuser( MemberVO vo){

        String savePath = uploadPath+"/profile";

        fileupload.deleteFile(savePath, vo.getProfile_img());

        vo.setStatus("no");
        vo.setLogin_id(null);
        vo.setPassword(null);
        vo.setNickname("탈퇴회원_"+vo.getMember_id());
        vo.setEmail("withdraw_"+ vo.getMember_id()+"@delete.com");
        vo.setProvider(null);
        vo.setProvider_id(null);
        vo.setMember_intro(null);
        vo.setName("탈퇴");
        vo.setProfile_img("no_file.png");
        
        int res = memberDAO.secessionUser(vo);

        if( res > 0 ){
            httpSession.removeAttribute("user");
            return "yes";
        }else{
            return "no";
        }        
        
    }

    

}
