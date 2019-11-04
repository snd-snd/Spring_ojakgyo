package com.ojakgyo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.mapper.GroupMapper;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	GroupMapper mapper;
	
	@Override
	public List<GroupVO> groupList(MemberVO member) {
		return mapper.groupList(member);
	}
	
	@Override
	public String maxGroupCode() {
		return mapper.maxGroupCode();
	}
	
	@Transactional
	@Override
	public boolean groupRegister(GroupVO group) {		
		String code = mapper.maxGroupCode();
		int number = Integer.parseInt(code.replace("GN", ""))+1;
		String groupCode = "GN"+String.valueOf(number);
		group.setGroupCode(groupCode);
		return mapper.groupRegister(group);
	}
	
	@Override
	public GroupVO groupRead(String groupCode) {
		return mapper.groupRead(groupCode);
	}
	
	@Override
	public boolean groupModify(GroupVO group) {
		return mapper.groupModify(group);
	}
	
	@Override
	public boolean groupRemove(String groupCode) {
		return mapper.groupRemove(groupCode);
	}
}
