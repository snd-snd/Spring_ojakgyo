package com.ojakgyo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.service.AccountService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AccountController {
	
	@Autowired
	private AccountService accountservice;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


	// 로그인 폼 요청
	@GetMapping("/account/login")
	public void loginGet() {
		log.info("로그인 폼 요청...");
	}
	
	@GetMapping("/account/needLogin")
	public String needLoginGet(RedirectAttributes rttr) {
		log.info("로그인 후 이용 요청...");
		rttr.addFlashAttribute("message", "로그인 후 이용가능합니다.");
		
		return "redirect:/account/login";
	}

	@PostMapping("/account/login")
// login.jsp에서 넘긴 값 가지고 오기
	public String loginPost(MemberVO vo, HttpSession session) {
		log.info("로그인 요청...");		
		
		MemberVO vo2 = accountservice.read(vo.getUserId());
		String encPassword = vo2.getUserPw();

		if (!passwordEncoder.matches(vo.getUserPw(), encPassword)) {
			// rttr.addFlashAttribute("error", "아이디나 비밀번호를 확인해주세요");
	    	// LoginVO가 널이라면 로그인창으로 돌아가기
			return "redirect:/account/login";// forward(데이터를 살릴수있다) or sendRedirect
	    } else {
	    	LoginVO login = accountservice.Login(vo2);
	    	// accountservice.Login() => MemberVO 가 널이 아니라면

	    	session.setMaxInactiveInterval(1000*60*60*24*10);
	    	session.setAttribute("login", login);
	    		// 홈이 보여지게 만들어 주고
	    	return "redirect:/";	    	
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
			String encPassword = passwordEncoder.encode(vo.getUserPw());
			vo.setUserPw(encPassword);
			// 제대로 맞다면
			// ~님 회원 가입을 완료했습니다. 메시지 보여주기
			int result = accountservice.Insert(vo);
			if (result > 0)
				return "redirect:/account/login";
		}
		// 비밀번호와 confirm_password가 다르면 index 페이지로 돌려보냄
		return "redirect:/";
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
	public String update(MemberVO vo, HttpSession session) {
		log.info("update 폼에서 넘긴 값 가져오기.." + vo);
		
		String encPassword = passwordEncoder.encode(vo.getConfirm_password());
		vo.setConfirm_password(encPassword);
		
		System.out.println(vo);
		boolean result = accountservice.Update(vo);
		if (result == true) {
			vo.setUserPw(vo.getConfirm_password());
			System.out.println(vo);
			LoginVO login = accountservice.Login(vo);
	    	session.setAttribute("login", login);
		}
		
		return "redirect:/";
	}
	
	
	@GetMapping("/account/complete")
	public String complete(@SessionAttribute("login") LoginVO login, HttpSession session) {	
		log.info("HomeController => 그룹가입 후 인덱스페이지로 이동");

		MemberVO member = accountservice.CheckId(login.getMember().getUserId());
		login.setMember(member);
    	session.setAttribute("login", login);

		return "redirect:/";
	}
}