package com.ojakgyo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.domain.ProcedureVO;
import com.ojakgyo.mapper.GroupMapper;
import com.ojakgyo.mapper.ItemMapper;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	GroupMapper mapper;
	@Autowired
	ItemMapper item_mapper;
	
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
	
	@Override
	public List<GroupVO> listStatus(int status) {
		return mapper.listStatus(status);
	}
	
	@Transactional
	@Override
	public boolean changeStatus(GroupVO group) {
		boolean result = mapper.changeStatus(group);
		if (result && group.getStatus() == 1) {
			if (item_mapper.check_item(group.getGroupCode()) == 0) {
				ProcedureVO procedure = new ProcedureVO();
				procedure.setInput(group.getGroupCode());
				item_mapper.create_item(procedure);
				if (procedure.getOutput() != null && procedure.getOutput().equals("success")) {
					//유저DB의 groupCode 중 빈곳을 찾아 넣어줘야함. (leader)
					result = true;
				} else {
					result = false;
				}
			} else {
				result = false;
			}			
		}
		return result;
	}
}
