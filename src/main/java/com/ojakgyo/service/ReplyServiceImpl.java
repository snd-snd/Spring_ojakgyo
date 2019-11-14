package com.ojakgyo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;
import com.ojakgyo.mapper.BoardMapper;
import com.ojakgyo.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyMapper reply_mapper;
	@Autowired
	BoardMapper board_mapper;
	
	@Transactional
	@Override
	public ReplyPageVO list(String groupCode, CriteriaVO criteria, int bno) {
		return new ReplyPageVO(reply_mapper.totalCount(groupCode, bno), reply_mapper.list(groupCode, criteria, bno));
	}

	@Override
	public ReplyVO read(String groupCode, int rno) {
		return reply_mapper.read(groupCode, rno);
	}

	@Override
	public int totalCount(String groupCode, int bno) {
		return reply_mapper.totalCount(groupCode, bno);
	}

	@Transactional
	@Override
	public boolean register(ReplyVO reply) {
		board_mapper.replyUpDown(reply.getGroupCode(), reply.getBno(), 1);
		return reply_mapper.register(reply);
	}

	@Override
	public boolean modify(String groupCode, ReplyVO reply) {
		return reply_mapper.modify(groupCode, reply);
	}

	@Transactional
	@Override
	public boolean remove(String groupCode, int rno) {
		ReplyVO reply = reply_mapper.read(groupCode, rno);
		board_mapper.replyUpDown(groupCode, reply.getBno(), -1);
		return reply_mapper.remove(groupCode, rno);
	}

}
