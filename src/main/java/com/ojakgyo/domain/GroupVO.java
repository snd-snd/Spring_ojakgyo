package com.ojakgyo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GroupVO {
	
	private String groupCode;
	private String groupName;
	private String content;
	private String leader;
	private Date regDate;
	private int status;
	private int headCount;
	
}

