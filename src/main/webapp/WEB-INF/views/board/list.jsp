<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

 
	 <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	 <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	 <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="/resources/js/board/sockjs-0.3.4.js"></script>
 	<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">
 		<link rel="stylesheet" href="/resources/assets/css/chat.css">
<!-- MAIN -->
<div class="main">
<%@ include file="../includes/alarm.jsp"%>
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Board List</h3>
			<div class="row">
				<div class="col-md-8">
					<!-- TABLE STRIPED -->

					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title text-left"># ${info.group.groupName }
								게시판</h3>
						</div>
						<div class="col-md-2 pull-right">
							<select class="form-control input-sm" id="amount">
								<option value="20">20</option>
								<option value="50">50</option>
								<option value="100">100</option>
							</select>
						</div>
						<div class="panel-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>글쓴이</th>
										<th>작성일</th>
										<th>조회</th>
										<th>추천</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>자바 시큐어코딩</td>
										<td>김영숙</td>
										<td>2019-10-10</td>
										<td>239</td>
										<td>10</td>
									</tr>
									<tr>
										<td>2</td>
										<td>이것이 자바다</td>
										<td>신용권</td>
										<td>2019-10-10</td>
										<td>539</td>
										<td>30</td>
									</tr>
									<tr>
										<td>3</td>
										<td>정보처리기사 실기</td>
										<td>시나공</td>
										<td>2019-12-05</td>
										<td>30</td>
										<td>9</td>
									</tr>
									<c:forEach items="${info.boards }" var="board">
										<tr>
											<td>${board.bno }</td>
											<td><a href="${board.bno }" class="move">${board.title }</a></td>
											<td>${board.writer }</td>
											<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }"/></td>
											<td>${board.readCount }</td>
											<td>${board.likeCount }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="panel-body">
							<div class="text-center">
								<ul class="pagination">
									<c:if test="${page.prev }">
										<li class="paginate_button previous"><a
											href="${page.startPage-1 }">Prev</a></li>
									</c:if>
									<c:forEach begin="${page.startPage }" end="${page.endPage }"
										var="idx">
										<li
											class="paginate_button ${page.criteria.pageNum==idx?'active':'' }">
											<a href="${idx }">${idx }</a>
										</li>
									</c:forEach>
									<c:if test="${page.next }">
										<li class="paginate_button next"><a
											href="${page.endPage+1 }">Next</a></li>
									</c:if>
								</ul>
							</div>
							<div class="row">
								<form action="/${info.group.groupCode }/board/list" id="search">
									<div class="text-left col-md-2">
										<select class="form-control" name="type" id="type">
											<option value="TCW">전체</option>
											<option value="TC">제목/내용</option>
											<option value="T">제목</option>
											<option value="C">내용</option>
											<option value="W">작성자</option>
										</select>
									</div>
									<div class="pull-left col-md-4">
										<input type="text" value="" class="form-control"
											placeholder="Search...">
									</div>
									<div class="pull-left col-md-1">
										<button type="button" class="btn btn-primary">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</form>
								<div class="pull-right">
									<button type="button" class="btn btn-primary" id="register"
										onclick="location.href='/${info.group.groupCode}/board/register'">
										<i class="fa fa-pencil"></i><span>&ensp;</span>글쓰기
									</button>
								</div>
							</div>
						</div>
					</div>
					<!-- END TABLE STRIPED -->
				</div>
				<!-- 오른쪽 채팅 -->

				<div class="col-sm-4">
					<div class="chatbody">
						<div class="panel panel-primary" ">
							<div class="panel-heading top-bar">
								<div class="col-md-8 col-xs-8">
									<h3 class="panel-title">
										<span class="glyphicon glyphicon-comment"></span> Chat
									</h3>
								</div>
							</div>
						
							
							<div class="panel-body msg_container_base" id="message_send"  style="font-family: 'Jua', sans-serif; font-size: 20px; overflow-y: scroll;"> 
								<!-- 보내는 메세지 생성 -->
							<!--  <div class="row msg_container base_sent"
									style="margin-bottom: 15px; border: 2px solid #5AAEFF; border-radius: 10px";  >
									<div class="col-md-10 col-xs-10" >
										<div class="messages msg_sent" id=message_send>
										</div>
									</div>
									<div class="col-md-2 col-xs-2 avatar">
										<img
											src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg"
											class=" img-responsive ">
									</div>
								</div>   -->
								<div id="message_receive">	
								<!-- 받은 메세지 div 생성 -->																
 									 <!-- <div class="row msg_container base_receive"
										style="margin-bottom: 15px; border: 2px solid #5AAEFF; border-radius: 10px";>
										<div class="col-md-2 col-xs-2 avatar">
											<img
												src="http://www.bitrebels.com/wp-content/uploads/2011/02/Original-Facebook-Geek-Profile-Avatar-1.jpg"
												class=" img-responsive ">
										</div>
										<div class="col-md-10 col-xs-10">
											<div class="messages msg_receive">
											<p>메세지</p>
											</div>
										</div>
									</div>  -->
								</div>
							</div>
							<div class="panel-footer">
								<div class="input-group">
									 <input id="btn-input" type="text" class="form-control input-sm chat_input"
										placeholder="Write your message here..." /> 
										<span class="input-group-btn">
										<button class="btn btn-primary btn-sm" id="btn-chat">
											<i class="fa fa-send fa-1x" aria-hidden="true"></i>
										</button>
									</span>
								</div>
							</div>
						</div>
					</div>
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
		<p class="copyright">
			Shared by <i class="fa fa-love"></i><a
				href="https://bootstrapthemes.co">BootstrapThemes</a>
		</p>
	</div>
</footer>
<form action="/${info.group.groupCode}/board/list" id="form">
	<input type="hidden" name="pageNum" value="${page.criteria.pageNum }" />
	<input type="hidden" name="amount" value="${page.criteria.amount }" />
	<input type="hidden" name="type" value="${page.criteria.type }" /> 
	<input type="hidden" name="keyword" value="${page.criteria.keyword }" />

</form>
<script src="/resources/js/board/like.js"></script>

<script>
$(function(){
	var form = $("#form");		
	var amount = '${page.criteria.amount }';
	var code = '${info.group.groupCode }';
	$("#amount").val(amount).attr('selected', true);		
				
	//페이지당 몇개의 글을 볼 것 인가 기본값 20
	$("#amount").change(function(){			
		form.find("input[name='amount']").val($(this).val());
		form.submit();
	})
	
	//페이징 넘버를 클릭시 해당 페이지로 이동하기 위한 함수
	$(".paginate_button").on("click", "a",function(e){
		e.preventDefault();		
		form.find("input[name='pageNum']").val($(this).attr("href"));			
		form.submit();
	})
		
	//검색을 위한 스크립트
	var search = $("#search");	
	var type = '${page.criteria.type}';
	var keyword = '${page.criteria.keyword}';
	
	$("#type").val(type).attr('selected', true);
	search.find("input[name='keyword']").val(keyword);
	
	search.find("button").click(function(e){
		e.preventDefault();				
		if (!search.find("input").val()){
			alert("검색어를 입력하세요.");
			search.find("input").focus();
			return;
		}
		search.find("input[name='pageNum']").val("1");		
		search.submit();			
	})
		
	//제목 클릭시 실행될 스크립트
	$(".move").click(function(e){
		e.preventDefault();		
		form.attr("action", "/"+code+"/board/read/"+$(this).attr("href"));
		form.submit();
	})
	
	
})
</script>


<%@ include file="../includes/footer.jsp"%>
