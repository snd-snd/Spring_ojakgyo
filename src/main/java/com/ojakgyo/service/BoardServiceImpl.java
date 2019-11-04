package com.ojakgyo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.BoardInfoVO;
import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.mapper.BoardMapper;
import com.ojakgyo.mapper.GroupMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper board_mapper;
	
	@Autowired
	GroupMapper group_mapper;
	
	@Transactional
	@Override
	public BoardInfoVO list(String groupCode, CriteriaVO criteria) {
		BoardInfoVO info = new BoardInfoVO();
		info.setBoards(board_mapper.list(groupCode, criteria));
		info.setGroup(group_mapper.groupRead(groupCode));	
		return info;
	}
	
	@Transactional
	@Override
	public BoardVO read(String groupCode, int bno) {
		board_mapper.readUp(groupCode, bno);
		return board_mapper.read(groupCode, bno);
	}
	
	@Override
	public boolean register(String groupCode, BoardVO board) {
		return board_mapper.register(groupCode, board);
	}
	
	@Override
	public boolean modify(String groupCode, BoardVO board) {
		return board_mapper.modify(groupCode, board);
	}
	
	@Override
	public boolean readCount(String groupCode, int bno) {
		return board_mapper.readCount(groupCode, bno);
	}
	
	@Override
	public boolean remove(String groupCode, int bno) {
		return board_mapper.remove(groupCode, bno);
	}
	
	@Override
	public int totalCount(String groupCode, CriteriaVO criteria) {
		return board_mapper.totalCount(groupCode, criteria);
	}
}
