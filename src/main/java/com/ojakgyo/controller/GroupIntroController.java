package com.ojakgyo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/introduction")
public class GroupIntroController {
	
	@GetMapping("/intro")
	public void intro() {
		
	}
}