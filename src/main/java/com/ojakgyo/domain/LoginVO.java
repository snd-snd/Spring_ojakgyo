package com.ojakgyo.domain;

import java.util.List;

import lombok.Data;

@Data
public class LoginVO {

	private MemberVO member;
	private List<GroupVO> groups;
	
}
