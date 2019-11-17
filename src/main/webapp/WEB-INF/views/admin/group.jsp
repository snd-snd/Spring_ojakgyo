<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<!-- MAIN -->
<div class="main">
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Admin</h3>
			<div class="row">
				<div class="col-md-6">							
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title"># 그룹 승인 대기</h3>
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
									
									<c:forEach items="${groups_pending }" var="group" varStatus="status">
									<tr>
										<td>${status.count }</td>
										<td>${group.groupCode }</td>
										<td><a href="#" data-code="${group.groupCode }" class="mo">${group.groupName }</a></td>
										<td>${group.leader }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${group.regDate }"/></td>
										<td><span class="label label-warning">PENDING</span></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>				
					</div>
				</div>
				<div class="col-md-6">
					<!-- END TABLE STRIPED -->
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title"># 승인 그룹</h3>
						</div>
						<div class="panel-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>번호</th>
										<th>그룹 코드</th>
										<th>그룹 이름</th>
										<th>그룹장</th>
										<th>신청날짜</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>
									
									<c:forEach items="${groups_success }" var="group" varStatus="status">
									<tr>
										<td>${status.count }</td>
										<td>${group.groupCode }</td>
										<td><a href="${group.groupCode }/board/list" data-code="${group.groupCode }">${group.groupName }</a></td>
										<td>${group.leader }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${group.regDate }"/></td>
										<td><span class="label label-success">SUCCESS</span></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>				
					</div>
				</div>
				<div class="col-md-6">
					<!-- END TABLE STRIPED -->
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title"># 거부 그룹</h3>
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
									
									<c:forEach items="${groups_failed }" var="group" varStatus="status">
									<tr>
										<td>${status.count }</td>
										<td>${group.groupCode }</td>
										<td>${group.groupName }</td>
										<td>${group.leader }</td>
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${group.regDate }"/></td>
										<td><span class="label label-danger">FAILED</span></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!-- END TABLE STRIPED -->
					
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

<!-- Modal Content -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">그룹 관리</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                	<label>그룹 이름</label>
                	<input class="form-control" name="groupName" id="groupName" readonly="readonly" value="">
                </div>
                <div class="form-group">
                	<label>신청인</label>
                	<input class="form-control" name="leader" id="leader" readonly="readonly" value="">
                </div>
                <div class="form-group">
                	<label>신청 내용</label>
                	<textarea class="form-control" name="groupContent" id="groupContent" readonly="readonly" rows="6"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="acceptBtn">수락</button>
                <button type="button" class="btn btn-warning" id="holdBtn">보류</button>
                <button type="button" class="btn btn-danger" id="refusalBtn">거부</button>                            
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<script src="/resources/js/support/group.js"></script>
<script>
$(function(){
	var modal = $("#myModal");
	var acceptBtn = $("#acceptBtn");
	var holdBtn = $("#holdBtn");
	var refusalBtn = $("#refusalBtn");
	
	$(".mo").on("click", function(e){
		e.preventDefault();
		
		var code = $(this).data("code");
		modal.attr("data-code", code);	
		groupRequest.read(code, function(result){
			console.log(result);
			$("#groupName").val(result.groupName);
			$("#leader").val(result.leader);
			$("#groupContent").val(result.content);
		})	
		modal.modal("show");
	})
	
	
	acceptBtn.on("click", function(){
		var code = modal.data("code");
		groupRequest.update({groupCode:code, status:1}, function(result){
			if (result == "success"){
				modal.modal("hide");
				alert("승인완료");
				location.href="/admin/group";
			}
		})
	})
	
	refusalBtn.on("click", function(){
		var code = modal.data("code");
		groupRequest.update({groupCode:code, status:3}, function(result){
			modal.modal("hide");
			location.href="/admin/group";
		})
	})
	
	holdBtn.on("click", function(){
		var code = modal.data("code");
		modal.modal("hide");
	})
	
})	
</script>
<%@ include file="../includes/footer.jsp" %>