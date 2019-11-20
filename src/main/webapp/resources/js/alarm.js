/**
 * 
 */

	var SessionUserid="";
	var SessionNickname="";
	var socket=null;
	var SessionGroupCode="";
	//jsp가 준비되면 커넥션
	$(document).ready(function(){
		SessionUserid=$("#SessionUserid").val();
		SessionNickname=$("#SessionNickname").val();
		SessionAdmin=$("#SessionAdmin").val();
		SessionGroupCode=$("#groupCode").val();
		console.log("현재 세션에 연결된 아이디 : "+SessionUserid);
		console.log("현재 세션에 연결된 닉네임 : "+SessionNickname);
		console.log("현재 자신의 페이지는 : "+flagPage);
		console.log("Admin 이라면 1 :"+SessionAdmin);
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
			if(msgSplit[0]=="msg" && msgSplit[1]=="websocket" && msgSplit[5]==SessionGroupCode){
				//split으로 자른것이 msg라면 ->채팅
				chatMessage(msgSplit);
				$('#message_send').scrollTop($('#message_send').prop('scrollHeight'));
			}
			else if(msgSplit[0]=="ReviewReply"){			
				//ReviewReply라면 ->리뷰게시판 댓글
				ReviewReplyRecive(msgSplit);
			}else if(msgSplit[0]=="Support" && msgSplit[1]=="Admin"){
				//그룹 신청이 오면 관리자에게 보내는 메세지 함수
				SupportAdminAlarm(msgSplit);
			}else if(msgSplit[0]=="adminAccept"){
				//그룹 승인후 승인받은 리더에게 보내는 메세지 함수
				groupLeaderAlarm(msgSplit);
			}else if(msgSplit[0]=="groupReply"){
				groupReplyRecive(msgSplit);
			}else if(msgSplit[0]=="groupkick"){
				groupKickAlarm(msgSplit);	
			}else if(msgSplit[0]=="changeLeader"){
				groupChangeLeader(msgSplit);
			}
			
		};
		
		$("#alarm").on("click", "button", function() {
			$("#alarm").html("");
			
		});
		
	}
		//채팅 버튼을 누르면 보내는 메세지
		function ChatSendMessage() {
	    	socket.send("msg@%%\^websocket@%%\^"+SessionUserid+"@%%\^"+
	    		       $("#btn-input").val()+"@%%\^"+SessionNickname+"@%%\^"+SessionGroupCode);
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
					console.log("채팅에 공백만 넣었습니다.");
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
			socket.send("ReviewReply"+"@%%\^"+SessionUserid+"@%%\^"+bno+"@%%\^"+title+"@%%\^"+writer+"@%%\^"+flagPage);
		};
		function ReviewReplyRecive(msg){
			//ReviewReply,userid,bno,title,writer 순서
			console.log("현재 세션아이디와 writer가 같은지 : "+SessionUserid==msg[4]);
			//메세지의 writer와 현재 존재하는 세션의 userid가 같다면
			if(msg[4]==SessionNickname && msg[5]!=flagPage){
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
		//그룹페이지 알람을 위해 다음과같은 데이터를 보냄
		function SupportAdmin(){
			socket.send("Support"+"@%%\^"+"Admin"+"@%%\^"+SessionUserid+"@%%\^"+flagPage);
		};
		// 위에서 받은 데이터와 자신의 세션값과 비교하여 admin이라면 알람이 띄워짐
		function SupportAdminAlarm(msg){			
			if(msg[3]!=flagPage && SessionAdmin==1){
				
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p>"+msg[2]+"님이 그룹을 신청하셨습니다!  <a id='chageUrl'>신청 확인하러가기!</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/admin/group");
				$("#alarm").attr("tabindex",-1).focus();
			}
		}
		function adminAccept(){
			var leader = $("#leader").val();
			var groupName= $("#groupName").val();
			socket.send("adminAccept"+"@%%\^"+leader+"@%%\^"+groupName);
		}
		
		function groupLeaderAlarm(msg){	
			if(msg[1]==SessionNickname ){
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p>"+msg[2]+"그룹 신청이 허가되었습니다. 그룹페이지를 사용하려면 재접속을 해주세요! <a id='chageUrl'>재접속</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/logout");
				$("#alarm").attr("tabindex",-1).focus();
			};	
			
		}
		function groupReply(){
	 		var groupCode=$("#groupCode").val();
			var writerCheck=$("#writer").val();
			var titleCheck=$("#title").val();
			var bnoCheck=$("#bno").val();
			socket.send("groupReply"+"@%%\^"+groupCode+"@%%\^"+writerCheck+"@%%\^"+titleCheck+"@%%\^"+bnoCheck);
		}
		
		function groupReplyRecive(msg){
			if(msg[2]==SessionNickname && flagPage!="board-read"){
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p>그룹페이지 "+msg[3]+"게시판에 댓글이 생성되었습니다!. <a id='chageUrl'>게시글 확인하러가기</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/"+msg[1]+"/board/read/"+msg[4]+"?msg="+"endPageCheck");
				$("#alarm").attr("tabindex",-1).focus();
			};	
		}
		function groupKick(){
			var nickName = $("#modalNick").val();
			var content = $("#modalContent").val();
			var groupName= $("#groupName").val();
			socket.send("groupkick"+"@%%\^"+nickName+"@%%\^"+content+"@%%\^"+groupName);
			
		}
		function groupKickAlarm(msg){
			if(msg[1]==SessionNickname && msg[2] !="" && msg[2].length !=0){
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p> "+msg[3]+"그룹에서 추방되었습니다. 재접속을 부탁드립니다. 사유 :"+msg[2]+" <a id='chageUrl'>재접속 하기</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/logout");
				$("#alarm").attr("tabindex",-1).focus();	
			}else{
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p> "+msg[3]+"그룹에서 추방되었습니다. 재접속을 부탁드립니다. 사유 :관리자에게 문의하세요.  <a id='chageUrl'>재접속 하기</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/logout");
				$("#alarm").attr("tabindex",-1).focus();
			}
		}
		function changeLeader(){
			var nickName = $("#modalNick").val();
			var content = $("#modalContent").val();
			var groupName= $("#groupName").val();
			alert(nickName+content+groupName);
			socket.send("changeLeader"+"@%%\^"+nickName+"@%%\^"+content+"@%%\^"+groupName);
			
		}
		function groupChangeLeader(msg){
			if(msg[1]==SessionNickname && msg[2] !="" && msg[2].length !=0){
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p> "+msg[3]+"그룹의 리더가 되었습니다. 재접속을 부탁드립니다. 사유 :"+msg[2]+" <a id='chageUrl'>재접속 하기</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/logout");
				$("#alarm").attr("tabindex",-1).focus();	
			}else{
				var str="";
				str +=	"<div class='alert alert-success' role='alert' id='alarmDiv'>" ;			
				str +="<p> "+msg[3]+"그룹의 리더가 되었습니다. 재접속을 부탁드립니다. 사유 :개인적인 사정으로 리더의 역할을 위임해드립니다.  <a id='chageUrl'>재접속 하기</a>";
				str +="<button type='button' class='btn btn-danger' style='float: right; vertical-align:middle;' id='alarmBtn' >닫기</button></p></div>"
				$("#alarm").css("display", "");
				$("#alarm").prepend(str);
				$("#chageUrl").attr("href","/logout");
				$("#alarm").attr("tabindex",-1).focus();
			}
		}
			
