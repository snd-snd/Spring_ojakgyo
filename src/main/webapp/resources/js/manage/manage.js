/**
 * 
 */

var manage = (function(){
	

	function remove(params, callback){

		$.ajax({
			url : '/manage/delete',
			type : 'delete',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(result){
				if(callback){
					callback(result);
				}
			}
		});		
	} // END function remove
	
	
	function modify(params, callback){

		$.ajax({
			url : '/manage/modify',
			type : 'put',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(result){
				if(callback){
					callback(result);
				}
			}
		});		
	} // END function modify
	
	
	
	return{
		remove:remove,
		modify:modify
	};
})();