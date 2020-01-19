var la = document.getElementById("lat"); // Para escribir la latitud
var lo = document.getElementById("lon"); // Para escribir la longitud

function getLocation() {
    if (navigator.geolocation) {
        // Si el navegador admite la geolocalización, la pide
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        // Si el navegador no la admite, avisa de ello
        la.innerHTML = "El navegador no soporta la geolocalización.";
    }
}

function showPosition(position) {
    la.innerHTML = "Latitud: " + position.coords.latitude;      // Muestra la latitud
    lo.innerHTML = "Longitud: " + position.coords.longitude;    // Muestra la longitud
}