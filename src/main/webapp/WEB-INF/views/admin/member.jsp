<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
  <script>
  //헤더에 들어가기전에 알람이 뜨는 장소와 자기가 있는 현재 페이지가 같다면
  // 알람을 띄우지 않게 하기위해 자신의위치를 알려주는 flag
  var flagPage="admin-member";
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
									<th>이름</th>
									<th>닉네임</th>
									<th>이메일</th>
								</tr>
							</thead>
							<tbody>
								
								<c:forEach var="member" items="${list }" varStatus="status">
									<tr>
										<td>${status.count }</td>
										<td>${member.userId }</td>
										<td>${member.userName }</td>
										<td>${member.nickName }</td>
										<td>${member.email }</td>
									</tr>
								</c:forEach>															
							</tbody>
						</table>
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
		<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
	</div>
</footer>

<%@ include file="../includes/footer.jsp" %>