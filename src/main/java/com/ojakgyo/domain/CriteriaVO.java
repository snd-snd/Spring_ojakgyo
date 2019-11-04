package com.ojakgyo.domain;

import java.util.Arrays;
import java.util.List;

import lombok.Data;

@Data
public class CriteriaVO {
	
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	
	public CriteriaVO() {
		this(1,20);
	}
	
	public CriteriaVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public List<String> getTypeList() {
		return Arrays.asList(type.split(""));
	}
}
