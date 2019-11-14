package com.ojakgyo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private int rno;
	private int bno; // 게시글 번호를 참조
	private String reply; 
	private String replyer; // 닉네임
	private Date replyDate;
	private String groupCode;
	
}
