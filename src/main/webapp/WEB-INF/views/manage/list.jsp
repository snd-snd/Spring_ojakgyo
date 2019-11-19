<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   

  <script>
  //헤더에 들어가기전에 알람이 뜨는 장소와 자기가 있는 현재 페이지가 같다면
  // 알람을 띄우지 않게 하기위해 자신의위치를 알려주는 flag
  var flagPage="manage-list";
  </script> 
<%@ include file="../includes/header.jsp" %>
<!-- MAIN -->
<div class="main">
   <%@ include file="../includes/alarm.jsp"%>
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
										<td><fmt:formatDate pattern="yyyy-MM-dd" value="${member.regDate }"/></td>
										<c:if test="${member.nickName != login.member.nickName }">
										<td><button class="btn btn-info" data-name="${member.nickName }">설정</button></td>
										</c:if>
										<c:if test="${member.nickName == login.member.nickName }">
										<td></td>
										</c:if>
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
        <div class="form-group">
                	<label>닉네임</label>
                	<input class="form-control" id="modalNick" readonly="readonly">
                </div>
                <div class="form-group">
                	<label>내용</label>
                	<textarea class="form-control" id="modalContent" placeholder="사유를 적어주세요." rows="4"></textarea>
                </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" id="expulsion">추방</button>
        <button type="button" class="btn btn-primary" id="delegation">권한위임</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal end -->


<input type="hidden"  id="groupName" value="${group.groupName }"/>
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
		var value = $(this).data("name");
		
		$("#modalNick").val(value);		
	})
	
	expulsion.click(function(){
		var check = confirm("정말 추방하시겠습니까?");
		var nickName = $("#modalNick").val();
		var content = $("#modalContent").val();
		var groupName= $("#groupName").val();
		
		if (check){
			groupKick();
			manage.remove({nickName:nickName, groupCode:groupCode}, function(result){
				if (result == "success"){
					modal.modal("hide");
					location.href="/manage/"+groupCode;
				}
				
			}) 
		}
	
	})
	
	delegation.click(function(){
		var check = confirm("그룹을 정말 위임하시겠습니까?");
		var nickName = $("#modalNick").val();
		var content = $("#modalContent").val();
		
		if (check){
			manage.modify({nickName:nickName, groupCode:groupCode}, function(result){
				modal.modal("hide");
				location.href="/";
				
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