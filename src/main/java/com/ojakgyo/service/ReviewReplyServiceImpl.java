package com.ojakgyo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;
import com.ojakgyo.mapper.ReviewMapper;
import com.ojakgyo.mapper.ReviewReplyMapper;

@Service("reviewReplyService")
public class ReviewReplyServiceImpl implements ReviewReplyService {

	@Autowired
	private ReviewMapper reviewmapper;

	@Autowired
	private ReviewReplyMapper reviewreplymapper;

	@Override
	public ReplyPageVO ReviewReplyList(int bno, CriteriaVO cri) {
		return new ReplyPageVO(reviewreplymapper.BnoCnt(bno), reviewreplymapper.ReviewReplyList(bno, cri));
	}

	@Override
	public boolean ReviewReplyInsert(ReplyVO vo) {
		reviewmapper.updateReplyCnt(1, vo.getBno());
		return reviewreplymapper.ReviewReplyInsert(vo);
	}

	@Override
	public int ReviewReplyDelete(int rno) {
		return reviewreplymapper.ReviewReplyDelete(rno);
	}

	@Override
	public boolean ReviewReplyUpdate(ReplyVO vo) {
		return reviewreplymapper.ReviewReplyUpdate(vo) == 1 ? true : false;
	}

	@Override
	public ReplyVO ReviewReplyRead(int rno) {
		return reviewreplymapper.ReviewReplyRead(rno);
	}

}
