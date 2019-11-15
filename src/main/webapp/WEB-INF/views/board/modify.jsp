<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>  
<!-- MAIN -->
<div class="main">
   <%@ include file="../includes/alarm.jsp"%>
	<!-- MAIN CONTENT -->
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">Edit Post</h3>
			<div class="row">
				<div class="col-md-8">				
					<!-- INPUTS -->
					<div class="panel">
						<div class="panel-heading">
							<h3 class="panel-title">글수정</h3>
						</div>
						<div class="panel-body">
							<div>
								<label for=""></label>
								<input type="text" class="form-control input-lg" value="${board.title }" id="title">
							</div>						
							<div>
								<label for=""></label>
								<textarea class="form-control" id="edit"></textarea>
							</div>
						</div>
						<div class="panel-body">
							<div class="text-right">
								<button type="button" class="btn btn-warning" id="modify"><i class="fa fa-edit"></i><span>&ensp;</span>수정</button>											
								<button type="button" class="btn btn-info" id="list"><i class="fa fa-list"></i><span>&ensp;</span>목록</button>										
							</div>
						</div>
					</div>
					<!-- END INPUTS -->
				</div>
			</div>
		</div>
	</div>
	<!-- END MAIN CONTENT -->
</div>
<!-- END MAIN -->
<form action="/${group.groupCode }board/modify/" method="post">
	<input type="hidden" name="bno" value="${board.bno }">
	<input type="hidden" name="title">
	<input type="hidden" name="content">
	<input type="hidden" name="writer" value="${board.writer }">
</form>
<div class="clearfix"></div>
<footer>
	<div class="container-fluid">
		<p class="copyright">Shared by <i class="fa fa-love"></i><a href="https://bootstrapthemes.co">BootstrapThemes</a></p>
	</div>
</footer>
<script>
	$(function(){
		var content = '${board.content}';
		
		CKEDITOR.replace('edit', {height: 500});
		CKEDITOR.instances.edit.setData(content);
		
		var btnModify = $("#modify");
		var btnList = $("#list");
		var form = $("form");
		
		btnModify.on("click",function(){
			var title = $("#title").val();
			var modify_content = CKEDITOR.instances.edit.getData();
			
			$("input[name='title']").val(title);
			$("input[name='content']").val(modify_content);
			
			//form.submit();
		})
	})
</script>
<%@ include file="../includes/footer.jsp" %>