package com.ojakgyo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ojakgyo.domain.GroupMemberVO;
import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.ItemVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.domain.ProcedureVO;
import com.ojakgyo.mapper.AccountMapper;
import com.ojakgyo.mapper.GroupMapper;
import com.ojakgyo.mapper.ItemMapper;

@Service
public class GroupServiceImpl implements GroupService {

	@Autowired
	GroupMapper mapper;
	@Autowired
	ItemMapper item_mapper;
	@Autowired
	AccountMapper account_mapper;
	
	
	
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
		
		GroupVO temp = mapper.groupRead(group.getGroupCode());
		MemberVO member = account_mapper.MemberNickNameCheck(temp.getLeader());
		
		if (member.getGroupCodes().size() == 4)
			return false;
		
		boolean result = mapper.changeStatus(group);
		if (result && group.getStatus() == 1) {
			if (item_mapper.check_item(group.getGroupCode()) == 0) {
				ProcedureVO procedure = new ProcedureVO();
				procedure.setIndata(group.getGroupCode());
				System.out.println(procedure.getIndata());
				item_mapper.create_item(procedure);
				System.out.println(procedure.getOutdata());
				if (procedure.getOutdata() != null && procedure.getOutdata().equals("success")) {
					//유저DB의 groupCode 중 빈곳을 찾아 넣어줘야함. (leader)				
					
					if (member.getGroupCode1() == null) {
						member.setGroupCode1(group.getGroupCode());
					} else if (member.getGroupCode2() == null) {
						member.setGroupCode2(group.getGroupCode());
					} else if (member.getGroupCode3() == null) {
						member.setGroupCode3(group.getGroupCode());
					} else if (member.getGroupCode4() == null) {
						member.setGroupCode4(group.getGroupCode());
					}									
					account_mapper.modify(member);
					result = mapper.register(group.getGroupCode(), member);
					
				} else {
					result = false;
				}
			} else {
				result = false;
			}			
		}
		return result;
	}
	
	@Override
	public List<GroupVO> myGroups(String leader) {
		return mapper.myGroups(leader);
	}
	
	@Transactional
	@Override
	public boolean register(String groupCode, MemberVO member) {
		
		boolean result = mapper.register(groupCode, member);
		MemberVO member2 = account_mapper.read(member.getUserId());	
		if (member2.getGroupCodes().size() != 4) {
			
			if (member2.getGroupCode1() == null) {
				member2.setGroupCode1(groupCode);
			} else if (member2.getGroupCode2() == null) {
				member2.setGroupCode2(groupCode);
			} else if (member2.getGroupCode3() == null) {
				member2.setGroupCode3(groupCode);
			} else if (member2.getGroupCode4() == null) {
				member2.setGroupCode4(groupCode);
			}
		}
		result = account_mapper.modify(member2);
		return result;
	}
	
	@Override
	public List<GroupMemberVO> list(String groupCode) {
		return mapper.list(groupCode);
	}
	
	@Transactional
	@Override
	public boolean remove(GroupMemberVO gMember) {
		
		MemberVO member = account_mapper.MemberNickNameCheck(gMember.getNickName());
		String groupCode = gMember.getGroupCode();
		
		if (member.getGroupCode1() != null) {
			if (member.getGroupCode1().equals(groupCode))
				member.setGroupCode1(null);
		} 
		if (member.getGroupCode2() != null) {
			if (member.getGroupCode2().equals(groupCode))
				member.setGroupCode2(null);	
		}  
		if (member.getGroupCode3() != null) {
			if (member.getGroupCode3().equals(groupCode))
				member.setGroupCode3(null);	
		}  
		if (member.getGroupCode4() != null) {
			if (member.getGroupCode4().equals(groupCode))
				member.setGroupCode4(null);	
		}  		
		account_mapper.modify(member);
		
		return mapper.remove(gMember);
	}
	
	
	@Override
	public boolean modify(GroupMemberVO member) {
		return mapper.modify(member);
	}

}
