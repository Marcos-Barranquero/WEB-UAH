function clickCounter() {
    if (typeof (Storage) !== "undefined") {
        // Si el navegador lo soporta:
        if (localStorage.clickcount) {
            // Si existe ya el valor, se suma 1
            localStorage.clickcount = Number(localStorage.clickcount) + 1;
        } else {
            // Si no existe, se establece en 1 porque será el primero
            localStorage.clickcount = 1;
        }

        // Se muestra el contador, diferenciando entre singular y plural
        if (localStorage.clickcount == 1) {
            document.getElementById("contador").innerHTML = "Has donado " + localStorage.clickcount + " árbol.";
        } else {
            document.getElementById("contador").innerHTML = "Has donado " + localStorage.clickcount + " árboles.";
        }

    } else {
        // Si el navegador no lo soporta:
        document.getElementById("contador").innerHTML = "Tu navegador no te deja usar esta función.";
    }
}

function limpiar() {
    if (typeof (Storage) !== "undefined") {
        // Si el navegador lo admite, borra la memoria local
        localStorage.clear();
        document.getElementById("contador").innerHTML = "Todos los árboles han sido deforestados satisfactoriamente.";
    } else {
        // Si el navegador no admite esta función, informa igual que antes
        document.getElementById("contador").innerHTML = "Tu navegador no te deja usar esta función.";
    }
}