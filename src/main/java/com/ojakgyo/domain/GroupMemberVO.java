package com.ojakgyo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GroupMemberVO {

	private int mno;
	private String userId;
	private String nickName;
	private int score;
	private Date regDate;
	private int admin;
	
}
