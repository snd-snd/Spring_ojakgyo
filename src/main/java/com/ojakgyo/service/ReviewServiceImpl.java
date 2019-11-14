package com.ojakgyo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.mapper.ReviewMapper;

@Service("reviewservice")
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewMapper reviewmapper;

	@Override
	public List<BoardVO> ReviewList(CriteriaVO cri) {

		return reviewmapper.ReviewList(cri);
	}

	@Override
	public BoardVO ReviewReadOne(int bno) {
		return reviewmapper.ReviewReadOne(bno);
	}

	@Override
	public int ReviewInsert(BoardVO vo) {
		return reviewmapper.ReviewInsert(vo);

	}

	@Override
	public boolean ReviewUpdate(BoardVO vo) {
		return reviewmapper.ReviewUpdate(vo)==1?true:false;
	}

	@Override
	public boolean ReviewDelete(int bno) {
		return reviewmapper.ReviewDelete(bno)==1?true:false;
	}

	@Override
	public int totalCnt(CriteriaVO cri) {
		return reviewmapper.totalCnt(cri);
	}

}
