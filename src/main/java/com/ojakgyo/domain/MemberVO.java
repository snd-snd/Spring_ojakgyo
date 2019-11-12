package com.ojakgyo.domain;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import lombok.Data;


@Data
public class MemberVO {
	private String userId;
	private String userPw;
	private String new_password;
	private String confirm_password;
	private String userName;
	private String nickName;
	private String email;
	
	private String groupCode1;
	private String groupCode2;
	private String groupCode3;
	private String groupCode4;
	
	// 4개의 그룹아이디 중 널값을 제외한 그룹아이디들을 리스트에 담아 반환
	public List<String> getGroupCodes(){
		List<String> list = Arrays.asList(groupCode1, groupCode2, groupCode3, groupCode4);		
		return list.stream().filter(s -> (s != null)).collect(Collectors.toList());
	}
	//LoginVO 세션 보내기
	
	//비밀번호와 비밀번호확인 대조하기
	public boolean isPasswordEqualConfirmPassword() {
		return userPw.equals(confirm_password);
	}
	//새비밀번호와 비밀번호확인 대조하기
	public boolean isNewPasswordEqualConfirmPassword() {
		return new_password.equals(confirm_password);
	}
}
