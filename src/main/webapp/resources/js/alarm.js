/**
 * 
 */

var socket=null;
//jsp가 준비되면 커넥션
$(document).ready(function(){
	var ws=new WebSocket("ws://192.168.0.10:8083/echo");
	socket=ws; 
	connectWS();
	

 $("#btn-chat").click(function() {
	 alert("123");
        ChatSendMessage();
     	 $('#btn-input').val('')
  });
  $("#btn-input").keydown(function(key) {
          if (key.keyCode == 13) {// 엔터
        	  ChatSendMessage();
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
		console.log("채팅에서받는 메세지 " , msg);
		var msgSplit = msg.split("@%%\^");
		//split으로 자른것이 msg라면 ->채팅
		if(msgSplit[0]=="msg" && msgSplit[1]=="websocket"){
			chatMessage(msgSplit[2]);
		}
		//ReviewReply라면 ->리뷰게시판 댓글
		if(msgSplit[0]=="ReviewReply"){
			ReviewReplyRecive(msgSplit);
		}
		
	};
	
}
	function ChatSendMessage() {
    	socket.send("msg@%%\^websocket@%%\^"+$("#btn-input").val());
		console.log();
    };
    
    //채팅을 보내면  메세지값 넣기
	function chatMessage(msg){
		var str="";
		str +="<div>"+msg+"</div>";
		$("#message_send").append(str);
		
	};
	
	//리뷰 게시판에 댓글을 달면 알람을 발생시킬 메세지 전송
	function ReviewReplySend(){
		socket.send("ReviewReply"+"@%%\^"+userid+"@%%\^"+bno+"@%%\^"+title+"@%%\^"+writer);
	};
	function ReviewReplyRecive(msg){
		//ReviewReply,userid,bno,title,writer 순서
		console.log("현재 세션아이디와 writer가 같은지 : "+userid==msg[4]);
		//메세지의 writer와 현재 존재하는 세션의 userid가 같다면
		if(msg[4]==userid){
			var str="";
			str +="<p>리뷰 게시판 "+title+"게시글에 댓글이 생성되었습니다!!</p>";
			$("#alarm").css("display", "");
			$("#alarm").prepend(str);
			$("#chageUrl").attr("href","reviewread?bno="+msg[2]);
			$("#alarm").attr("tabindex",-1).focus();
			
		};	
	}
	

		
		
