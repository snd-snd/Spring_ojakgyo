package com.ojakgyo.service;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;

public interface ReviewReplyService{

	public ReplyPageVO ReviewReplyList(@Param("bno") int bno, @Param("cri") CriteriaVO cri);

	public boolean ReviewReplyInsert(ReplyVO vo);

	public int ReviewReplyDelete(int rno);

	public boolean ReviewReplyUpdate(ReplyVO vo);
	
	public ReplyVO ReviewReplyRead(int rno);
}
