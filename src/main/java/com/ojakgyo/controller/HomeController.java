package com.ojakgyo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.service.AccountService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {

	@Autowired
	AccountService service;
	
	@GetMapping("/")
	public String home() {	
		log.info("HomeController => 인덱스 페이지 요청");
			
		return "/index";
	}
		
	@GetMapping("/notGroupMember")
	public String notGroupMember(RedirectAttributes rttr) {	
		log.info("HomeController => 접근 불가능한 그룹페이지 요청");
		rttr.addFlashAttribute("message", "해당그룹에 속하지 않아 접근할 수 없습니다.");
			
		return "redirect:/";
	}
	
	
}
