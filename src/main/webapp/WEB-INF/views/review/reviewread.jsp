<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/assets/css/reviewlist.css">
<!-- 실제 지도를 그리는 Javascript API를 불러오기 , 발급받은appkey삽입-->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61dcffc5bf38f384dfccc9f574ec205b"></script>

<!-- MAIN -->
<div class="main">
	<!--알람을 위한 div  -->
	<%@ include file="../includes/alarm.jsp"%>
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<h3 class="page-title">ReviewRead</h3>
				<div class="row">
					<!-- Read부분시작 -->
					<div class="col-md-6">
						<!-- INPUTS -->
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">Read</h3>
							</div>
							<div class="panel-body">
								<form id="formObj2">
									<p>Title</p>
									<input class="form-control" name="title" value="${vo.title}"
										disabled="disabled" style="background-color: white;"> <br>
									<p>Writer</p>
									<input class="form-control" name="writer" value="${vo.writer}"
										disabled="disabled" style="background-color: white;"> <br>
									<p>Content</p>
									<textarea class="form-control" name="content" rows="9"
										disabled="disabled" style="background-color: white;">${vo.content}</textarea>
									<br>
									<p class="demo-button">
										<button type="button" class="btn btn-warning" id="update"
											data-oper='update'>
											<i class="fa fa-refresh fa-spin"></i> Update
										</button>
										<button type="button" class="btn btn-danger" id="delete"
											data-oper='delete'>
											<i class="fa fa-trash-o"></i> Delete
										</button>
										<button type="button" class="btn btn-info" id="list"
											data-oper='list'>
											<i class="fa fa-info-circle"></i> List
										</button>
									</p>
								</form>
							</div>
						</div>
					</div>
					<!-- Read부분끝 -->
					<!-- 지도표시영역시작 -->
					<div class="col-md-6">
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">Map</h3>
							</div>
							<div class="panel-body no-padding">
								<!-- 이미지 지도를 표시할 div 입니다 -->
								<div id="staticMap" style="width: 100%; height: 500px;"></div>
							</div>
						</div>
					</div>
					<!--지도표시영역끝 -->
				</div>
			</div>
	</div>
	<!-- END MAIN CONTENT -->

	<!-- 댓글표시영역시작 -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">ReviewReply</h3>
			<div class="row">
				<div class="col-md-6">
					<div class="panel">
						<br>
						<div class="panel-body">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user"></i></span>
								<input class="form-control" placeholder="Username" type="text">
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
								<input class="form-control" placeholder="regDate" type="text">
							</div>
							<br>
							<textarea class="form-control" placeholder="Reply" rows="2"></textarea>
							<br>
							<p class="demo-button">
								<button type="button" class="btn btn-success btn-xs">Publish</button>
								<button type="button" class="btn btn-danger btn-xs">Delete</button>
								<button type="button" class="btn btn-danger btn-xs" id="test">Test</button>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 댓글표시영역끝 -->

<!--지도에 좌표값 가져오기 -->
<form action="" id="pos">
	<input type="hidden" name="xpos" id="xpos" value="${vo.xpos}" /> 
	<input type="hidden" name="ypos" id="ypos" value="${vo.ypos}" />
</form>

<!--ReviewUpdate시 보낼폼   -->
<form action="" id="operform">
	<input type="hidden" name="bno" value="${vo.bno}" /> 
	<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
	<input type="hidden" name="amount" value="${cri.amount}" /> 
	<input type="hidden" name="type" value="${cri.type}" /> 
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>



<script>
	$(function() {
		/*update*/
		var modifyBtn = $("#update");
		modifyBtn.click(function() {
			location.href = "reviewupdate?bno=" + "${vo.bno}";
		})
	});

</script>

<script>
	$(function() {
		//remove와 list 버튼이 눌러지면 새로 만든 폼 보내고
		//update 버튼이 눌러지면 원래의 폼 보내기
		
		
		var formObj = $("#operform");
		var formObj2 = $("#formObj2");

		$("button").click(function(e) {

			//submit 막기
			e.preventDefault();

			var oper = $(this).data("oper");

			/*게시글삭제  */
			if (oper == 'delete') {
				var deleteconfirm = confirm("게시글을 정말로 삭제하시겠습니까?");
				if (deleteconfirm == true) {
					formObj.attr('action', 'reviewdelete');
					formObj.attr('method', 'post');
				} else {
				}
				/*게시글리스트  */
			} else if (oper == 'list') {
				formObj.attr('action', 'reviewlist');
				formObj.attr('method', 'get');
				/*게시글수정  */
			} else if (oper == 'update') { //oper== update
				formObj = $("form[role='form']");
				formObj.attr('method', 'post');
				// 만약에 업데이트를 했을 경우에 알람을 보내기 위한 스크립트 
			}
			formObj.submit();
		})
	});
</script>

<!--지도에 대한 스크립트시작  -->
<script>
	var xpos = $("#xpos").val();
	var ypos = $("#ypos").val();

	$(document).ready(
			function() {
				//좌표값이 없는 경우 대한민국지도출력
				if (xpos == "") {
					// 이미지 지도에서 마커가 표시될 위치입니다 
					var markerPosition = new kakao.maps.LatLng(33.450701,126.570667);

					// 이미지 지도에 표시할 마커입니다
					// 이미지 지도에 표시할 마커는 Object 형태입니다
					var marker = {position : markerPosition};

					var staticMapContainer = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
					staticMapOption = {
						center : new kakao.maps.LatLng(36.589786, 127.818291), // 이미지 지도의 중심좌표
						level : 13, // 이미지 지도의 확대 레벨
						marker : marker
					// 이미지 지도에 표시할 마커 
					};

					// 이미지 지도를 생성합니다
					var staticMap = new kakao.maps.StaticMap(
							staticMapContainer, staticMapOption);

					//좌표값이 있는 경우 좌표값의 위치출력
				} else {
					// 이미지 지도에서 마커가 표시될 위치입니다 
					var markerPosition = new kakao.maps.LatLng(xpos, ypos);

					// 이미지 지도에 표시할 마커입니다
					// 이미지 지도에 표시할 마커는 Object 형태입니다
					var marker = {position : markerPosition};

					var staticMapContainer = document.getElementById('staticMap'), // 이미지 지도를 표시할 div  
					staticMapOption = {
						center : new kakao.maps.LatLng(xpos, ypos), // 이미지 지도의 중심좌표
						level : 5, // 이미지 지도의 확대 레벨
						marker : marker
					// 이미지 지도에 표시할 마커 
					};

					// 이미지 지도를 생성합니다
					var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
				}
			})
</script>
<!--지도에 대한 스크립트 끝 -->

<%@include file="../includes/footer.jsp"%>