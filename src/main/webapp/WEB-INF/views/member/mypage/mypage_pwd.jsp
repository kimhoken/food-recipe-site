<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section>

        
        <div id="pwd_box">
            <h2>비밀번호 재설정 페이지</h2>
            <input placeholder="비밀번호 입력해주세요!" id="pwdUserCheck"/>
            <input type="button" value="비밀번호 확인" onclick="pwdUserCheck()"/>
        </div>
   
   
        <div id="pwd_reset_box" style="display: none;">
            <form class="find-form">

                        <h2 class="find-title">비밀번호 재설정</h2>
                        <div class="find-row">
                            <span class="find-label">비밀번호</span>
                            <div class="find-control">
                                <input type="password" class="find-input" id="pwd" name="pwd" placeholder="비밀번호 입력하세요"
                                    oninput="pwdchange()" />
                                <div class="find-msg" id="pwd_msg">영문 특수문자 10글자 이상</div>
                            </div>
                        </div>

                        <div class="find-row">
                            <span class="find-label">비밀번호 확인</span>
                            <div class="find-control">
                                <input type="password" id="pwd_check" name="pwd_check" placeholder="비밀번호 확인 입력하세요"
                                    oninput="pwdchange()" />
                                <div class="find-msg" id="pwd_check_msg"></div>
                            </div>
                        </div>


                        <input type="button" class="find-main-btn" value="비밀번호 재설정" onclick="send(this.form)" />

                    </form>

        </div>

    
</section>