package com.ojakgyo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ojakgyo.domain.GroupMemberVO;
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
	
	List<GroupVO>myGroups (String leader);
	boolean register(@Param("groupCode") String groupCode,@Param("member") MemberVO member);
	
	List<GroupMemberVO> list(@Param("groupCode") String groupCode);
	boolean remove(GroupMemberVO member);
	GroupMemberVO read(GroupMemberVO member);
	boolean modify(GroupMemberVO member);
	
}
