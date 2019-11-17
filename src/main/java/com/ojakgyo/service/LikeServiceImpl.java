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
	public int likeCheck(LikeVO like) {
		return like_mapper.likeCheck(like);
	}

	@Transactional
	@Override
	public boolean action(LikeVO like) {		
		boolean result = false;		
		if (like_mapper.action(like)) {
			if (board_mapper.likeUpDown(like.getGroupCode(), like.getBno(), 1))
				result = true;		
		}
		return result;
	}

	@Transactional
	@Override
	public boolean cancel(LikeVO like) {
		boolean result = false;		
		if (like_mapper.cancel(like)) {
			if (board_mapper.likeUpDown(like.getGroupCode(), like.getBno(), -1))
				result = true;		
		}
		return result;		
	}
}
