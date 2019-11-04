package com.ojakgyo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ojakgyo.domain.GroupVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/support")
public class SupportController {

	@GetMapping("/request")
	public void request(Model model) {
		log.info("SupportController => 요청 게시판으로 이동");
		
		List<GroupVO> groups = new ArrayList<GroupVO>();
		model.addAttribute("groups", groups);
		
	}
}
