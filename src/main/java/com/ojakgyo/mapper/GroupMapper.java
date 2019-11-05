package com.ojakgyo.mapper;

import java.util.List;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.MemberVO;

public interface GroupMapper {
	List<GroupVO> groupList(MemberVO member);
	String maxGroupCode();
	boolean groupRegister(GroupVO group);
	GroupVO groupRead(String groupCode);
	boolean groupModify(GroupVO group);
	boolean groupRemove(String groupCode);
	
	List<GroupVO>listStatus (int status);
	boolean changeStatus(GroupVO group);
}
