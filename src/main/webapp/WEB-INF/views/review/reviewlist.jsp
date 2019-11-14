<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/assets/css/reviewlist.css">
<!-- 실제 지도를 그리는 Javascript API를 불러오기 , 발급받은appkey삽입-->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61dcffc5bf38f384dfccc9f574ec205b&libraries=services"></script>
<style>
tr th, td {
	text-align: center;
}
</style>
<!-- MAIN -->
<div class="main">
  <!--알람을 위한 div  -->
  <%@ include file="../includes/alarm.jsp"%>
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Review</h3>
			<div class="row">
				<div class="col-md-6">
					<!-- List Table -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">List</h3>
						</div>
						<div class="panel-body">
							<table class="table">
								<thead>
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>글쓴이</th>
										<th>작성일</th>
										<th>조회수</th>
									</tr>
								</thead>
								<!--리뷰리스트출력시작  -->
								<tbody>
									<c:forEach var="vo" items="${list}">
										<tr>
											<td>${vo.bno}</td>
											<td><a href="<c:out value='reviewread?bno=${vo.bno}'/>"
												class="reviewread">${vo.title}</a></td>
											<td>${vo.writer}</td>
											<td><fmt:formatDate pattern="yyyy.MM.dd HH:mm"
													value="${vo.regDate}" /></td>
											<td>100</td>
										</tr>
									</c:forEach>
								</tbody>
								<!--리뷰리스트출력끝  -->
							</table>
							<!--글쓰기  -->
							<p class="demo-button">
								<button type="button" class="btn btn-primary"
									onclick="location.href='reviewinsert'">글쓰기</button>
							</p>
							<form action="" id="searchform" method="get">
								<!--분류선택  -->
								<select class="form-control">
									<option value="Title"
										<c:out value="${pageVO.criteria.type eq 'Title'?'selected':''}"/>>제목</option>
									<option value="Content"
										<c:out value="${pageVO.criteria.type eq 'Content'?'selected':''}"/>>내용</option>
									<option value="TitleContent"
										<c:out value="${pageVO.criteria.type eq 'TitleContent'?'selected':''}"/>>제목
										+내용</option>
									<option value="Writer"
										<c:out value="${pageVO.criteria.type eq 'Writer'?'selected':''}"/>>작성자</option>
								</select> <br>
								<!--검색버튼  -->
								<div class="input-group">
									<input class="form-control" type="text" name="keyword"
										value="${pageVO.criteria.keyword}" /> <input type="hidden"
										name="pageNum" value="${pageVO.criteria.pageNum}" /> <input
										type="hidden" name="amount" value="${pageVO.criteria.amount}" />
									<span class="input-group-btn"><button
											class="btn btn-primary">Search</button></span>
								</div>
							</form>
						</div>
						<!-- 페이지번호출력 시작 -->
						<div class="text-center">
							<ul class="pagination">
								<c:if test="${pageVO.prev}">
									<li class="paginate_button previous"><a
										href="${pageVO.startPage-1}">Previous</a></li>
								</c:if>
								<c:forEach var="idx" begin="${pageVO.startPage}"
									end="${pageVO.endPage}">
									<li
										class="paginate_button ${pageVO.criteria.pageNum==idx?'active':''}">
										<a href="${idx}">${idx}</a>
									</li>
								</c:forEach>
								<c:if test="${pageVO.next}">
									<li class="paginate_button next"><a
										href="${pageVO.endPage+1}">Next</a></li>
								</c:if>
							</ul>
						</div>
						<!-- 페이지번호출력 끝 -->
					</div>
				</div>
				<!-- 지도표시영역 시작-->
				<div class="col-md-6">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Map</h3>
						</div>
						<div class="panel-body no-padding">
							<!--지도표시-->
							<div class="map_wrap">
								<div id="map"
									style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
								<div id="menu_wrap" class="bg_white">
									<div class="option">
										<div>
											<form onsubmit="searchPlaces(); return false;">
												위치검색 <input type="text" value="강남" id="keyword" size="15">
												<button type="submit">Search</button>
											</form>
										</div>
									</div>
									<hr>
									<ul id="placesList"></ul>
									<div id="pagination"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--지도표시영역 끝  -->
			</div>
		</div>
	</div>
</div>
<!-- END MAIN CONTENT -->

<script src="/resources/js/review/reviewlist.js"></script>

<!--페이지번호클릭하면 보내는폼   -->
<form action="" id="listform">
	<input type="hidden" name="pageNum" value="${pageVO.criteria.pageNum}" /> 
	<input type="hidden" name="amount" value="${pageVO.criteria.amount}" /> 
	<input type="hidden" name="type" value="${pageVO.criteria.type}" /> 
	<input type="hidden" name="keyword" value="${pageVO.criteria.keyword}" />
</form>

<script>
	$(function() {
		// 페이지번호클릭시 실행
		var listform = $("#listform");
		$(".paginate_button a").click(function(e) {
			e.preventDefault();
			listform.find("input[name='pageNum']").val($(this).attr("href"));
			listform.submit();
		})
		
		//리뷰글제목 클릭시 실행 >> 페이지 한개보기
		$(".reviewread").click(function() {
					e.preventDefault(); //a 태그 막기
					//제목 클릭시 글 번호,pageNum,amount,검색정보를 보내야 함
					listform.append("<input type='hidden' name='bno' value='"
							+ $(this).attr("href") + "'>");
					listform.attr("action", "reviewread");
					listform.submit();
				})

		//검색시 실행
		$(".btn-primary").click(function() {
			var searchform = $("#searchform");

			if (!searchform.find("input[name='keyword']").val()) {
				alert("검색어를 입력하세요");
				searchform.find("input[name='keyword']").focus();
				return false;
			}
			searchform.find("input[name='pageNum']").val("1");
			searchform.submit();
		})

	})
</script>
<%@include file="../includes/footer.jsp"%>
