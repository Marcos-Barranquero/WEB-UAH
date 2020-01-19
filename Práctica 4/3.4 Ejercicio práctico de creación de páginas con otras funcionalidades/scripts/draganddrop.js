function allowDrop(ev) {
    // Permite que algo pueda recibir elementos
    ev.preventDefault();
}

function drag(ev) {
    // Para sacar un elemento de su sitio original
    ev.dataTransfer.setData("text", ev.target.id);
}

function drop(ev) {
    // Para incorporar un elemento a un nuevo sitio
    ev.preventDefault();
    var data = ev.dataTransfer.getData("text");
    ev.target.appendChild(document.getElementById(data));
}