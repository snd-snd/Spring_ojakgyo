/**
 * 글 읽기 페이지에서 댓글처리 및 버튼 관련 스크립트
 */
$(function(){
	
	var form = $("form");
	var code = '${group.groupCode }';
	var nickName = '${login.nickName}';
	var wirter = '${board.writer}';
	
	var likeBtn = $("#like");
	var modifyBtn = $("#modify");
	var removeBtn = $("#remove");
	var listBtn = $("#list");
	var registerBtn = $("#register");
	var nickName = '${login.nickName}';
	var code = '${group.groupCode}';
	
	
			
//	showList(1); //댓글 목록가져오기
	
	$("#buttons").find("button").hide();	
	if (nickName == wirter){
		modifyBtn.show();
		removeBtn.show();
		listBtn.show();
	} else {
		likeBtn.show();
		listBtn.show();
	}  
	
	removeBtn.on("click", function(){			
		var removeConfirm = confirm("게시물을 삭제하시겠습니까?");
		if(removeConfirm){
			form.attr("method", "get").submit();			
		}
	})

	listBtn.on("click", function(){
		form.find("input[name='bno']").remove();
		form.attr("action", "/"+code+"/board/list");
		form.submit();
	})
	
	var content = $("#content");
	var text = "<p>낙원을 온갖 때에, 불어 청춘의 끓는다. 인류의 이는 얼음이 대고, 작고 것이다. 귀는 천고에 가는 인류의 이상은 영락과 보라. 이상의 위하여서 피가 봄바람이다. 전인 때까지 아름답고 사막이다. 산야에 시들어 따뜻한 몸이 예가 천지는 눈이 봄바람이다. 싶이 황금시대의 가슴이 소담스러운 풀이 길을 이것은 이성은 피어나는 교향악이다. 안고, 가슴에 살 가치를 무엇이 방황하였으며, 속에서 있으랴? 맺어, 이상 이성은 있는 열락의 사람은 이것을 사막이다. 그들의 열락의 않는 지혜는 설산에서 칼이다.<br />";
	text+="	<br />끓는 인간의 것이 미인을 찾아다녀도, 기쁘며, 심장의 풀이 쓸쓸하랴? 있을 황금시대의 길지 꽃이 그들의 이성은 모래뿐일 철환하였는가? 풍부하게 같이 크고 인생에 끓는다. 피에 그림자는 속에서 가치를 거선의 더운지라 싹이 피가 봄바람이다. 가치를 방황하였으며, 품에 일월과 맺어, 것이다. 눈이 있는 밝은 바이며, 것은 너의 봄바람이다. 바이며, 곳으로 얼마나 그들은 있다. 수 이성은 원질이 인생을 없으면 황금시대를 것은 뼈 청춘의 것이다. 천고에 가는 고동을 수 품었기 같은 철환하였는가?<br />";
	text +="<br />목숨을 듣기만 위하여 심장의 구하기 못하다 것이다. 천지는 가치를 든 아니한 위하여서. 보내는 평화스러운 있는 얼마나 것이다. 영락과 많이 품으며, 풀이 끝에 인생의 싸인 아니다. 끝까지 곧 청춘 그것을 위하여, 그들의 살았으며, 것이다. 찾아 같은 품에 때문이다. 용감하고 꽃이 할지니, 있다. 없으면 꽃 것은 소금이라 갑 고행을 목숨이 그리하였는가? 부패를 않는 일월과 있다. 불어 웅대한 끝에 황금시대다. 피에 얼음과 사는가 구하기 두기 생생하며, 그들을 만천하의 쓸쓸하랴?</p>";
	
	content.html(text);
	
	// 댓글 추가 영역
	var replyContent = $("#replyContent");
	var bno = '{board.bno}';
	
	
	//댓글 등록
	registerBtn.click(function() {
		var params = {
				code:code,
				bno:bno,
				reply:$("textarea").val(),
				replyer:nickName
		};
		
 		replySerivce.add(params, function(result){
			if(result == "success"){
				$("textarea").val("");					
				showList(1);
			} else {
				alert("뭔가 잘못됐나본데?")
			}
		});
	})
	
	//댓글 삭제
	replyContent.on("click", "button[name='remove']", function(){
		var rno = $(this).data("rno");
		
		replySerivce.remove({code:code, rno:rno}, function(result){
			if(result){
				showList(1);
			}
		});
	})
	
	//댓글 수정
	replyContent.on("click", "button[name='config']", function(){
		
		replySerivce.read({code:code, rno:$(this).data("rno")}, function(result){
			$(this).closest("div[class='panel-heading']").hide();
			$(this).closest("div[class='panel-body']").hide();
		
			var html = "";
			
			html += "<nav class='panel'>";
			html += "<div class='panel-heading'>";
			html += "<span><i class='fa fa-user'></i><span>&ensp;</span>"+result.replyer+"</span>";
			html += "</div>";
			html += "<div class='panel-body'>";
			html += "<textarea class='form-control' data-reply='"+result.reply+"' placeholder='타인의 권리를 침해하거나 명예를 훼손하는 댓글은 운영원칙 및 관련 법률에 제재를 받을 수 있습니다.' rows='6'>"+result.reply+"</textarea>";
			html += "</div>";
			html += "<div class='panel-body text-right'>";
			html += "<button type='button' class='btn btn-warning' name='modify' data-rno='"+result.rno+"'><i class='fa fa-edit'></i><span>&ensp;</span>수정</button>";
			html += "<button type='button' class='btn btn-info' name='reset'><i class='fa fa-undo'></i><span>&ensp;</span>취소</button>";
			html += "</div>";
			html += "</nav>";	
						
			$(this).closest("nav").append(html);		
		})
	})
	
	//댓글 수정(수정)
	replyContent.on("click", "button[name='modify']", function(){
		var rno = $(this).data("rno");
		var reply = $(this).closest("textarea").data("reply");
		
		replySerivce.modify({code:code, rno:rno, reply:reply}, function(result){		
			showList(1);	
		})		
	})
			
	//댓글 수정(취소)
	replyContent.on("click", "button[name='reset']", function(){			
		$(this).closest("nav").siblings("div[class='panel-heading']").show();
		$(this).closest("nav").siblings("div[class='panel-body']").show();	
		$(this).closest("nav").remove();	
	})
	
	function showList(page){ //Read에 들어오면 글번호에 해당하는 댓글들을 가져와 뿌려줌
		replySerivce.getList({code:code,bno:bno,page:page||1}, function(list){
		
			console.log("list-length : " + list.length);			
			if (list == null || list.length == 0){
				replyContent.html("");
				return;
			}
			
			var html = "";
			for (var i=0, len=list.length||0; i<len; i++){							
				html += "nav class='panel'>";
				html += "<div class='panel-heading'>";
				html += "<span><i class='fa fa-user'></i><span>&ensp;</span>"+list[i].replyer+"&ensp;"+replySerivce.displayTime(list[i].regDate)+"</span>";
				if (list[i].replyer == nickName){
					html += "<div class='right'>";
					html += "<button type='button' name='config' data-rno='"+list[i].rno+"'><i class='lnr  lnr-cog'></i></button>";
					html += "<button type='button' name='remove' data-rno='"+list[i].rno+"'><i class='lnr lnr-cross'></i></button>";
					html += "</div>";
				}					
				html += "</div>";
				html += "<div class='panel-body'>";
				html += "<span class='replyContent' data-reply='"+list[i].reply+"'>"+list[i].reply+"</span>";
				html += "</div>";
				html += "<div class='panel-body'>";
				html += "<button type='button' class='btn btn-default' data-rno='"+list[i].rno+"' data-click='false'><i class='fa fa-pencil'></i><span>&ensp;</span>답글</button>";
				html += "</div>";
				html += "</nav>";
			}
			replyContent.html(html);
		}); // END getList
	}
	
	var nickName = '${board.nickName}';
	
	// 좋아요 관련 기능	
	likeBtn.on("click", function(){
		likeService.likeCheck({code:code, bno:bno, nickName:nickName}, function(result){
			if(result){
				$(this).attr("class", "btn btn-default");
				likeService.cancel({code:code, bno:bno, nickName:nickName}, function(result){
					if(result == 'success'){
						alert("데헷");
					} else {
						alert("뭔가 잘못됐나본데?");
					}
				})
				
			} else {
				$(this).attr("class", "btn btn-success");
				likeService.action({code:code, bno:bno, nickName:nickName}, function(result){
					if(result == 'success'){
						alert("데헷");
					} else {
						alert("뭔가 잘못됐나본데?");
					}
				})
			}
		})
	})
	
	
	
})