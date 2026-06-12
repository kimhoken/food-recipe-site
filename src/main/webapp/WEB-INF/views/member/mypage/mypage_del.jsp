<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <section>
            <form>
                <input type="hidden" name="member_id" value="${user.member_id}"/>
                <div>
                    <h3>회원 탈퇴</h3>
                    <pre>
                    <div>           
                        정말 탈퇴하시겠습니까?
    
                        탈퇴 시 계정 정보는 비활성화되며 서비스 이용이 제한됩니다.
    
                        작성하신 레시피와 댓글은 서비스 운영을 위해 유지될 수 있으며,
                        작성자 정보는 탈퇴회원으로 변경됩니다.
    
                        탈퇴 후에는 계정 복구가 어려울 수 있습니다.
                    </div>
                </pre>

                    <input type="checkbox" id="agree_box" name="agree" />
                    <span onclick="agree()">위 안내사항을 모두 확인했으며 회원 탈퇴에 동의합니다.</span>

                    <c:if test="${not empty user.login_id }">
                        <div>
                            <h3>본인 확인</h3>
                            <p>회원 탈퇴를 원하시면 비밀번호 입력하세요</p>
                            <input name="password" type="password" placeholder="비밀번호 입력하세요" />
                        </div>
                    </c:if>

                    <c:if test="${not empty user.provider}">
                        <div>
                            <h3>본인 확인</h3>
                            <p>회원 탈퇴를 원하시면 아래의 문구를 입력하세요</p>
                            <input name="str" placeholder="오늘 뭐먹지?를 탈퇴합니다." />
                        </div>
                    </c:if>

                    <input type="button" value="탈퇴하기" onclick="disableuser(this.form)" />
                </div>
            </form>
        </section>