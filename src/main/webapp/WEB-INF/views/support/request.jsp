<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  <script>
  //헤더에 들어가기전에 알람이 뜨는 장소와 자기가 있는 현재 페이지가 같다면
  // 알람을 띄우지 않게 하기위해 자신의위치를 알려주는 flag
  var flagPage="support-request";
  </script>
<%@ include file="../includes/header.jsp" %>

<!-- MAIN -->
<div class="main">
  <%@ include file="../includes/alarm.jsp"%>
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Support</h3>
			<div class="row">
				<div class="col-md-12">							
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title"># 그룹 신청</h3>
						</div>
						<div class="panel-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>번호</th>
										<th>그룹 코드</th>
										<th>그룹 이름</th>
										<th>신청인</th>
										<th>신청날짜</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
									
									<c:forEach items="${myGroups }" var="group" varStatus="status">
									<tr>

										<td>${status.count }</td>
										<td>${group.groupCode }</td>
										<c:if test="${group.status == 1}">
											<td>${group.groupName }</td>
										</c:if>
										<c:if test="${group.status != 1}">
											<td><a href="" data-code="${group.groupCode }">${group.groupName }</a></td>
										</c:if>
										<td>${group.leader }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${group.regDate }"/></td>
										<c:if test="${group.status == 1}">
										<td><span class="label label-success">SUCCESS</span></td>
										</c:if>
										<c:if test="${group.status == 2}">
										<td><span class="label label-warning">PENDING</span></td>
										</c:if>
										<c:if test="${group.status == 3}">
										<td><span class="label label-danger">FAILED</span></td>
										</c:if>
										
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="panel-body">
							<div class="text-right">
								<button type="button" class="btn btn-default" id="request"><i class="fa fa-codepen"></i><span>&ensp;</span>그룹신청</button>										
							</div>					
						</div>
					</div>
					<!-- END TABLE STRIPED -->
				</div>					
			</div>
			<!-- 그룹 가입란 -->				
			<div class="row" id="intro">			
				<c:forEach items="${groups }" var="group">
					<c:if test="${group.groupCode != 'GN1000' }">
						<div class="col-md-3" data-code="${group.groupCode }", data-name="${group.groupName }">
							<div class="panel">
								<div class="panel-heading">
									<h3 class="panel-title">${group.groupName }</h3>
								</div>
								<div class="panel-body">
									<p>${group.content }</p>
								</div>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>			
			<!-- 그룹 가입란 종료-->			
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
<!-- Modal Content -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">그룹 신청 모달</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                	<label>그룹 이름</label>
                	<input class="form-control" name="groupName" placeholder="신청할 그룹의 이름을 작성해주세요.">
                </div>
                <div class="form-group">
                	<label>소개 글</label>
                	<textarea class="form-control" name="groupContent" placeholder="소개 내용을 작성해주세요." rows="4"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" id="modalModifyBtn">수정</button>
                <button type="button" class="btn btn-danger" id="modalRemoveBtn">철회</button>
                <button type="button" class="btn btn-primary" id="modalRegisterBtn">신청</button>                            
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- END Modal -->
<script src="/resources/js/support/group.js"></script>


<script>
$(document).ready(function() {
	$("#modalRegisterBtn").click(function(){
		SupportAdmin();
	});
})
</script>


<script>
$(function(){
	var modal = $("#myModal");	
	var requestBtn = $("#request");
	var myNickName = '${login.member.nickName}';
	
	// 그룹신청 버튼 클릭시 모달창을 띄워 폼 보여주기
	requestBtn.on("click", function() {
		
		//버튼이 눌린다면 SupportAdmin 함수를 통해 관리자에게 알람.
		
	
 		var size = '${login.groupSize}';
	
		if (size == 4){
			alert("허용 가능한 그룹 수를 초과했습니다.");
			return;
		}
		modal.find("h4").html("그룹 신청");
		modal.find("input").val("");
		modal.find("textarea").val("");
		modal.find("button").hide();
		modal.find("button[id='modalRegisterBtn']").show();
		modal.modal("show");		
	})
	
	// 그룹신청 내용에 대한 수정이나 철회가 있을 경우
	$("table").on("click", "a", function(e){
		e.preventDefault();
		modal.find("h4").html("그룹 신청내역 수정");
		var inputValue;
		var textareaValue;
		var leader = 'hello';
		var groupCode = $(this).data("code");
					
		groupRequest.read(groupCode, function(result) {
			modal.find("input").val(result.groupName).attr("data-code", groupCode);
			modal.find("textarea").val(result.content);
			modal.find("button").hide();
			modal.find("button[id!='modalRegisterBtn']").show();
		})	
		modal.modal("show");			
	})
		
	// 그룹 신청, 수정, 철회 등 버튼을 눌렀을 때 Ajax를 이용해 데이터 처리
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalModifyBtn = $("#modalModifyBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");

	
	// 그룹 신청
	modalRegisterBtn.on("click", function(){		
		var params = {
			groupName : modal.find("input").val(),
			content : modal.find("textarea").val(),
			leader : myNickName
		};	
		groupRequest.add(params, function(result){
			if (result == 'success'){
				modal.modal("hide");
				location.href='/support/request';
			} else {
				alert("뭔가 잘못됐나본데?");
			}
		});	
	})
	
	// 그룹 신청 수정
	modalModifyBtn.on("click", function(){
		var params = {
				groupName : modal.find("input").val(),
				content : modal.find("textarea").val(),
				groupCode : modal.find("input").data("code")
			};			
		groupRequest.modify(params, function(result) {
			if (result == 'success'){
				modal.modal("hide");
				location.href='/support/request';
			} else {
				alert("뭔가 잘못됐나본데?");
			}
		})
	})
	
	// 그룹 신청 철회
	modalRemoveBtn.on("click", function(){
		var groupCode = modal.find("input").data("code");	
		groupRequest.remove(groupCode, function(result) {
			if (result == 'success'){
				modal.modal("hide");
				location.href='/support/request';
			} else {
				alert("뭔가 잘못됐나본데?");
			}
		})
	})
	
	
	var intro = $("#intro");
	
	intro.on("click", "div[class='col-md-3']", function(){
		
 		var size = '${login.groupSize}';
		var group1 = '${login.member.groupCode1}';
		var group2 = '${login.member.groupCode2}';
		var group3 = '${login.member.groupCode3}';
		var group4 = '${login.member.groupCode4}';
 					
		if (size == 4){
			alert("더 이상 그룹에 가입할 수 없습니다.");
			return;
		}
		
		var code = $(this).data("code");
		var name = $(this).data("name");
		
		if (code == group1 || code == group2 || code == group3 || code == group4){
			alert("이미 "+name+"에 가입되어있습니다.");
			return;
		}
		
		var cf = confirm(name+"에 가입하시겠습니까?");
		
		if (cf){
			
			var userId = '${login.member.userId}';
			var nickName = '${login.member.nickName}';
			
			groupRequest.register({userId:userId, nickName:nickName, code:code}, function(result){
				if (result == 'success'){
					alert(name+"에 가입되었습니다. 재접속 이후 사용 가능합니다.");
					location.href = "/account/complete";			
				} else {
					alert("뭔가 잘못됐나본데?");
				}
			})
						
		}
	})
	
})
</script>
<!-- <script src="/resources/js/support/request.js"></script> -->
<%@ include file="../includes/footer.jsp" %>