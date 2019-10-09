<!DOCTYPE html>  
<html>  
<head>  
<meta charset="UTF-8">  
<title>Let's Chat</title>  
<script type="text/javascript" src="js/sockjs.min.js"></script>  
<script type="text/javascript" src="js/jquery.js"></script>  
<link rel="stylesheet" href="css/test.css" />
<link rel="stylesheet" href="css/reset.css" />
<link href="images/student_128px_1159917_easyicon.net.ico" rel="shortcut icon"/>
<script type="text/javascript">  
    var url = "127.0.0.1:8080/WebsocketTest";  
    var websocket = null;  
    if ('WebSocket' in window) {  
        websocket = new WebSocket("ws://" + url + "/chat.sc");  
    } else {  
        websocket = new SockJS("http://" + url + "/sockjs/chat.sc");  
    }  
    websocket.onopen = onOpen;  
    websocket.onmessage = onMessage;  
    websocket.onerror = onError;  
    websocket.onclose = onClose;  
  
    function onOpen(openEvent) {  
        document.getElementById("plane").innerHTML = document.getElementById("plane").innerHTML+ "Welcome to the Chatroom<br/>"; 
    }  
  
    function onMessage(event) {  
    	if(typeof event.data =='string'){
    		var element = document.createElement("p");
    		element.innerHTML=event.data;
        	document.getElementById("plane").appendChild(element);
    	}else{
    		var reader = new FileReader();
			reader.onload=function(eve){
				 if(eve.target.readyState==FileReader.DONE)
				 {
					var img = document.createElement("img");
					img.src=this.result;
					img.width=300;
					document.getElementById("plane").appendChild(img);
				 }
			 };
			 reader.readAsDataURL(event.data);
    	}
    	$(".plane").scrollTop($(".plane")[0].scrollHeight);
    }  
    function onError() {  
    }  
    function onClose(event) {  
    	console.log(event.reason)
        document.getElementById("plane").innerHTML = document.getElementById("plane").innerHTML+ "Quit Already<br/>";  
    }  
  
    function doSend() {  
        if (websocket.readyState == 1) {  //0-CONNECTING;1-OPEN;2-CLOSING;3-CLOSED
            var msg = document.getElementById("message").value;
            if(msg){
            	websocket.send(msg); 
            }
            sendFile(msg);
            document.getElementById("message").value="";
        } else {  
            alert("connect fail!");  
        }  
    }  
      
    function sendFile(isWithText){
		var inputElement = document.getElementById("file");
		var fileList = inputElement.files;
		var file=fileList[0];
		if(!file) return;
		websocket.send(file.name+":fileStart");
		var reader = new FileReader();
		//以二进制形式读取文件
		reader.readAsArrayBuffer(file);
		//文件读取完毕后该函数响应
		reader.onload = function loaded(evt) {
	        var blob = evt.target.result;
	        //发送二进制表示的文件
	        websocket.send(blob);
	        if(isWithText){
	        	websocket.send(file.name+":fileFinishWithText");
	        }else{
	        	websocket.send(file.name+":fileFinishSingle");
	        }
	        console.log("finnish");
		}
		inputElement.outerHTML=inputElement.outerHTML; //清空<input type="file">的值
	}
    
    function disconnect(){  
        if (websocket != null) {  
            websocket.close();  
            websocket = null;  
        }  
    }  
      
    function reconnect(){  
        if (websocket != null) {  
            websocket.close();  
            websocket = null;  
        }  
        if ('WebSocket' in window) {  
            websocket = new WebSocket("ws://" + url + "/chat.sc");  
        } else {  
            websocket = new SockJS("http://" + url + "/sockjs/chat.sc");  
        }  
        websocket.onopen = onOpen;  
        websocket.onmessage = onMessage;  
        websocket.onerror = onError;  
        websocket.onclose = onClose;  
    }  
</script>  
</head>  
<body>  
    <div class="div_1">
		<h1>Let's Chat</h1>
	</div>
	<div id="plane" class="plane"></div>
    <div class="div_2">  
        <button id="disconnect" class="disconnect" onclick="disconnect()">Quit</button>  
        <button id="reconnect" onclick="reconnect()">Login</button>  
        <input type="file" id="file" />
    </div>  
    <div class="div_3">  
       <input id="message" class="text" placeholder="text/file" type="text" style="width: 250px"></input>  
       <button id="send" onclick="doSend()">send</button>
    </div>  
</body>  
</html>  