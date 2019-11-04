package com.ojakgyo.mapper;

import com.ojakgyo.domain.MemberInfoVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.domain.MemberLoginVO;
import com.ojakgyo.domain.MemberUpdateVO;

public interface AcountMapper {
	
	//회원가입
	public int MemberInsert(MemberVO vo);
	//중복 아이디 검사
	public MemberVO MemberIdCheck(String userId);
	//로그인
	public MemberInfoVO MemberLogin(MemberLoginVO vo);
	//회원탈퇴
	public int MemberDelete(MemberLoginVO vo);
	//비밀번호 변경
	public int MemberUpdate(MemberUpdateVO vo);
}
