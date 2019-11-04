package com.ojakgyo.domain;

import lombok.Data;

@Data
public class MemberUpdateVO {
	private String userid;
	private String current_password;
	private String new_password;
	private String confirm_password;

	public boolean isPasswordEqualConfirmPassword() {
		return new_password.equals(confirm_password);
	}
}
