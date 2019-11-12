package com.ojakgyo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.service.AccountService;

import lombok.extern.slf4j.Slf4j;

@SessionAttributes("login")
@Controller
@Slf4j
public class AccountController {

	@Autowired
	private AccountService accountservice;

	// 로그인 폼 요청
	@GetMapping("/account/login")
	public void loginGet() {
		log.info("로그인 폼 요청...");
	}

	@PostMapping("/account/login")
// login.jsp에서 넘긴 값 가지고 오기
	public String loginPost(MemberVO vo, Model model) {
		log.info("로그인 요청...");
		// accountservice.Login() => MemberInfoVO 가 널이 아니라면
		LoginVO login = accountservice.Login(vo);

		if (login != null) // 로그인 성공(세션 처리 HttpSession, @SessionAttributes)
		{
			model.addAttribute("login", login);
			// 홈이 보여지게 만들어 주고
			return "redirect:/";
		} else {
			// rttr.addFlashAttribute("error", "아이디나 비밀번호를 확인해주세요");
			// LoginVO가 널이라면 로그인창으로 돌아가기
			return "redirect:/account/login"; // forward(데이터를 살릴수있다) or sendRedirect
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
	@GetMapping("/account/delete")
	public void leave() {
		log.info("회원탈퇴 폼 보여주기");
		// 회원탈퇴
		// 비밀번호를 입력할수 있는 폼 보여주기(leave.jsp)
	}

// 회원탈퇴
	@PostMapping("/account/delete")
	public String DeletePost(MemberVO vo, SessionStatus status) {
		log.info("회원탈퇴 진행");

		if (accountservice.Delete(vo)) {
			// 세션해제
			// redirect
			status.setComplete();
			return "redirect:/";
		}
		return "redirect:/delete";
	}

	@GetMapping("/account/join")
	public void insertGet() {
		log.info("회원가입 폼 가져오기");
	}

// 회원가입
	@PostMapping("/account/join")
	public String InsertPost(@ModelAttribute("members") MemberVO vo) { //
		// join.jsp 폼에서 넘긴 값 가져오기
		log.info("join 폼에서 넘긴 값 가져오기" + vo);

		if (vo.isPasswordEqualConfirmPassword()) {
			// 제대로 맞다면
			// ~님 회원 가입을 완료했습니다. 메시지 보여주기
			int result = accountservice.Insert(vo);
			if (result > 0)
				return "redirect:/account/login";
		}
		// 비밀번호와 confirm_password가 다르면 회원가입 페이지로 돌려보냄
		return "forward:/account/join";
	}

//중복아이디 검사
	@PostMapping("/checkId")
	@ResponseBody // 리턴하는 값이 실제 문자열임
	public String checkId(String userId) {
		log.info("중복 아이디 검사" + userId);
		MemberVO vo = accountservice.CheckId(userId);

		if (vo != null)
			return "false";
		else
			return "true";
	}
	
//중복닉네임 검사
	@PostMapping("/checkNickName")
	@ResponseBody // 리턴하는 값이 실제 문자열임
	public String checkNickName(String nickName) {
		log.info("중복 닉네임 검사" + nickName);
		MemberVO vo = accountservice.CheckNickName(nickName);
		
		if (vo != null)
			return "false";
		else
			return "true";
	}

// 회원수정
// 회원수정 폼 보여주기(update.jsp)
	@GetMapping("/account/update")
	public void updateGet(SessionStatus session) {
		log.info("회원수정 폼 보여주기");
		// 회원수정 폼 보여주기(update.jsp)
	}

	@PostMapping("/account/update")
	public String update(Model model, MemberVO vo) {
		log.info("update 폼에서 넘긴 값 가져오기.." + vo);
		
		if (accountservice.Update(vo)) {
			LoginVO login = accountservice.Login(vo);		
			model.addAttribute("login", login);
		}
		
		return "redirect:/";
	}
}