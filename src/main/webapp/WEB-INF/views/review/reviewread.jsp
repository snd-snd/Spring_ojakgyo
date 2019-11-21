<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


  <script>
  //헤더에 들어가기전에 알람이 뜨는 장소와 자기가 있는 현재 페이지가 같다면
  // 알람을 띄우지 않게 하기위해 자신의위치를 알려주는 flag
  var flagPage="reviewread";
  </script>


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
									id="title" disabled="disabled" style="background-color: white;">
								<br>
								<p>Writer</p>
								<input class="form-control" name="writer" value="${vo.writer}"
									id="writer" disabled="disabled"
									style="background-color: white;"> <br>
								<p>Content</p>
								<textarea class="form-control" name="content" rows="9"
									disabled="disabled" style="background-color: white;">${vo.content}</textarea>
								<br>
								<p class="demo-button">
								<c:if test="${login.member.nickName eq vo.writer}">								
									<button type="button" class="btn btn-warning bb1" id="update"
										data-oper='update'>
										<i class="fa fa-refresh fa-spin"></i> Update
									</button>
									<button type="button" class="btn btn-danger bb1" id="delete"
										data-oper='delete'>
										<i class="fa fa-trash-o"></i> Delete
									</button>
								</c:if>
									<button type="button" class="btn btn-info bb1" id="list"
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
</div>
<!--End Main  -->
	<div class="main">
		<div class="main-content">
			<div class="container-fluid">
				<h3 class="page-title">ReviewReadReply</h3>
				<p class="demo-button">
					<button type="button" class="btn btn-success btn-xs bb2">Review
						Register</button>
				</p>
				<!-- 댓글 영역 -->
				<div class="row">
					<div class="col-md-6">
						<div class="panel panel-default" style="border-color: white;">
							<div class="panel-heading"
								style="background-color: gray; color: white; font-size: 20px;">
								<i class="fa fa-envelope"></i> Reply
							</div>
							<!-- ./ end panel-heading  -->
							<div class="panel-body">
								<ul class="chat" style="padding-left: 0%;">
									<!--  start reply -->
									<li class="left clearfix" data-rno='12'
										style="list-style: none;">
										<div>
											<div class="header">
												<strong style="font-family: cursive;">replyer</strong> <small
													class="pull-right text-muted">replyDate </small>
											</div>
											<p>reply</p>
										</div>
									</li>
								</ul>
							</div>
							<!-- ./ end panel-body  -->
							<div class="panel-footer" style="background-color: white">
								<!-- 댓글 페이지 영역 -->
							</div>
						</div>
						<!-- ./ end panel panel-default  -->
					</div>
					<!-- ./ end col-lg-12  -->
				</div>
				<!-- ./ end row  -->
			</div>
		</div>
	</div>

	<!-- 댓글 등록  버튼 누르면  Modal영역 시작-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header"
					style="background-color: gray; color: white;">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Reply Register</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>Replyer</label> <input class="form-control" name="replyer" value="${login.member.nickName}"
							readonly="readonly"  style="background-color: white;">
					</div>
					<div class="form-group">
						<label>Reply</label> <input class="form-control" name="reply"
							 style="background-color: white;">
					</div>
					<div class="form-group">
						<label>Reply Date</label> <input class="form-control"
							name="replydate" value="">
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-warning" id="modalModBtn">Update</button>
					<button type="button" class="btn btn-danger" id="modalRemoveBtn">Delete</button>
					<button type="button" class="btn btn-success" id="modalRegisterBtn">Publish</button>
					<button type="button" class="btn btn-default" id="modalCloseBtn">Close</button>
				</div>
			</div>
			<!-- /.modal내용 -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- 댓글 등록  버튼 누르면  Modal영역 끝-->

	<!--지도에 좌표값 가져오기 -->
	<form action="" id="pos">
		<input type="hidden" name="xpos" id="xpos" value="${vo.xpos}" /> <input
			type="hidden" name="ypos" id="ypos" value="${vo.ypos}" />
	</form>

	<!--ReviewUpdate시 보낼폼   -->
	<form action="" id="operform">
		<input type="hidden" name="bno" id="bno" value="${vo.bno}" /> <input
			type="hidden" name="pageNum" id="pageNum" value="${cri.pageNum}" />
		<input type="hidden" name="amount" id="amount" value="${cri.amount}" />
		<input type="hidden" name="type" id="type" value="${cri.type}" /> <input
			type="hidden" name="keyword" id="keyword" value="${cri.keyword}" />
		<input type="hidden" name="userid" id="userid"
			value="${login.member.userId}" />
	</form>


	<!-- 리뷰 작성 버튼이 눌리면 게시글 당사자에게 알람이 가도록 만든 스크립트 테스트버전. -->
 	<script>
 		var userid = $("#userid").val();
		var bno = $("#bno").val();
		var title = $("#title").val();
		var writer = $("#writer").val();
		
			//리뷰 게시판 알람을 동작하는 함수 (alaram.js)
		function replyAralm(){
			if (userid != "") {
				ReviewReplySend();
			}; 
				
			}

	</script>


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

			$(".bb1").click(function(e) {

				//submit 막기
				e.preventDefault();

				var oper = $(this).data("oper");

				//게시글삭제  
				if (oper == 'delete') {
					var deleteconfirm = confirm("게시글을 정말로 삭제하시겠습니까?");
					if (deleteconfirm == true) {
						formObj.attr('action', 'reviewdelete');
						formObj.attr('method', 'post');
					} else {
					}
					// 게시글리스트  
				} else if (oper == 'list') {
					formObj.attr('action', 'reviewlist');
					formObj.attr('method', 'get');
					//게시글수정  
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


	<script src="/resources/js/review/reviewreadmodal.js"></script>
	<!--댓글모달창관련스크립트시작  -->
	<script>
		$(function() {
			//bno 가져오기
			var bno = ${vo.bno};

			//댓글 목록을 보여줄 영역 가져오기
			var replyUL = $(".chat");
			//댓글을 보여줄 함수 호출하기
			showList(1);

			var modal = $(".modal");
			//모달 창이 가지고 있는 input 영역 가져오기
			var modalInputReply = modal.find("input[name='reply']");
			var modalInputReplyer = modal.find("input[name='replyer']");
			var modalInputReplyDate = modal.find("input[name='replydate']");
			//모달 창이 가지고 있는 버튼 가져오기
			var modalModBtn = $("#modalModBtn");
			var modalRemoveBtn = $("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");

			//댓글 모달창과 관련된 스크립트, 댓글입력
			$(".bb2").click(function() {
				//input 태그가 가지고 있는 내용 없애주기
				//modal.find("input").val("");

				//댓글등록날짜안보이기
				modalInputReplyDate.closest("div").hide();

				//close 버튼만 제외하고 모든 버튼을 숨기기
				modal.find("button[id!='modalCloseBtn']").hide();

				//등록 버튼 보여주기
				modalRegisterBtn.show();

				//모달창 보여주기
				modal.modal("show");
			})

			$("#modalRegisterBtn").click(function() {
				var reply = {
					bno : bno,
					reply : modalInputReply.val(),
					replyer : modalInputReplyer.val()
				};
				ReviewReplyService.ReviewReplyInsert(reply, function(result) {
					if (result) {
						//댓글 작성이 성공되면
						//input 태그 내용 없애기
						modal.find("input").val("");
						//모달 창 종료
						modal.modal("hide");
						//댓글리스트 함수 호출
						showList(-1);
					}
				}); //add 종료		
				replyAralm();
			})

			function showList(page) {
				ReviewReplyService
						.ReviewReplyList(
								{
									bno : bno,
									page : page || 1
								},
								function(total, list) {
									console.log("list-length : " + list.length
											+ " total " + total);

									if (page == -1) { //새글 등록시 마지막 페이지 번호 계산
										pageNum = Math.ceil(total / 10.0);
										showList(pageNum);
										return;
									}

									if (list == null || list.length == 0) {
										replyUL.html("");
										return;
									}

									var str = "";

									for (var i = 0, len = list.length || 0; i < len; i++) {
										str += "<li class='left clearfix' style = 'list-style: none;' data-rno='"+list[i].rno+"'>";
										str += "<div'><div class='header'><strong style=' color:black; border=1;'>"
												+ list[i].replyer + "</strong>";
										str += "<small class='pull-right text-muted' style = 'color:gray;'>"
												+ ReviewReplyService
														.displayTime(list[i].replyDate)
												+ "</small>";
										str += "</div><p style= 'word-wrap: break-word; color : black;' class='text-muted'>"
												+ list[i].reply
												+ "</p></div></li><br>";
									}

									replyUL.html(str);
									showReplyPage(total); //댓글 총 갯수			
								}); //getList 종료
			}

			//댓글 페이지 영역 가져오기
			var replyPageFooter = $(".panel-footer");
			var pageNum = 1;
			function showReplyPage(total) {
				//마지막 페이지 계산
				var endPage = Math.ceil(pageNum / 10.0) * 10;
				//시작 페이지 계산
				var startPage = endPage - 9;
				//이전 버튼
				var prev = startPage != 1;
				//다음 버튼
				var next = false;

				if (endPage * 10 >= total) {
					endPage = Math.ceil(total / 10.0);
				}
				if (endPage * 10 < total) {
					next = true;
				}

				var str = "<ul class='pagination'>";
				if (prev) {
					str += "<li class='page-item'><a class='page-link'";
					str += " href='" + (startPage - 1) + "'>Previous</a></li>";
				}

				for (var i = startPage; i <= endPage; i++) {
					var active = pageNum == i ? "active" : "";
					str += "<li class='page-item "+active+"'>";
					str += "<a class='page-link' href='"+i+"'>" + i;
					str += "</a></li>";
				}

				if (next) {
					str += "<li class='page-item'><a class='page-link'";
					str += " href='" + (endPage + 1) + "'>Next</a></li>";
				}
				str += "</ul></div>";
				replyPageFooter.html(str);
			}

			// 페이지 번호를 클릭하면 동작할 스크립트
			// 현재 존재하는 태그가 아니기 때문에 이벤트 위임의 형태로 이벤트 발생
			replyPageFooter.on("click", "li a", function(e) {
				e.preventDefault(); //a 태그 동작 막기

				pageNum = $(this).attr("href");
				showList(pageNum);
			})

			modalRemoveBtn.click(function() {
				ReviewReplyService.ReviewReplyDelete(modal.data("rno"),
						function(result) {
							if (result) {
								modal.modal("hide");
								showList(pageNum);
							}
						}) //remove 종료		
			})

			modalModBtn.on("click", function() {

				var replyupdate = {
					rno : modal.data("rno"),
					reply : modalInputReply.val()
				};

				ReviewReplyService.ReviewReplyUpdate(replyupdate, function(
						result) {
					if (result === 'success') {
						alert("댓글이 수정되었습니다");
						modal.modal("hide");
						showList(pageNum);
					}
				})
			})

			//이벤트 위임
			replyUL.on("click", "li", function() {
				//댓글 등록시 감췄던 replydate 요소 다시 보이게 만들기
				modalInputReplyDate.closest("div").show();

				var rno = $(this).data("rno");

				ReviewReplyService.ReviewReplyGet(rno, function(result) {
					//넘겨받은 데이터 modal 창에 보여주기
					modalInputReply.val(result.reply);
					modalInputReplyer.val(result.replyer).attr("readonly",
							"readonly");
					modalInputReplyDate.val(
							ReviewReplyService.displayTime(result.replyDate))
							.attr("readonly", "readonly");

					modal.data("rno", result.rno);

					//close 버튼만 제외하고 모든 버튼을 숨기기
					modal.find("button[id!='modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();

					modal.modal("show");
				})
			})

			//모달 창 close 버튼이 눌러지면 창 닫기
			$("#modalCloseBtn").click(function() {
				modal.modal("hide");
			})

		})
	</script>
	<!--댓글모달창관련스크립트끝  -->


	<script>
		var xpos = $("#xpos").val();
		var ypos = $("#ypos").val();

		$(document).ready(
				
				function() {
					//좌표값이 없는 경우 대한민국지도출력
					if (xpos == "") {
						// 이미지 지도에서 마커가 표시될 위치입니다 
						var markerPosition = new kakao.maps.LatLng(33.450701,
								126.570667);

						// 이미지 지도에 표시할 마커입니다
						// 이미지 지도에 표시할 마커는 Object 형태입니다
						var marker = {
							position : markerPosition
						};

						var staticMapContainer = document
								.getElementById('staticMap'), // 이미지 지도를 표시할 div  
						staticMapOption = {
							center : new kakao.maps.LatLng(36.589786,
									127.818291), // 이미지 지도의 중심좌표
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
						var marker = {
							position : markerPosition
						};

						var staticMapContainer = document
								.getElementById('staticMap'), // 이미지 지도를 표시할 div  
						staticMapOption = {
							center : new kakao.maps.LatLng(xpos, ypos), // 이미지 지도의 중심좌표
							level : 5, // 이미지 지도의 확대 레벨
							marker : marker
						// 이미지 지도에 표시할 마커 
						};

						// 이미지 지도를 생성합니다
						var staticMap = new kakao.maps.StaticMap(
								staticMapContainer, staticMapOption);
					}
				})
	</script>
	<!--지도에 대한 스크립트 끝 -->

	<%@include file="../includes/footer.jsp"%>