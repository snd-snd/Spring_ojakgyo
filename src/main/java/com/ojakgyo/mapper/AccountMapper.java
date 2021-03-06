package com.ojakgyo.mapper;

import java.util.List;

import com.ojakgyo.domain.MemberVO;

public interface AccountMapper {
	
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
	
	MemberVO read(String userId);
	boolean modify(MemberVO member);
	
	List<MemberVO> listAll();
}
