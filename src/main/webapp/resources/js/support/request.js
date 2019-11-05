/**
 * 그룹 신청과 관련된 스크립트
 */

$(function(){
	var modal = $("#myModal");	
	var requestBtn = $("#request");
	
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
		var myNickName = '${login.nickName}';
		var groupCode = $(this).data("code");
		
 		/*if (myNickName != leader){
			alert("본인이 신청한 내역만 수정할 수 있습니다.")
			return;
		} */		
		
		groupRequest.read(groupCode, function(result) {
			modal.find("input").val(result.groupName);
			modal.find("textarea").val(result.content);
			modal.find("button").hide();
			modal.find("button[id!='modalRegisterBtn']").show();
			modal.modal("show");			
		})	
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
			leader : '${login.nickName}'
		};	
		groupRequest.add(params, function(result){
			if (result == 'success'){
				modal.modal("hide");
				location.href='support/request';
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
	
})