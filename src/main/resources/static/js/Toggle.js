// 1. import 구문은 무조건 맨 위로!
import { Application } from "https://esm.sh/@splinetool/runtime";

function d2r(d) {
    return d * (Math.PI / 180);
}

function objectArray(all, name) {
    return all.filter(item => item.name == name);
}

function getDuplicateNameObjects(app, obj, name) {
    if (new RegExp(name).test(obj.name)) {
        return true;
    }
    return false;
}

// 2. HTML에 있는 canvas 태그를 들고 와서 스플라인 실행
const canvas = document.getElementById('canvas3d');
const app = new Application(canvas);

// 3. 여기에 아까 복사한 네 진짜 템플릿 주소를 붙여넣어!
app.load('https://prod.spline.design/qXtC3-mf0XWS1la0/scene.splinecode')
    .then(() => {
        console.log('3D 토글 버튼 로드 완료!');
    });