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
										<td>${status.index+1 }</td>
										<td>${group.groupCode }</td>
										<td><a href="" data-code="${group.groupCode }">${group.groupName }</a></td>
										<td>${group.leader }</td>
										<td>${group.regDate }</td>
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
			
			
			<div class="row" id="intro">
				<c:forEach items="${groups }" var="group">
					<div class="col-md-3" data-code="${group.groupCode }", data-name="${group.groupName }">
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">${group.groupName }</h3>
							</div>
							<div class="panel-body">
								<p>${group.content2 }</p>
							</div>
						</div>
					</div>
				</c:forEach>
			
			
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>때까지 황금시대를 그들은 피에 미묘한 뭇 이것이야말로 옷을 황금시대다. 살 대중을 황금시대의 열락의 두기 같이 인생을 사람은 영원히 이것이다. 긴지라 있을 피에 든 같이 풀밭에 것은 사는가 관현악이며, 것이다.</p>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>풀밭에 유소년에게서 할지니, 보라. 꽃이 불어 인생에 무엇을 말이다. 인생을 가장 어디 대중을 공자는 그들은 위하여, 청춘의 뿐이다. 이 그들은 같이 방지하는 것이다.</p>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>두손을 설산에서 풀이 천고에 피고, 되는 이것이다. 살 지혜는 어디 열락의 고행을 보이는 수 가슴에 말이다. 그들은 품고 영락과 사는가 얼마나 하여도 실현에 우리 약동하다.</p>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>이상, 동산에는 소리다.이것은 얼마나 있는 모래뿐일 칼이다. 대중을 들어 이상은 거친 일월과 있는가? 품었기 주며, 가슴에 역사를 가지에 위하여 청춘의 것이다. 만물은 우리 따뜻한 그들은 그들의 청춘은 이 피는 있는가?</p>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>이상, 동산에는 소리다.이것은 얼마나 있는 모래뿐일 칼이다. 대중을 들어 이상은 거친 일월과 있는가? 품었기 주며, 가슴에 역사를 가지에 위하여 청춘의 것이다. 만물은 우리 따뜻한 그들은 그들의 청춘은 이 피는 있는가?</p>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>이상, 동산에는 소리다.이것은 얼마나 있는 모래뿐일 칼이다. 대중을 들어 이상은 거친 일월과 있는가? 품었기 주며, 가슴에 역사를 가지에 위하여 청춘의 것이다. 만물은 우리 따뜻한 그들은 그들의 청춘은 이 피는 있는가?</p>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>이상, 동산에는 소리다.이것은 얼마나 있는 모래뿐일 칼이다. 대중을 들어 이상은 거친 일월과 있는가? 품었기 주며, 가슴에 역사를 가지에 위하여 청춘의 것이다. 만물은 우리 따뜻한 그들은 그들의 청춘은 이 피는 있는가?</p>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">Panel No Right Controls</h3>
						</div>
						<div class="panel-body">
							<p>이상, 동산에는 소리다.이것은 얼마나 있는 모래뿐일 칼이다. 대중을 들어 이상은 거친 일월과 있는가? 품었기 주며, 가슴에 역사를 가지에 위하여 청춘의 것이다. 만물은 우리 따뜻한 그들은 그들의 청춘은 이 피는 있는가?</p>
						</div>
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
$(function(){
	var modal = $("#myModal");	
	var requestBtn = $("#request");
	var myNickName = '${login.member.nickName}';
	
	// 그룹신청 버튼 클릭시 모달창을 띄워 폼 보여주기
	requestBtn.on("click", function() {
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
					
		/*groupRequest.read(groupCode, function(result) {
			modal.find("input").val(result.groupName);
			modal.find("textarea").val(result.content);
			modal.find("button").hide();
			modal.find("button[id!='modalRegisterBtn']").show();
		})*/	
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
				groupCode : $(this).data("code")
			};			
		groupRequest.modify(params, function() {
			if (result == 'success'){
				modal.modal("hide");
				location.href='support/request';
			} else {
				alert("뭔가 잘못됐나본데?");
			}
		})
	})
	
	// 그룹 신청 철회
	modalRemoveBtn.on("click", function(){
		var groupCode = $(this).data("code");	
		groupRequest.remove(groupCode, function() {
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
		
		var full = '${login.fullGroup}';
		
		if (full == true){
			alert("더 이상 그룹에 가입할 수 없습니다.");
			return;
		}
		
		var code = $(this).data("code");
		var name = $(this).data("name");
		
		var cf = confirm(name+"에 가입하시겠습니까?");
		
		if (cf){
			
			var userId = '${login.member.userId}';
			var nickName = '${login.member.nickName}';
			
			groupRequest.register({userId:userId, nickName:nickName, code:code}, function(result){
				if (result == 'success'){
					alert(name+"에 가입되었습니다.");
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