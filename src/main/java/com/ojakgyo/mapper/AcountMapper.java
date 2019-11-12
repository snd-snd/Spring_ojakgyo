package com.ojakgyo.mapper;

import com.ojakgyo.domain.MemberVO;

public interface AcountMapper {
	
	//회원가입
	public int MemberInsert(MemberVO vo);
	//중복 아이디 검사
	public MemberVO MemberIdCheck(String userId);
	//중복 닉네임 검사
	public MemberVO MemberNickNameCheck(String nickName);
	//로그인
	public MemberVO MemberLogin(MemberVO vo);
	//회원탈퇴
	public int MemberDelete(MemberVO vo);
	//회원수정
	public int MemberUpdate(MemberVO vo);
}
