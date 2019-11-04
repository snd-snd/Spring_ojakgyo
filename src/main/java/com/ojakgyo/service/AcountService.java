package com.ojakgyo.service;

import com.ojakgyo.domain.MemberInfoVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.domain.MemberLoginVO;
import com.ojakgyo.domain.MemberUpdateVO;

public interface AcountService {

	//회원가입
	public int Insert(MemberVO vo);
	//중복 아이디 검사
	public MemberVO CheckId(String userId);
	//로그인
	public MemberInfoVO Login(MemberLoginVO vo);
	//회원탈퇴
	public boolean Delete(MemberLoginVO vo);
	//비밀번호 변경
	public boolean Update(MemberUpdateVO vo);

}
