package com.ojakgyo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.service.AcountService;

import lombok.extern.slf4j.Slf4j;


@SessionAttributes("login")
@Controller
@Slf4j
public class AcountController {
	
	@Autowired
	private AcountService acountservice;
	
	//로그인 폼 요청
	@GetMapping("/acount/login")
	public void loginGet() {
		log.info("로그인 폼 요청...");
	}
	
	@PostMapping("/acount/login")
// login.jsp에서 넘긴 값 가지고 오기
	public String loginPost(MemberVO vo, Model model) {
		log.info("로그인 요청...");
		// acountservice.Login() => MemberInfoVO 가 널이 아니라면
		LoginVO login = acountservice.Login(vo);

		if (login != null) // 로그인 성공(세션 처리 HttpSession, @SessionAttributes)
		{
			model.addAttribute("login", login);
			// 홈이 보여지게 만들어 주고
			return "redirect:/";
		} else {
			//rttr.addFlashAttribute("error", "아이디나 비밀번호를 확인해주세요");
			// LoginVO가 널이라면 로그인창으로 돌아가기
			return "redirect:/acount/login"; // forward(데이터를 살릴수있다) or sendRedirect
		}
	}
	
// 로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus session) {
		log.info("로그아웃 처리...");
		// 세션삭제
		// 세션이 있다면 세션삭제
		if (!session.isComplete()) {
			// 세션이 존재하면 false 존재하지 않으면 true
			session.setComplete();
		}
		return "redirect:/";
	}
	
// 회원탈퇴 페이지로
	@GetMapping("/acount/delete")
	public void leave() {
		log.info("회원탈퇴 폼 보여주기");
		// 회원탈퇴
		// 비밀번호를 입력할수 있는 폼 보여주기(leave.jsp)
	}
	
// 회원탈퇴
	@PostMapping("/acount/delete")
	public String DeletePost(MemberVO vo, SessionStatus status) {
		log.info("회원탈퇴 진행");

		if (acountservice.Delete(vo)) {
			// 세션해제
			// redirect
			status.setComplete();
			return "redirect:/";
		}
		return "redirect:/delete";
	}
	
	@GetMapping("/acount/join")
	public void insertGet() {
		log.info("회원가입 폼 가져오기");			
	}
	
// 회원가입
	@PostMapping("/acount/join")
	public String InsertPost(@ModelAttribute("members") MemberVO vo) { //
		// join.jsp 폼에서 넘긴 값 가져오기
		log.info("join 폼에서 넘긴 값 가져오기"+vo);
		
		if(vo.isPasswordEqualConfirmPassword()) {
			// 제대로 맞다면 
			// ~님 회원 가입을 완료했습니다. 메시지 보여주기
			int result = acountservice.Insert(vo);
			if(result>0)
				return "redirect:/acount/login";
		}
		// 비밀번호와 confirm_password가 다르면 회원가입 페이지로 돌려보냄
		return "forward:/acount/join";
	}
	
//중복아이디 검사
	@PostMapping("/checkId")
	@ResponseBody //리턴하는 값이 실제 문자열임
	public String checkId(String userId) {
		log.info("중복 아이디 검사"+userId);
		MemberVO vo = acountservice.CheckId(userId);
		
		if(vo != null)
			return "false";
		else
			return "true";
	}

//// 비밀번호변경
//// 비밀번호변경 폼 보여주기(changePwd.jsp)
//	@GetMapping("/changePwd")
//	public void changePwd(SessionStatus session) {
//		log.info("비밀번호 변경 폼 보여주기");
//		// 비밀번호 변경 폼 보여주기(changePwd.jsp)
//	}
//
//	@PostMapping("changePwd")
//	public String changePwd(@SessionAttribute("info") MemberInfoVO info/* ==SessionAttribute("info") */,
//			SessionStatus session, MemberUpdateVO vo) {
//		log.info("비밀번호 변경 폼 보여주기");
//
//		// DB비밀번호 변경
//		// 현재 비밀번호, 바꿀 비밀번호 두개
//
//		// 현재 비밀번호가 일치하는지 확인
//		MemberLoginVO login = new MemberLoginVO();
//		login.setUserId(info.getUserId());
//		login.setCurrent_password(vo.getCurrent_password());
//		MemberInfoVO info2 = acountservice.Login(login);
//		// 현재 비밀번호가 맞지 않는다면 돌려보내기(changePwd.jsp)
//		if (info2 != null) {
//			// 비밀번호가 맞다면 비밀번호 변경 해주기
//			// 비밀번호 변경이 완료되면 세션해제 해주고 redirect:/login 이동
//			if (vo.isPasswordEqualConfirmPassword()) {
//				vo.setUserid(info.getUserId());
//				if (acountservice.Update(vo)) {
//					session.setComplete();
//					return "redirect:/login";
//				}
//			}
//		}
//		return "redirect:/changePwd";
//	}	
}
