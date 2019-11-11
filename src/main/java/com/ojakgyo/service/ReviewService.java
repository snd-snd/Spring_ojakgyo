package com.ojakgyo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ojakgyo.domain.BoardVO;


public interface ReviewService {
	
	public List<BoardVO> ReviewList();
}
