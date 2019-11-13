/**
 * 
 */

var socket=null;

$(document).ready(function(){
	var ws=new WebSocket("ws://localhost:8083/echo");
	socket=ws; 
	connectWS();
	

 $("#btn-chat").click(function() {
        sendMessage();
     	 $('#btn-input').val('')
  });
  $("#btn-input").keydown(function(key) {
          if (key.keyCode == 13) {// 엔터
                 sendMessage();
                 $('#btn-input').val('');
          }
  });
		
});
function connectWS(){
	
	socket.onopen = function(){
		console.log("커넥션 완료");
		
	};
	
	socket.onmessage = function(event){
		var msg=event.data;
		console.log("받는 메세지 " , msg);
		var msgSplit = msg.split(",");
		
		for (var i in msgSplit){
			console.log(msgSplit[i]);
		};

	};
	
}
	function sendMessage() {
    	socket.send($("#btn-input").val());
		console.log();
		$("#message_send").append($("#btn-input").val());
    };

		
		
		
