package com.ojakgyo.domain;

import lombok.Data;

@Data
public class MemberLoginVO {
	private String userId;
	private String current_password;
}
