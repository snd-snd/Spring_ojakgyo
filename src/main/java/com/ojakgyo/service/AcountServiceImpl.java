package com.ojakgyo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.mapper.AcountMapper;
import com.ojakgyo.mapper.GroupMapper;

@Service
public class AcountServiceImpl implements AcountService {

	@Autowired // == Inject
	private AcountMapper mapper;
	@Autowired
	private GroupMapper group_mapper;

	@Override
	public int Insert(MemberVO vo) {
		return mapper.MemberInsert(vo);
	}

	@Override
	public MemberVO CheckId(String userId) {
		return mapper.MemberIdCheck(userId);
	}
	
	@Override
	public MemberVO CheckNickName(String nickName) {
		return mapper.MemberNickNameCheck(nickName);
	}

	@Transactional
	@Override
	public LoginVO Login(MemberVO vo) {
		LoginVO login = null;
		MemberVO member = mapper.MemberLogin(vo);
		if (member != null) {
			List<GroupVO> groups = group_mapper.groupList(member);
			login = new LoginVO();
			login.setGroups(groups);
			login.setMember(member);
			
		}
		System.out.println(login);
		return login;
	}

	@Override
	public boolean Delete(MemberVO vo) {
		return mapper.MemberDelete(vo) == 1 ? true : false;
	}

	@Override
	public boolean Update(MemberVO vo) {
		return mapper.MemberUpdate(vo) == 1 ? true : false;
	}
	
	
}
