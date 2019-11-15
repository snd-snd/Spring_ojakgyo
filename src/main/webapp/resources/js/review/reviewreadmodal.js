/**
 * 
 */
var ReviewReplyService = (function() {

	function ReviewReplyInsert(reply, callback) {

		$.ajax({
			type : 'post',
			url : '/replies/new',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(reply),
			success : function(result) {
				if (callback) {
					callback(result);
				}
			}
		})
	}// add 끝나는 부분

	function ReviewReplyList(param, callback) {
		var bno = param.bno;
		var page = param.page || 1;

		$.getJSON({ // $.ajax({}) => 가져올 데이터 타입에 대한 지정이 필요한 상태
			url : '/replies/pages/' + bno + '/' + page,
			success : function(data) {
				if (callback) {
					callback(data.totalCount, data.replys);
				}
			}
		})
	} // getList end

	function ReviewReplyDelete(rno, callback) {
		$.ajax({
			url : '/replies/' + rno,
			type : 'delete',
			success : function(result) {
				if (callback) {
					callback(result);
				}
			}
		})
	} // remove 종료

	function ReviewReplyUpdate(param, callback) {
		var rno = param.rno;

		$.ajax({
			type : 'put',
			url : '/replies/' + rno,
			data : JSON.stringify(param),
			contentType : "application/json;charset=utf-8",
			success : function(result) {
				if (callback)
					callback(result);
			}
		})
	} // update 종료

	function ReviewReplyGet(rno, callback) {
		$.getJSON("/replies/" + rno, function(result) {
			if (callback) {
				callback(result);
			}
		})
	}

	function displayTime(timeValue) {
		// timeValue = 1571813787000
		var today = new Date();

		var gap = today.getTime() - timeValue;

		var dateObj = new Date(timeValue);

		var yy = dateObj.getFullYear();
		var mm = dateObj.getMonth() + 1; // 0~11
		var dd = dateObj.getDate();
		
		var hh = dateObj.getHours();
		var mi = dateObj.getMinutes();
		/*var ss = dateObj.getSeconds();*/

		return [ yy,'.', (mm > 9 ? '' : '0') + mm, '.', (dd > 9 ? '' : '0') + dd, ' ' ,(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi ].join('');
		
	}

	return {
		ReviewReplyInsert : ReviewReplyInsert,
		ReviewReplyList : ReviewReplyList,
		ReviewReplyDelete : ReviewReplyDelete,
		ReviewReplyUpdate : ReviewReplyUpdate,
		ReviewReplyGet : ReviewReplyGet,
		displayTime : displayTime
	};

})();