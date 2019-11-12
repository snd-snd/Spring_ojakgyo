package com.ojakgyo.service;

import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.domain.MemberVO;

public interface AcountService {

	//회원가입
	public int Insert(MemberVO vo);
	//중복 아이디 검사
	public MemberVO CheckId(String userId);
	//중복 닉네임 검사
	public MemberVO CheckNickName(String nickName);
	//로그인
	public LoginVO Login(MemberVO vo);
	//회원탈퇴
	public boolean Delete(MemberVO vo);
	//회원수정
	public boolean Update(MemberVO vo);
	

}
