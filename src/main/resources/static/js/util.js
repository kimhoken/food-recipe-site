function getActiveRoot(root) {
    return root || document.querySelector(".review-card.open") || document;
}

function setText(id, value, rootElement) {
    const root = getActiveRoot(rootElement);
    const target = root.querySelector("#model-" + id);

    if (!target) {
        return;
    }

    if (value == "public") {
        target.textContent = "public";
    } else if (value == "private") {
        target.textContent = "private";
    } else {
        target.textContent = value ?? "-";
    }
}

function setImg(id, src, rootElement) {
    const root = getActiveRoot(rootElement);
    const img = root.querySelector("#" + id);

    if (img) {
        img.src = src;
    }
}

function setImgs(id, imglist, rootElement) {
    const root = getActiveRoot(rootElement);
    const box = root.querySelector("#" + id);

    if (!box) {
        return;
    }

    box.innerHTML = "";

    if (!imglist || imglist.length == 0) {
        box.textContent = "-";
        return;
    }

    imglist.forEach(img => {
        box.innerHTML += `
            <img src="/upload/review/${img}"/>
        `;
    });
}

function setA(id, path, rootElement){
    const root = getActiveRoot(rootElement);
    const a = root.querySelector("#model-"+id);

    if(!a){
        return;
    }
    a.href = path ?? '#';
}

