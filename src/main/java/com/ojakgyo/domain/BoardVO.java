package com.ojakgyo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {

	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private int readCount;
	private int likeCount;
	private String xpos;//지도x좌표값
	private String ypos;//지도y좌표값
	private String groupCode;
}
