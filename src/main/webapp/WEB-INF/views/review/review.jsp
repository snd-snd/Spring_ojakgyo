<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/assets/css/review.css">
<!-- 실제 지도를 그리는 Javascript API를 불러오기 , 발급받은appkey삽입-->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61dcffc5bf38f384dfccc9f574ec205b&libraries=services"></script>
<style>
	tr th,td{
		text-align: center;
	}
	
</style>	
<div class="main">
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
								<tbody>
								<c:forEach var="vo" items="${list}">
									<tr>
										<td>${vo.bno}</td>
										<td><a href="${vo.title}" class="viewone">${vo.title}</a></td>
										<td>${vo.writer}</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.regDate}"/></td>
										<td>조회수 구현X</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 지도표시영역 -->
				</div>
				<div class="col-md-6">
					<!-- TABLE NO PADDING -->
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
												키워드 : <input type="text" value="서울역" id="keyword" size="15">
												<button type="submit">검색하기</button>
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
					<!-- END TABLE NO PADDING -->
				</div>
			</div>
		</div>
	</div>
</div>
<!-- END MAIN CONTENT -->

<script src="/resources/js/review/review.js"></script>

<script>
//리스트제목 클릭 시 실행 >> 페이지 한개보기
$(function(){
	$(".viewone").click(function(){
		
	})
	
	
})

</script>
<%@include file="../includes/footer.jsp"%>
