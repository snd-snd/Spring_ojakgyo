package com.ojakgyo.domain;

import java.util.List;

import lombok.Data;

@Data
public class BoardInfoVO {
	
	List<BoardVO> boards;
	GroupVO group;
	
}
