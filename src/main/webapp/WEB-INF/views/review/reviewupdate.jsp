<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/assets/css/reviewlist.css">

<!-- 실제 지도를 그리는 Javascript API를 불러오기 , 발급받은appkey삽입-->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61dcffc5bf38f384dfccc9f574ec205b&libraries=services"></script>

<!-- MAIN -->
<div class="main">
  <!--알람을 위한 div  -->
  <%@ include file="../includes/alarm.jsp"%>
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">ReviewUpdate</h3>
			<div class="row">
				<div class="col-md-6">
					<!-- INPUTS -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Read</h3>
						</div>
						<div class="panel-body">
							<form action="reviewupdate" role="form" id="operform2">
								<p>Title</p>
								<input class="form-control" name="title" value="${vo.title}">
								<br>
								<p>Writer</p>
								<input class="form-control" name="writer" value="${vo.writer}"
									disabled="disabled"> <br>
								<p>Content</p>
								<textarea class="form-control" name="content" rows="9">${vo.content}</textarea>
								<input class="form-control" type="hidden" name="bno"
									value="${vo.bno}"> <input class="form-control"
									type="hidden" name="xpos" value="${vo.xpos}"> <input
									class="form-control" type="hidden" name="ypos"
									value="${vo.ypos}"> <br>
								<p class="demo-button">
									<button type="submit" class="btn btn-warning"
										data-oper='update'>
										<i class="fa fa-refresh fa-spin"></i> Update
									</button>
									<button type="submit" class="btn btn-info" id="list"
										data-oper='list'>
										<i class="fa fa-info-circle"></i> List
									</button>
								</p>
							</form>
						</div>
					</div>
					<!-- END INPUTS -->
				</div>
				<!-- END INPUTS -->
				<div class="col-md-6">
					<!-- 지도표시 -->
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
												위치검색 : <input type="text" value="" id="keyword" size="15">
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
					<!-- END 지도표시영역 -->
				</div>
			</div>
		</div>
		<!-- END LABELS -->
	</div>
	<!-- END MAIN CONTENT -->
</div>
<!-- END MAIN -->

<!--지도에 좌표값 가져오기 -->
<form action="" id="pos">
	<input type="hidden" name="xpos" id="xpos" value="${vo.xpos}" /> 
	<input type="hidden" name="ypos" id="ypos" value="${vo.ypos}" />
</form>

<form id="operform">
	<input type="hidden" name="bno" value="${vo.bno}" id="bno" /> 
	<input type="hidden" name="pageNum" value="${cri.pageNum}" /> 
	<input type="hidden" name="amount" value="${cri.amount}" /> 
	<input type="hidden" name="type" value="${cri.type}" /> 
	<input type="hidden" name="keyword" value="${cri.keyword}" />
</form>


<script>
var xpos = $("#xpos").val();
var ypos = $("#ypos").val();

$(function(){
	
	//remove와 list 버튼이 눌러지면 새로 만든 폼 보내고
	//update 버튼이 눌러지면 원래의 폼 보내기
	var formObj=$("#operform");
	var formObj2=$("#operform2");
	
	$(".btn").click(function(e){
		//submit 막기
		e.preventDefault();
		
		var oper=$(this).data("oper");
		
		if(oper=='update'){
			formObj.attr('action','reviewupdate');
			formObj.attr('method','post');
			formObj2.attr('method','post');
			formObj.submit();
			formObj2.submit();
			
		}else if(oper=='list'){
			formObj.attr('action','reviewlist');
			formObj.attr('method','get');
			formObj.submit();
		}
		
	})
});

