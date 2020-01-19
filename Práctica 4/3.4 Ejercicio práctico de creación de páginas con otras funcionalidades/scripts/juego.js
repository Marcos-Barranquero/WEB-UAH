var canvas;
var ctx;
var img;
var x = 50;
var y = 50;
function gameLoop() {
    requestAnimationFrame(gameLoop);
    keyInput.inputLoop();
    ctx.fillStyle = "black";
    ctx.fillRect(0, 0, 1280, 720);
    ctx.save();
    ctx.translate(x, y);
    ctx.drawImage(img, 0, 0, img.width, img.height);
    ctx.restore();
}
var cKeyboardInput = (function () {
    function cKeyboardInput() {
        var _this = this;
        this.keyCallback = {};
        this.keyDown = {};
        this.addKeycodeCallback = function (keycode, f) {
            _this.keyCallback[keycode] = f;
            _this.keyDown[keycode] = false;
        };
        this.keyboardDown = function (event) {
            if (_this.keyCallback[event.keyCode] != null) {
                event.preventDefault();
            }
            _this.keyDown[event.keyCode] = true;
        };
        this.keyboardUp = function (event) {
            _this.keyDown[event.keyCode] = false;
        };
        this.inputLoop = function () {
            for (var key in _this.keyDown) {
                var is_down = _this.keyDown[key];
                if (is_down) {
                    var callback = _this.keyCallback[key];
                    if (callback != null) {
                        callback();
                    }
                }
            }
        };
        document.addEventListener('keydown', this.keyboardDown);
        document.addEventListener('keyup', this.keyboardUp);
    }
    return cKeyboardInput;
})();
function shipUp() {
    y -= 20;
}
function shipDown() {
    y += 20;
}
function shipLeft() {
    x -= 20;
}
function shipRight() {
    x += 20;
}
var keyInput;
window.onload = function () {
    img = document.getElementById('nave');
    canvas = document.getElementById('cnvs');
    ctx = canvas.getContext("2d");
    keyInput = new cKeyboardInput();
    // Para pulsar A o flecha izquierda:
    keyInput.addKeycodeCallback(37, shipLeft);
    keyInput.addKeycodeCallback(65, shipLeft);
    // Para pulsar W o flecha arriba:
    keyInput.addKeycodeCallback(38, shipUp);
    keyInput.addKeycodeCallback(87, shipUp);
    // Para pulsar D o flecha derecha:
    keyInput.addKeycodeCallback(39, shipRight);
    keyInput.addKeycodeCallback(68, shipRight);
    // Para pulsar S o flecha abajo:
    keyInput.addKeycodeCallback(40, shipDown);
    keyInput.addKeycodeCallback(83, shipDown);
    gameLoop();
}