<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<!-- MAIN -->
<div class="main">
	<!-- MAIN CONTENT -->
	<div class="main-content">
	<%@ include file="../includes/alarm.jsp"%>
		<div class="container-fluid">
			<h3 class="page-title">Read</h3>
			<div class="row">
				<div class="col-md-8">
					<!-- PANEL HEADLINE -->
					<div class="panel panel-headline">						
							<div class="panel-heading">
								<h3 class="panel-title">${board.title }</h3>
								<p class="panel-subtitle">${board.writer }&ensp;<fmt:formatDate value="${board.regDate }" pattern="yyyy-MM-dd"/></p>
							</div>
							<div class="panel-body">
								${board.content }
							</div>
							<div class="panel-body" id="buttons">
								<div class="col-md-3 text-left">
									<button type="button" class="btn btn-default" id="like"><i class="fa fa-thumbs-up"></i><span>&ensp;</span>좋아요</button>
								</div>
								<div class="col-md-9 text-right">
									<button type="button" class="btn btn-warning" id="modify" onclick="location.href='/${board.groupCode}/board/modify?bno=${board.bno }'"><i class="fa fa-edit"></i><span>&ensp;</span>수정</button>
									<button type="button" class="btn btn-danger" id="remove" ><i class="fa fa-trash"></i><span>&ensp;</span>삭제</button>
									<button type="button" class="btn btn-info" id="list"><i class="fa fa-list"></i><span>&ensp;</span>목록</button>
								</div>
								<br><br><hr>	
								<div>
									<i class="fa fa-comments fa-fw"></i><span>&ensp;</span>댓글	
								</div>																			
							</div>					
						<div class="panel-footer">
							<div class="row" id="replyContent">		          		  
							</div>
							<div class="row">
								<nav class="panel">
									<div class="panel-heading">
										<span><i class="fa fa-user"></i><span>&ensp;</span>${login.member.nickName }</span>
									</div>
									<div class="panel-body">
										<textarea id="replyText" class="form-control" placeholder="타인의 권리를 침해하거나 명예를 훼손하는 댓글은 운영원칙 및 관련 법률에 제재를 받을 수 있습니다." rows="6"></textarea>
									</div>
									<div class="panel-body text-right">
										<button type="button" class="btn btn-primary" id="register"><i class="fa fa-pencil"></i><span>&ensp;</span>등록</button>
									</div>
								</nav>	
							</div>
						</div>
					</div>
					<!-- END PANEL HEADLINE -->				
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN CONTENT -->
</div>
<!-- END MAIN -->
<div class="clearfix"></div>
<footer>
	<div class="container-fluid">
		<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
	</div>
</footer>
<form action="/${board.groupCode }/board/remove">
	<input type="hidden" name="bno" value="${board.bno }"/>
	<input type="hidden" name="pageNum" value="${criteria.pageNum }"/>
	<input type="hidden" name="amount" value="${criteria.amount }"/>
	<input type="hidden" name="type" value="${criteria.type }" />
	<input type="hidden" name="keyword" value="${criteria.keyword }" />	
</form>
<script src="/resources/js/board/reply.js"></script>
<script>
$(function(){
	
	var form = $("form");
	var code = '${board.groupCode }';
	var nickName = '${login.member.nickName}';
	var wirter = '${board.writer}';
	var bno = '${board.bno}';
	
	var likeBtn = $("#like");
	var modifyBtn = $("#modify");
	var removeBtn = $("#remove");
	var listBtn = $("#list");
	var registerBtn = $("#register");
	
			
	showList(1); //댓글 목록가져오기
	
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
			form.attr("method", "post").submit();			
		}
	})

	listBtn.on("click", function(){
		form.find("input[name='bno']").remove();
		form.attr("action", "/"+code+"/board/list");
		form.submit();
	})
	
	var content = $("#content");

	
	// 댓글 추가 영역
	var replyContent = $("#replyContent");	
	
	//댓글 등록
	registerBtn.click(function(){
		var params = {
				code:code,
				bno:bno,
				reply:$("#replyText").val(),
				replyer:nickName
		};

 		replySerivce.add(params, function(result){
			if(result == "success"){
				$("#replyText").val("");
				console.log("성공");
				showList(1);
			} else {
				alert("뭔가 잘못됐나본데?")
			}
		});
	})
	
	//댓글 삭제
	replyContent.on("click", "button[name='remove']", function(){
		 var real = confirm("정말 삭제하시겠습니까?");
		 if (real){
			var rno = $(this).data("rno");		
			replySerivce.remove({code:code, rno:rno}, function(result){
				if(result){
					showList(1);
				}		 
			
			});
		 }
	})
	
	//댓글 수정
	replyContent.on("click", "button[name='config']", function(){
		
		var me = $(this);
		
			replySerivce.read({code:code, rno:$(this).data("rno")}, function(result){
			console.log(result);
			
			me.closest("div[class='panel-heading']").siblings("div[class='panel-body']").hide();
			me.closest("div[class='panel-heading']").hide();
			
		
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
						
			me.closest("nav").append(html);		
		})
	})
	
	//댓글 수정(수정)
	replyContent.on("click", "button[name='modify']", function(){
		var rno = $(this).data("rno");
		var reply = $(this).closest("nav").find("textarea").val();
		
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
	
	function showList(page){ //Read에 들어오면 글번호에 해당하는 댓글들을 가져와 뿌려줌
		replySerivce.getList({code:code,bno:bno,page:page||1}, function(total,replys){
			console.log("list-length : " + replys.length);	
		
			replyContent.html("");
			if (list == null || replys.length == 0){
				return;
			}
			
			if(page==-1){  //새 글을 등록하였을때.
				pageNum=Math.ceil(total/10.0);
				showList(pageNum)
				return;
			}
			
			var str = "";
			for (var i=0, len=replys.length||0; i<len; i++){	
				
				str += "<nav class='panel'>";
				str += "<div class='panel-heading'>";
				str += "<span><i class='fa fa-user'></i><span>&ensp;</span>"+replys[i].replyer+"&ensp;"+replySerivce.displayTime(replys[i].replyDate)+"</span>";
				if (replys[i].replyer == nickName){
					str += "<div class='right'>";
					str += "<button type='button' name='config' data-rno='"+replys[i].rno+"'><i class='lnr  lnr-cog'></i></button>";
					str += "<button type='button' name='remove' data-rno='"+replys[i].rno+"'><i class='lnr lnr-cross'></i></button>";
					str += "</div>";
				}					
				str += "</div>";
				str += "<div class='panel-body'>";
				str += "<span class='replyContent' data-reply='"+replys[i].reply+"'>"+replys[i].reply+"</span>";
				str += "</div>";
				str += "</nav>";
			}
			replyContent.prepend(str);
			
		}); // END getList
	}
	
})
</script>
<%@ include file="../includes/footer.jsp" %>