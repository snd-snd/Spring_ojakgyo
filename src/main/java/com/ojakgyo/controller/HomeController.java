package com.ojakgyo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

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
	
}
