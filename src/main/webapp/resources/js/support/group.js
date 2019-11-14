/**
 * 그룹 신청과 관련된 스크립트
 * 
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
			url : '/groups/'+params.groupCode,
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
	
	// 스테이터스 변경을 위한 함수 (스테이터스가 수락으로 변경될 경우 테이블 생성!!!!!!!!!!!!!!!!
	function update(params, callback){
		$.ajax({
			type : 'patch',
			url : '/groups/runrun',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(result){
				if(callback){
					callback(result);
				}				
			}
		});		
	} // END function update
	
	
	function register(params, callback){
		var code = params.code;
		
		$.ajax({
			type : 'post',
			url : '/support/new/'+code,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(result){
				if(callback){
					callback(result);
				}				
			}
		});		
	} // END function register
	
	
	return{
		add : add,
		read : read,
		modify : modify,
		remove : remove,
		update : update,
		register : register
	};
})();