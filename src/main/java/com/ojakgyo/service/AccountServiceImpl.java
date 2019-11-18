package com.ojakgyo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.mapper.AccountMapper;
import com.ojakgyo.mapper.GroupMapper;

@Service
public class AccountServiceImpl implements AccountService {

	@Autowired // == Inject
	private AccountMapper mapper;
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
			login = new LoginVO();
			login.setMember(member);
			List<GroupVO> groups = new ArrayList<GroupVO>();			
			if (!member.getGroupCodes().isEmpty()){
				groups = group_mapper.groupList(member);
			}
			login.setGroups(groups);
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
	
	@Override
	public MemberVO read(String userId) {
		return mapper.read(userId);
	}
	
	@Override
	public List<MemberVO> listAll() {
		return mapper.listAll();
	}
}
