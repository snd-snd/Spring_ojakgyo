package com.ojakgyo.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
public class ReplyPageVO {

	private int totalCount;
	private List<ReplyVO> replys;
}
