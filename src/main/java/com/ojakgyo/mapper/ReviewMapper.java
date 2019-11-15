package com.ojakgyo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;

public interface ReviewMapper {

	public List<BoardVO> ReviewList(CriteriaVO cri);

	public BoardVO ReviewReadOne(@Param("bno") int bno);

	public int ReviewInsert(BoardVO vo);

	public int ReviewUpdate(BoardVO vo);

	public int ReviewDelete(int bno);

	public int totalCnt(CriteriaVO cri);

	// 댓글 갯수 변경하기
	public int updateReplyCnt(@Param("amount") int amount, @Param("bno") int bno);

	// 조회수
	public int updateReviewCount(int bno);

}
