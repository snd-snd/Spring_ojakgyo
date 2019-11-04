package com.ojakgyo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ojakgyo.domain.MemberInfoVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.domain.MemberLoginVO;
import com.ojakgyo.domain.MemberUpdateVO;
import com.ojakgyo.mapper.AcountMapper;

@Service
public class AcountServiceImpl implements AcountService {

	@Autowired // == Inject
	private AcountMapper mapper;

	@Override
	public int Insert(MemberVO vo) {
		return mapper.MemberInsert(vo);
	}

	@Override
	public MemberVO CheckId(String userId) {
		return mapper.MemberIdCheck(userId);
	}

	@Override
	public MemberInfoVO Login(MemberLoginVO vo) {
		return mapper.MemberLogin(vo);
	}

	@Override
	public boolean Delete(MemberLoginVO vo) {
		return mapper.MemberDelete(vo) == 1 ? true : false;
	}

	@Override
	public boolean Update(MemberUpdateVO vo) {
		return mapper.MemberUpdate(vo) == 1 ? true : false;
	}
}
