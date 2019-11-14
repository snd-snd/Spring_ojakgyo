package com.ojakgyo.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;
import com.ojakgyo.mapper.ReviewReplyMapper;

@Service("reviewReplyService")
public class ReviewReplyServiceImpl implements ReviewReplyService {

	@Inject
	private ReviewReplyMapper reviewreplymapper;

	@Override
	public ReplyPageVO ReviewReplyList(int bno, CriteriaVO cri) {
		return new ReplyPageVO(reviewreplymapper.BnoCnt(bno), reviewreplymapper.ReviewReplyList(bno, cri));
	}

	@Override
	public boolean ReviewReplyInsert(ReplyVO vo) {
		return reviewreplymapper.ReviewReplyInsert(vo);
	}

	@Override
	public int ReviewReplyDelete(int rno) {
		return reviewreplymapper.ReviewReplyDelete(rno);
	}

}
