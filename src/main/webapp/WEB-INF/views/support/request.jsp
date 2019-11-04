<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<!-- MAIN -->
<div class="main">
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Support</h3>
			<div class="row">
				<div class="col-md-8">							
					<!-- TABLE STRIPED -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title"># 그룹 신청 센터</h3>
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
									<tr>
										<td>1</td>
										<td>GN13</td>
										<td><a href="">김치에 대한 연구</a></td>
										<td>kim123</td>
										<td>2019-11-02</td>
										<td><span class="label label-success">SUCCESS</span></td>
									</tr>
									<tr>
										<td>2</td>
										<td>GN302</td>
										<td><a href="">책을 좋아하는 사람들</a></td>
										<td>google9821</td>
										<td>2019-11-05</td>
										<td><span class="label label-danger">FAILED</span></td>
									</tr>
									<tr>
										<td>3</td>
										<td>GN0001</td>
										<td><a href="">개발자 모임</a></td>
										<td>laverth</td>
										<td>2019-11-07</td>
										<td><span class="label label-warning">PENDING</span></td>
									</tr>
									<c:forEach items="${groups }" var="group" varStatus="status">
									<tr>
										<td>${status.current }</td>
										<td>${group.groupCode }</td>
										<td><a href="" data-code="${group.groupCode }">${group.groupName }</a></td>
										<td>${group.leader }</td>
										<td>${group.regDate }</td>
										<td>${group.status }</td>
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
                	<label>신청 내용</label>
                	<textarea class="form-control" name="groupContent" placeholder="신청 내용을 작성해주세요." rows="6"></textarea>
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
<script src="/resources/js/support/request.js"></script>
<%@ include file="../includes/footer.jsp" %>