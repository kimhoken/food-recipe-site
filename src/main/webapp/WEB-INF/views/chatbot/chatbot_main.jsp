<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
    <html>

    <head>
        <link rel="stylesheet" href="/css/chatbot.css" />

        <script>
            window.onload = function () {
                loadParentMenu();
            };

            // 챗봇 메시지를 화면에 추가
            function addBotMsg(text) {
                const chatBody = document.getElementById('chatBody');

                const botRow = document.createElement('div');
                botRow.className = 'bot-row';

                const botIcon = document.createElement('img');
                botIcon.className = 'bot-icon';
                botIcon.src = '/image/bot.png';

                const div = document.createElement('div');
                div.className = 'bot-msg';
                div.innerText = text;

                botRow.appendChild(botIcon);
                botRow.appendChild(div);

                chatBody.appendChild(botRow);

                // scrollTop: 현재 스크롤 위치
                // scrollHeight: 전체 내용 높이
                chatBody.scrollTo({
                    top: chatBody.scrollHeight,
                    behavior: "smooth"
                });
            }

            // 사용자가 선택한 내용을 화면에 추가
            function addUserMsg(text) {
                const chatBody = document.getElementById('chatBody');

                const div = document.createElement('div');
                div.className = 'user-msg';
                div.innerText = text;

                chatBody.appendChild(div);
                chatBody.scrollTo({
                    top: chatBody.scrollHeight,
                    behavior: "smooth"
                });
            }

            function removeMenu() {
                const oldMenu = document.querySelector('.quick-menu');

                if (oldMenu != null) {
                    oldMenu.remove();
                }
            }

            function loadParentMenu() {
                const chatBody = document.getElementById('chatBody');

                removeMenu();

                const parentMenu = document.createElement('div');
                parentMenu.className = 'quick-menu';
                parentMenu.id = 'parentMenu';
                chatBody.appendChild(parentMenu);

                fetch('/chatbot/parent')
                    .then(res => res.json())
                    .then(data => {
                        data.forEach(item => {
                            const btn = document.createElement('button');

                            btn.type = 'button';
                            btn.innerText = item.question;

                            btn.onclick = function () {
                                loadSubMenu(item.id, item.question);
                            };

                            parentMenu.appendChild(btn);
                        });

                        chatBody.scrollTo({
                            top: chatBody.scrollHeight,
                            behavior: "smooth"
                        });
                    });
            }

            function loadSubMenu(id, question) {
                removeMenu();

                addUserMsg(question);
                addBotMsg('궁금한 항목을 선택해주세요.');

                const chatBody = document.getElementById('chatBody');

                const subMenu = document.createElement('div');
                subMenu.className = 'quick-menu';
                subMenu.id = 'subMenu';
                chatBody.appendChild(subMenu);

                // 선택한 1단계 id를 기준으로 서브 질문 조회
                fetch('/chatbot/sub?id=' + id)
                    .then(res => res.json())
                    .then(data => {

                        // 서브 질문 갯수만큼 생성
                        data.forEach(item => {
                            const btn = document.createElement('button');

                            btn.type = 'button';
                            btn.innerText = item.question;

                            btn.onclick = function () {
                                removeMenu();

                                addUserMsg(item.question);

                                if (item.question === '관리자에게 문의하기') {
                                    location.href = '/inquiry';
                                    return;
                                }

                                if (item.answer != null && item.answer !== '') {
                                    addBotMsg(item.answer);
                                    addBotMsg('다른 궁금한 점이 있으신가요?');
                                    loadParentMenu();
                                }
                            };

                            subMenu.appendChild(btn);
                        });

                        // 뒤로가기 버튼 생성
                        const backBtn = document.createElement('button');
                        backBtn.type = 'button';
                        backBtn.className = 'back-btn';
                        backBtn.innerText = '뒤로가기';

                        // 뒤로가기 클릭 시 대화 내용은 유지하고 1단계 메뉴만 다시 출력
                        backBtn.onclick = function () {
                            removeMenu();
                            loadParentMenu();
                        };

                        subMenu.appendChild(backBtn);

                        chatBody.scrollTo({
                            top: chatBody.scrollHeight,
                            behavior: "smooth"
                        });
                    });
            }

            function closeChatbot() {
                document.getElementById('chatbotWrap').style.display = 'none';
            }
        </script>
    </head>

    <body>

        <div class="chatbot-wrap" id="chatbotWrap">

            <div class="chat-header">
                <img src="/image/bot.png" class="bot-icon">
                <span>cook봇</span>
                <button type="button" class="chat-close-btn" onclick="closeChatbot()">×</button>
            </div>

            <div class="chat-body" id="chatBody">

                <div class="bot-row">
                    <img src="/image/bot.png" class="bot-icon">
                    <div class="bot-msg">
                        안녕하세요! 무엇을 도와드릴까요?
                    </div>
                </div>

                <div class="quick-menu" id="parentMenu"></div>

            </div>

        </div>

    </body>

    </html>