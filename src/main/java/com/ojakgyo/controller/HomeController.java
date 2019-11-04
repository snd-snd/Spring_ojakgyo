package com.ojakgyo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.LoginVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@SessionAttributes("login")
public class HomeController {

	@GetMapping("/")
	public String home(Model model, LoginVO login) {
		log.info("인덱스 페이지 요청");
		List<GroupVO> list = new ArrayList<GroupVO>();

		GroupVO group1 = new GroupVO();
		group1.setGroupCode("11");
		group1.setGroupName("복덕방");
		list.add(group1);
		GroupVO group2 = new GroupVO();
		group2.setGroupCode("22");
		group2.setGroupName("개발자 모임");
		list.add(group2);
		GroupVO group3 = new GroupVO();
		group3.setGroupCode("33");
		group3.setGroupName("호구조사");
		list.add(group3);
		
		login.setGroups(list);
		
		model.addAttribute("login", login);
		return "/index";
	}
	
}
