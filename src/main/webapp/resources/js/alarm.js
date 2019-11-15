/**
 * 
 */

	var SessionUserid="";
	var SessionNickname="";
	var socket=null;
	//jsp가 준비되면 커넥션
	$(document).ready(function(){
		SessionUserid=$("#SessionUserid").val();
		SessionNickname=$("#SessionNickname").val();
		console.log("현재 세션에 연결된 아이디 : "+SessionUserid);
		console.log("현재 세션에 연결된 닉네임 : "+SessionNickname);
		var ws=new WebSocket("ws://192.168.0.34:8083/echo");
		socket=ws; 
		connectWS();
	
	 $("#btn-chat").click(function() {
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
				chatMessage(msgSplit);
				$('#message_send').scrollTop($('#message_send').prop('scrollHeight'));
			}
			//ReviewReply라면 ->리뷰게시판 댓글
			else if(msgSplit[0]=="ReviewReply"){
				ReviewReplyRecive(msgSplit);
			}
			
		};
		
		$("#alarm").on("click", "button", function() {
			$("#alarm").html("");
			
		});
		
	}
		//채팅 버튼을 누르면 보내는 메세지
		function ChatSendMessage() {
	    	socket.send("msg@%%\^websocket@%%\^"+SessionUserid+"@%%\^"+$("#btn-input").val()+"@%%\^"+SessionNickname);
			console.log();
	    };
	    
	    //채팅을 보내면  메세지값 넣기
	    //순서 : msg websocket sessionuserid 메세지값 닉네임
		function chatMessage(msg){
			var str="";
				if(SessionUserid==msg[2] && msg[3]!=""){
					str +="<div class='row msg_container base_sent'";
					str +=" style='margin-bottom: 15px; border: 2px solid #5AAEFF; border-radius: 10px; '>";
					str +="<div class='col-md-10 col-xs-10'>";
					str +="<div class='messages msg_sent'> ";
					str += msg[3]+"</div></div>";
					str +="<div class='col-md-2 col-xs-2 avatar'>";
					str += "<img src='http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg' class=' img-responsive '>"
					str += "</div>";
					$("#message_send").append(str);
				}else if(msg[3] =="" ){
					console.log("채팅에 공백만 넣지마라");
				}else {
					str +="<div class='row msg_container base_receive'";
					str +=" style='margin-bottom: 15px; border: 2px solid #5AAEFF; border-radius: 10px'>";
					str +="<div class='col-md-2 col-xs-2 avatar'>";
					str +="<img src='http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg'";
					str +=" class='img-responsive'></div>";
					str +="<div class='col-md-10 col-xs-10'>";
					str +="<div class='messages msg_receive'>";
					if(msg[4]===""){
						str += msg[2]+" : "+msg[3]+"</div></div></div>";
					}else{
						str += msg[4]+" : "+msg[3]+"</div></div></div>";
					}
					$("#message_send").append(str);	
				}	
		};
		
		//리뷰 게시판에 댓글을 달면 알람을 발생시킬 메세지 전송
		function ReviewReplySend(){
			socket.send("ReviewReply"+"@%%\^"+SessionUserid+"@%%\^"+bno+"@%%\^"+title+"@%%\^"+writer);
		};
		function ReviewReplyRecive(msg){
			//ReviewReply,userid,bno,title,writer 순서
			console.log("현재 세션아이디와 writer가 같은지 : "+SessionUserid==msg[4]);
			//메세지의 writer와 현재 존재하는 세션의 userid가 같다면
			if(msg[4]==SessionNickname){
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p>리뷰 게시판 "+msg[3]+"게시글에 댓글이 생성되었습니다.  <a id='chageUrl'>게시글 확인하러가기</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/review/reviewread?bno="+msg[2]);
				$("#alarm").attr("tabindex",-1).focus();
				
			};	
		}
		
	
		
	
			
			
