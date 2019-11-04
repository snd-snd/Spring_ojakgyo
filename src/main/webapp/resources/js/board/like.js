/**
 * 좋아요 관련 스크립트
 */

var likeService = (function(){
	
	function likeTotal(params, callback){
		var code = params.code;
		var bno = params.bno;
	
		$.getJSON({
			type : 'get',
			url : '/'+code+'/like/'+bno,
			success : function(data){
				if(callback){
					callback(data);
				}
			}
		});		
	} // END function likeTotal
	
	function likeCheck(params, callback){
		var code = params.code;
		
		$.ajax({
			type : 'post',
			url : '/'+code+'/like/likeCheck',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(data){
				if(callback){
					callback(data);
				}				
			}
		});
	} // END function likeCheck
	
	function action(params, callback){
		var code = params.code;
		
		$.ajax({
			type : 'post',
			url : '/'+code+'/like/action',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(data){
				if(callback){
					callback(data);
				}				
			}
		});
	} // END function action
			
	function cancel(params, callback){
		var code = params.code;
		
		$.ajax({
			type : 'delete',
			url : '/'+code+'/like/cancel',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(data){
				if(callback){
					callback(data);
				}
			}
		});		
	} //  END function cancel
	
	return{ //클로저 패턴
		likeTotal:likeTotal,
		likeCheck:likeCheck,
		action:action,
		cancel:cancel
	};
	
})();