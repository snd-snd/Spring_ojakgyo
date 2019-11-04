package com.ojakgyo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class PrivateGroupVO {

	private int mno;
	private String userId;
	private String userName;
	private int level;
	private Date regDate;
	private int admin;
}
