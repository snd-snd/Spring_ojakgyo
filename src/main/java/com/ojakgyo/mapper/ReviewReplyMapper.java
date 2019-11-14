package com.ojakgyo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyVO;

public interface ReviewReplyMapper {

	public List<ReplyVO> ReviewReplyList(@Param("bno") int bno, @Param("cri") CriteriaVO cri);

	public boolean ReviewReplyInsert(ReplyVO vo);

	public int ReviewReplyDelete(int rno);
	
	public int BnoCnt(int bno);

}
