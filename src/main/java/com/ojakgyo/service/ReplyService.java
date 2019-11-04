package com.ojakgyo.service;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;

public interface ReplyService {

	ReplyPageVO list(String groupCode, CriteriaVO criteria, int bno);
	ReplyVO read(String groupCode, int rno);
	int totalCount(String groupCode, int bno);
	boolean register(String groupCode, ReplyVO reply);
	boolean modify(String groupCode, ReplyVO reply);
	boolean remove(String groupCode, int rno);
}
