package com.ojakgyo.domain;

import java.util.List;

import lombok.Data;

@Data
public class LoginVO {

	private String userId;
	private String nickName;
	private List<GroupVO> groups;
	
}
