package com.ojakgyo.mapper;

import com.ojakgyo.domain.MemberVO;

public interface AcountMapper {
	
	//회원가입
	public int MemberInsert(MemberVO vo);
	//중복 아이디 검사
	public MemberVO MemberIdCheck(String userId);
	//로그인
	public MemberVO MemberLogin(MemberVO vo);
	//회원탈퇴
	public int MemberDelete(MemberVO vo);
	//비밀번호 변경
	public int MemberUpdate(MemberVO vo);
	
	MemberVO read(String userId);
	boolean modify(MemberVO member);
}
