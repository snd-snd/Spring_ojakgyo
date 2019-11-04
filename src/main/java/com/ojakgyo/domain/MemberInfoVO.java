package com.ojakgyo.domain;

import lombok.Data;

@Data
public class MemberInfoVO {
	//로그인 성공 후 정보 담는 객체
	private String userId;
	private String nickName;
}