<!--지도표시 스크립트  -->
	/*지도검색부분시작 */
	var markers = [];// 마커를 담을 배열입니다

	if(xpos==""){/*좌표값이 비어있는 경우 서울역위치출력 */
	var mapContainer = document.getElementById('map'), 	// 지도를 표시할 div 
		mapOption = {
				center : new kakao.maps.LatLng('37.554655', '126.970659'), // 지도의 중심좌표
				level : 5// 지도의 확대 레벨
			};
	}else{/*좌표값이 있는 경우 서울역위치출력 */
		var mapContainer = document.getElementById('map'), 	// 지도를 표시할 div 
			mapOption = {
				center : new kakao.maps.LatLng(xpos, ypos), // 지도의 중심좌표
				level : 5// 지도의 확대 레벨
			};
	}
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
		zIndex : 1
	});

	// 키워드로 장소를 검색합니다
	searchPlaces();

	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
		var keyword = document.getElementById('keyword').value;
		
		if (!keyword.replace(/^\s+|\s+$/g, '')) {
			 /* alert('키워드를 입력해주세요!');  */
			return false;
		}
		// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		ps.keywordSearch(keyword, placesSearchCB);
	}

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {
			// 정상적으로 검색이 완료됐으면
			// 검색 목록과 마커를 표출합니다
			displayPlaces(data);

			// 페이지 번호를 표출합니다
			displayPagination(pagination);

		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
			alert('검색 결과가 존재하지 않습니다.');
			return;

		} else if (status === kakao.maps.services.Status.ERROR) {
			alert('검색 결과 중 오류가 발생했습니다.');
			return;
		}
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
		var listEl = document.getElementById('placesList'), menuEl = document
				.getElementById('menu_wrap'), fragment = document
				.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

		// 검색 결과 목록에 추가된 항목들을 제거합니다
		removeAllChildNods(listEl);

		// 지도에 표시되고 있는 마커를 제거합니다
		removeMarker();

		for (var i = 0; i < places.length; i++) {
			// 마커를 생성하고 지도에 표시합니다
			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x), marker = addMarker(
					placePosition, i), itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(placePosition);

			// 마커와 검색결과 항목에 mouseover 했을때
			// 해당 장소에 인포윈도우에 장소명을 표시합니다
			// mouseout 했을 때는 인포윈도우를 닫습니다
			(function(marker, title) {
				kakao.maps.event.addListener(marker, 'mouseover', function() {
					displayInfowindow(marker, title);
				});

				kakao.maps.event.addListener(marker, 'mouseout', function() {
					infowindow.close();
				});

				itemEl.onmouseover = function() {
					displayInfowindow(marker, title);
				};

				itemEl.onmouseout = function() {
					infowindow.close();
				};
			})(marker, places[i].place_name);

			fragment.appendChild(itemEl);
		}

		// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		map.setBounds(bounds);
	}

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

		var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
				+ (index + 1)
				+ '"></span>'
				+ '<div class="info">'
				+ '   <h5>'
				+ places.place_name + '</h5>';

		if (places.road_address_name) {
			itemStr += '    <span>' + places.road_address_name + '</span>'
					+ '   <span class="jibun gray">' + places.address_name
					+ '</span>';
		} else {
			itemStr += '    <span>' + places.address_name + '</span>';
		}

		itemStr += '  <span class="tel">' + places.phone + '</span>' + '</div>';

		el.innerHTML = itemStr;
		el.className = 'item';

		return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
		var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
		imgOptions = {
			spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			offset : new kakao.maps.Point(13, 37)
		// 마커 좌표에 일치시킬 이미지 내에서의 좌표
		}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imgOptions), marker = new kakao.maps.Marker({
			position : position, // 마커의 위치
			image : markerImage
		});

		marker.setMap(map); // 지도 위에 마커를 표출합니다
		markers.push(marker); // 배열에 생성된 마커를 추가합니다

		return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
		var paginationEl = document.getElementById('pagination'), fragment = document
				.createDocumentFragment(), i;

		// 기존에 추가된 페이지번호를 삭제합니다
		while (paginationEl.hasChildNodes()) {
			paginationEl.removeChild(paginationEl.lastChild);
		}

		for (i = 1; i <= pagination.last; i++) {
			var el = document.createElement('a');
			el.href = "#";
			el.innerHTML = i;

			if (i === pagination.current) {
				el.className = 'on';
			} else {
				el.onclick = (function(i) {
					return function() {
						pagination.gotoPage(i);
					}
				})(i);
			}

			fragment.appendChild(el);
		}
		paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		infowindow.setContent(content);
		infowindow.open(map, marker);
	}

	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild(el.lastChild);
		}
	}
	/*지도검색부분끝  */

	/*지도에 마커생성시작*/
	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({
		// 지도 중심좌표에 마커를 생성합니다 
		position : map.getCenter()
	});

	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({
		// 지도 중심좌표에 마커를 생성합니다 
		position : map.getCenter()
	});
	// 지도에 마커를 표시합니다
	marker.setMap(map);

	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

		// 클릭한 위도, 경도 정보를 가져옵니다 
		var latlng = mouseEvent.latLng;

		// 마커 위치를 클릭한 위치로 옮깁니다
		marker.setPosition(latlng);

		var resultDiv = document.getElementById('clickLatlng');
			
		$('input[name=xpos]').attr('value',latlng.getLat());
		$('input[name=ypos]').attr('value',latlng.getLng());
			
	});
	/*지도에 마커생성끝*/

</script>

<%@include file="../includes/footer.jsp"%>