/**
 * 댓글 관련 스크립트
 * 
 * 자바스크립트 모듈화 : 클로저 패턴
 */

var replySerivce = (function(){
	
	function getList(params, callback){
		var code = params.code;
		var bno = params.bno;
		var page = params.page || 1;
		
		$.getJSON({
			type : 'get',
			url : '/'+code+'/reply/pages/'+bno+'/'+page,
			success : function(data){
				if(callback){
					callback(data.totalCount, data.replys);
				}
			}
		});		
	} // END function getList
	
	function add(params, callback){
		var code = params.code;
		
		$.ajax({
			type : 'post',
			url : '/'+code+'/reply/new',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(data){
				if(callback){
					callback(data);
				}				
			}
		});
	} // END function add
	
		
	function remove(params, callback){
		var code = params.code;
		var rno = params.rno;
		
		$.ajax({
			url : '/'+code+'/reply/'+rno,
			type : 'delete',
			success : function(data){
				if(callback){
					callback(data);
				}
			}
		});		
	} //  END function remove

	function modify(params, callback){
		var rno = params.rno
		var code = params.code
		
		$.ajax({
			type : 'put',
			url : '/'+code+'/reply/'+rno,
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(params),
			success : function(data){
				if(callback){
					callback(data);
				}				
			}
		});		
	} // END function modify
	
	
	function read(params, callback){
		var rno = params.rno
		var code = params.code
		$.getJSON("/"+code+"/reply/"+rno, function(data){
			if (callback){
				callback(data);
			}
		})		
	} // END function modify
	
	
	function displayTime(timeValue){
//		var today = new Date();
//		
//		var gap = today.getTime() - timeValue;
//		var dateObj = new Date(timeValue);
//		
//		if (gap < (1000*60*60*24)){
//			var HH = dateObj.getHours();
//			var mm = dateObj.getMinutes();
//			var ss = dateObj.getSeconds()
//			
//			return [(HH>9?'':'0')+HH,':',(mm>9?'':'0')+mm,':',(ss>9?'':'0')+ss].join('');
//		} else{
//			var yy = dateObj.getFullYear();
//			var MM = dateObj.getMonth()+1;
//			var dd = dateObj.getDate();
//			
//			return [ yy, '.', (MM>9?'':'0')+MM, '.', (dd>9?'':'0')+dd ].join('');
//		}
		
		var dateObj = new Date(timeValue);
		var yy = dateObj.getFullYear();
		var MM = dateObj.getMonth()+1;
		var dd = dateObj.getDate();
		var HH = dateObj.getHours();
		var mm = dateObj.getMinutes();
		
		return [ yy, '.', (MM>9?'':'0')+MM, '.', (dd>9?'':'0')+dd, '  ', (HH>9?'':'0')+HH,':',(mm>9?'':'0')+mm ].join('');
	}
	
	return{ //클로저 패턴
		add:add,
		getList:getList,
		remove:remove,
		modify:modify,
		read:read,
		displayTime:displayTime
	};
	
})();

