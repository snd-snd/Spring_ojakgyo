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
									<th>추방?</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>kim123</td>
									<td>Laverth</td>
									<td>1</td>
									<td>2010-12-12</td>
									<td><button class="btn btn-danger">추방</button></td>
								</tr>
								<tr>
									<td>2</td>
									<td>lee212</td>
									<td>마징가</td>
									<td>2</td>
									<td>2010-12-24</td>
									<td><button class="btn btn-danger">추방</button></td>
								</tr>
								<c:forEach items="${list }" var="member">
									<tr>
										<td>${member.mno }</td>
										<td>${member.userId }</td>
										<td>${member.nickName }</td>
										<td>${member.level }</td>
										<td><fmt:parseDate pattern="yyyy-MM-dd" value="${member.regDate }"/></td>
										<td><button class="btn btn-danger" data-mno="${member.mno }">추방</button></td>
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
<script src="/resources/js/manage/manage.js"></script>
<script>
$(function(){
	
	$("table").on("click", "button", function(){
		var mno = $(this).data("mno");
		var code = '${code}';
		
		manage.remove({mno:mno, code:code}, function(result){
			if (result == "success"){
				location.herf="/manage/"+code;
			}
		})
		
		
	})
})
</script>
<footer>
	<div class="container-fluid">
		<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
	</div>
</footer>

<%@ include file="../includes/footer.jsp" %>