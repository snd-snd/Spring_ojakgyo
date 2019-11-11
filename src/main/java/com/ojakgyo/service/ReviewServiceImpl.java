package com.ojakgyo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.mapper.ReviewMapper;

@Service("reviewservice")
public class ReviewServiceImpl implements ReviewService{

	@Inject
	private ReviewMapper reviewmapper;
	
	@Override
	public List<BoardVO> ReviewList() {
		
		return reviewmapper.ReviewList();
	}

}
