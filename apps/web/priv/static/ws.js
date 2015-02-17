var wsUri = "ws://localhost:31337/ws/index?room=mychat";
var output;

function init() {
    output = document.getElementById("output");
    testWebSocket();
}

function testWebSocket() {
    websocket = new WebSocket(wsUri);
    websocket.onopen = function(event) {
        onOpen(event)
    };
    websocket.onclose = function(event) {
        onClose(event)
    };
    websocket.onmessage = function(event) {
        onMessage(event)
    };
    websocket.onerror = function(event) {
        onError(event)
    };
}

function onOpen(event) {
    writeToScreen("CONNECTED");
    doSend("WebSocket rocks");
}

function onClose(event) {
    writeToScreen("DISCONNECTED");
}

function onMessage(event) {
    writeToScreen('<span style="color: blue;">RESPONSE: ' + event.data + '</span>');
}

function onError(event) {
    writeToScreen('<span style="color: red;">ERROR:</span> ' + event.data);
}

function doSend(message) {
    writeToScreen("SENT: " + message);
    websocket.send(message);
}

function writeToScreen(message) {
    var pre = document.createElement("p");
    pre.style.wordWrap = "break-word";
    pre.innerHTML = message;
    console.log(pre);
//    output.appendChild(pre);
}
