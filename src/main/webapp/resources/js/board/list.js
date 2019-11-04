/**
 * 게시판의 list와 관련된 스크립트
 */
$(function(){
	var form = $("#form");		
	var amount = '${page.criteria.amount }';
	var code = '${info.group.groupCode }';
	$("#amount").val(amount).attr('selected', true);		
				
	//페이지당 몇개의 글을 볼 것 인가 기본값 20
	$("#amount").change(function(){			
		form.find("input[name='amount']").val($(this).val());
		form.submit();
	})
	
	//페이징 넘버를 클릭시 해당 페이지로 이동하기 위한 함수
	$(".paginate_button a").click(function(e){
		e.preventDefault();		
		form.find("input[name='pageNum']").val($(this).attr("href"));			
		form.submit();
	})
		
	//검색을 위한 스크립트
	var search = $("#search");	
	var type = '${page.criteria.type}';
	var keyword = '${page.criteria.keyword}';
	
	$("#type").val(type).attr('selected', true);
	search.find("input[name='keyword']").val(keyword);
	
	search.find("button").click(function(e){
		e.preventDefault();				
		if (!search.find("input").val()){
			alert("검색어를 입력하세요.");
			search.find("input").focus();
			return;
		}
		search.find("input[name='pageNum']").val("1");		
		search.submit();			
	})
		
	//제목 클릭시 실행될 스크립트
	$(".move").click(function(e){
		e.preventDefault();		
		actionForm.attr("action", "/"+code+"/board/read+"+$(this).attr("href")+"");
		actionForm.submit();
	})
	
	
})