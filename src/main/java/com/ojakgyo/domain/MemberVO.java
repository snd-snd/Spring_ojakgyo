package com.ojakgyo.domain;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import lombok.Data;


@Data
public class MemberVO {
	private String userId;
	private String userPw;
	private String confirm_password;
	private String userName;
	private String nickName;
	private String email;
	
	private String groupId1;
	private String groupId2;
	private String groupId3;
	private String groupId4;
	
	// 4개의 그룹아이디 중 널값을 제외한 그룹아이디들을 리스트에 담아 반환
	public List<String> getGroupIds(){
		List<String> list = Arrays.asList(groupId1, groupId2, groupId3, groupId4);		
		return list.stream().filter(s -> (s != null)).collect(Collectors.toList());
	}
	//LoginVO 세션 보내기
	
	//비밀번호와 비밀번호확인 대조하기
	public boolean isPasswordEqualConfirmPassword() {
		return userPw.equals(confirm_password);
	}
}
