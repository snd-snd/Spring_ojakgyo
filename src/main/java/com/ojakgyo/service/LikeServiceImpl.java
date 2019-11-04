package com.ojakgyo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.LikeVO;
import com.ojakgyo.mapper.BoardMapper;
import com.ojakgyo.mapper.LikeMapper;

@Service
public class LikeServiceImpl implements LikeService {

	@Autowired
	LikeMapper like_mapper;
	@Autowired
	BoardMapper board_mapper;
	
	@Override
	public int likeTotal(String groupCode, int bno) {
		return like_mapper.likeTotal(groupCode, bno);
	}

	@Override
	public int likeCheck(String groupCode, LikeVO like) {
		return like_mapper.likeCheck(groupCode, like);
	}

	@Transactional
	@Override
	public boolean action(String groupCode, LikeVO like) {		
		boolean result = false;		
		if (like_mapper.action(groupCode, like)) {
			if (board_mapper.likeUpDown(groupCode, like.getBno(), 1))
				result = true;		
		}
		return result;
	}

	@Transactional
	@Override
	public boolean cancel(String groupCode, LikeVO like) {
		boolean result = false;		
		if (like_mapper.cancel(groupCode, like)) {
			if (board_mapper.likeUpDown(groupCode, like.getBno(), -1))
				result = true;		
		}
		return result;		
	}
}
