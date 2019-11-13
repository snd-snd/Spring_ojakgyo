/**
 * 
 */

var manage = (function(){
	

	function remove(params, callback){
		var mno = params.mno;
		var code = params.code;
		
		$.ajax({
			url : '/manage/'+code+"/"+mno,
			type : 'delete',
			success : function(result){
				if(callback){
					callback(result);
				}
			}
		});		
	} // END function remove
	
	
	
	
	return{
		remove:remove
	};
})();