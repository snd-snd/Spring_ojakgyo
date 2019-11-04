package com.ojakgyo.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {

	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int total;
	//현재 페이지, 페이지당 보여줄 게시물 수
	private CriteriaVO criteria;
	
	public PageVO(CriteriaVO criteria, int total) {
		this.criteria = criteria;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(criteria.getPageNum()/10.0))*10;
		this.startPage = endPage-9;
		
		//끝나는 페이지는 10개가 안될 수 도 있기 때문에 다시 한번 계산
		int realEnd = (int)(Math.ceil((total/1.0) / criteria.getAmount()));
		if(realEnd < endPage)
			this.endPage = realEnd;
		
		this.prev = startPage>1;
		this.next = endPage<realEnd;
	}
}
