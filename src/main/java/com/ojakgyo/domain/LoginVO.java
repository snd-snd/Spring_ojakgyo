package com.ojakgyo.domain;

import java.util.List;

import lombok.Data;

@Data
public class LoginVO {

	private MemberVO member;
	private List<GroupVO> groups;
	
	
	public boolean isFullGroup() {
		long count = groups.stream().filter(g -> g != null).count();
		return count == 4 ? true : false;
	}
	
}
