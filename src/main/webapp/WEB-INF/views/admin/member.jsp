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
								<tr>
									<td>1</td>
									<td>kim123</td>
									<td>김태호</td>
									<td>Laverth</td>
									<td>hyssop9734@naver.com</td>
								</tr>
								<tr>
									<td>2</td>
									<td>lee123</td>
									<td>이호진</td>
									<td>hojin2312</td>
									<td>hojin9314@google.com</td>
								</tr>
								<tr>
									<td>3</td>
									<td>hong319</td>
									<td>홍길동</td>
									<td>Gildond32</td>
									<td>hong3314@daum.net</td>
								</tr>															
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