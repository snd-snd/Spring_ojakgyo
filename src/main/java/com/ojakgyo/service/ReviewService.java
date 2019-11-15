package com.ojakgyo.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;

public interface ReviewService {

	public List<BoardVO> ReviewList(CriteriaVO cri);

	public BoardVO ReviewReadOne(@Param("bno") int bno);

	public int ReviewInsert(BoardVO vo);

	public boolean ReviewUpdate(BoardVO vo);

	public boolean ReviewDelete(int bno);

	public int totalCnt(CriteriaVO cri);

	public int updateReviewCount(int bno);// 조회수
}
