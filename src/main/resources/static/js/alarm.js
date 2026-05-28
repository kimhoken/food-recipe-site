self.addEventListener('push', function(event){
    let title = "유통기한 임박!!";
    let options = {
        body: '유통기한이 얼마 남지 않은 제품이 있습니다!'
    };
    
    if (event.data) {
        try {
            const data = event.data.json();
            title = data.title || title;
            options.body = data.body || options.body;
        } catch(e) {
            // 만약 서버에서 JSON이 아닌 일반 텍스트로 보냈을 때를 위한 예외처리
            options.body = event.data.text();
        }
    }

    event.waitUntil(
        self.registration.showNotification(title, options)
    );
});

self.addEventListener('notificationclick', function(event) {
    event.notification.close(); // 알림 닫기
    event.waitUntil(
        clients.openWindow('/') // 클릭 시 이동할 URL (메인페이지 등)
    );
});