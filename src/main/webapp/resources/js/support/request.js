/**
 * 그룹 신청과 관련된 스크립트
 */

var groupRequest = (function(){
	
	// 그룹 생성 요청시 호출되는 함수
	function add(params, callback){	
		$.ajax({
			type : 'post',
			url : '/groups/new',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(result){
				if(callback){
					callback(result);
				}				
			}
		});
	} // END function add
	
	// 그룹 신청내역 변경 시 호출되는 함수
	function read(groupCode, callback){	
		$.getJSON("/groups/"+groupCode, function(result){
			if (callback){
				callback(result);
			}
		});	
	} // END function read
	
	// 그룹 신청내역 변경 후 수정 버튼 클릭시 호출되는 함수
	function modify(params, callback){
		$.ajax({
			type : 'put',
			url : '/groups',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(result){
				if(callback){
					callback(result);
				}				
			}
		});		
	} // END function modify
	
	// 그룹 신청 내역을 철회할 때 호출되는 함수
	function remove(groupCode, callback){	
		$.ajax({
			url : '/groups/'+groupCode,
			type : 'delete',
			success : function(result){
				if(callback){
					callback(result);
				}
			}
		});		
	} // END function remove
	
	return{
		add : add,
		read : read,
		modify : modify,
		remove : remove
	};
})();


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
		var myId = '${login.userId}';
		var groupCode = $(this).data("code");
		
/* 		if (myId != leader){
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
			leader : '${login.userId}'
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