$bert.do = function(erlang){
    console.log('msg from server');
    console.log(utf8_decode(erlang));

    var msg = utf8_decode(erlang);
    var log = document.getElementById('log')
    var li = document.createElement('li');
    li.innerHTML = msg;
    log.appendChild(li);
};


function magic() {
    var msg = document.getElementById('msg').value;
    ws.send(enc(tuple(atom('client'), utf8_toByteArray(msg))));
}
