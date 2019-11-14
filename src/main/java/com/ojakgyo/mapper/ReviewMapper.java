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

}
