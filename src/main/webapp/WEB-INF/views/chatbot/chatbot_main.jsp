<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <!DOCTYPE html>
    <html>

    <head>
        
    </head>

    <body>

        <!-- 챗봇 -->
        <input type="button" class="chatbot-fixed-btn" value="?" onclick="openChatbot()" />

        <div class="chatbot-wrap" id="chatbotWrap">

            <div class="chat-header">
                <img src="/images/bot.png" class="bot-icon">
                <span>도우미봇</span>
                <button type="button" class="chat-close-btn" onclick="closeChatbot()">x</button>
            </div>

            <div class="chat-body" id="chatBody">

                <div class="bot-row">
                    <img src="/images/bot.png" class="bot-icon">
                    <div class="bot-msg">
                        안녕하세요! 무엇을 도와드릴까요?
                    </div>
                </div>

                <div class="quick-menu" id="parentMenu"></div>

            </div>

        </div>

    </body>

    </html>