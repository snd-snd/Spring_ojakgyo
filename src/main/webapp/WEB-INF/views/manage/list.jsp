<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ include file="../includes/header.jsp" %>
<!-- MAIN -->
<div class="main">
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Admin</h3>
			<div class="row">
				<div class="col-md-8">							
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title"># 회원 관리</h3>
						</div>
						<div class="panel-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>번호</th>
										<th>아이디</th>
										<th>닉네임</th>
										<th>등급</th>
										<th>가입일</th>
										<th>설정</th>
									</tr>
								</thead>
								<tbody>
	
									<c:forEach items="${list }" var="member">
										<tr>
											<td>${member.mno }</td>
											<td>${member.userId }</td>
											<td>${member.nickName }</td>
											<td>${member.score }</td>
											<td><fmt:parseDate pattern="yyyy-MM-dd" value="${member.regDate }"/></td>
											<td><button class="btn btn-info" data-name="${member.nickName }">설정</button></td>
										</tr>
									</c:forEach>
																								
								</tbody>
							</table>
						</div>				
					</div>
				</div>												
			</div>		
		</div>
	</div>
	<!-- END MAIN CONTENT -->
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">설정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" id="expulsion">추방</button>
        <button type="button" class="btn btn-primary" id="delegation">권한위임</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal end -->


<!-- END MAIN -->
<div class="clearfix"></div>
<script src="/resources/js/manage/manage.js"></script>
<script>
$(function(){
	
	var groupCode = '${code}';
	var modal = $(".modal");
	var expulsion = $("#expulsion");
	var delegation = $("#delegation");
	
	$("table").on("click", "button", function(){	
		modal.modal("show");
		$(".modal-body").html($(this).data("name"));		
	})
	
	expulsion.click(function(){
		var nickName = $(".modal-body").html();
		console.log(nickName);
		
		manage.remove({nickName:nickName, groupCode:groupCode}, function(result){
			if (result == "success"){
				modal.modal("hide");
				location.herf="/manage/"+groupCode;
			}
		}) 
	})
	
	delegation.click(function(){
		var check = confirm("그룹을 정말 위임하시겠습니까?");
		if (check){
			manage.modify({nickName:nickName, groupCode:groupCode}, function(result){
				if (result == "success"){
					modal.modal("hide");
					location.herf="/";
				}
			}) 		
		}
	})
	
	
	
})
</script>
<footer>
	<div class="container-fluid">
		<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
	</div>
</footer>

<%@ include file="../includes/footer.jsp" %>