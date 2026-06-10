<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <section>
            <div>
                <h3>회원 정보</h3>

                <div>
                    <span>이름</span>
                    <div>${user.name}</div>
                </div>

                <div>
                    <span>닉네임</span>
                    <div>${user.nickname}</div>
                </div>

                <div>
                    <span>등급</span>
                    <div>
                        <c:if test="${user.role eq 'USER'}">
                            일반 회원
                        </c:if>
                    </div>
                </div>


                <div>
                    <span>소개글</span>
                    <div>${user.member_intro}</div>
                </div>

                <div>
                    <span>이메일</span>
                    <div>${user.email}</div>
                </div>

                <div>
                    <span>가입일</span>
                    <div>${user.created_date}</div>
                </div>

                <div>
                    <a href="/mypage.do?menu=update">회원 정보 수정</a>
                </div>
            </div>
        </section>