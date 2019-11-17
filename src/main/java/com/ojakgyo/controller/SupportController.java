package com.ojakgyo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.LoginVO;
import com.ojakgyo.domain.MemberVO;
import com.ojakgyo.service.AccountService;
import com.ojakgyo.service.GroupService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/support")
public class SupportController {

	@Autowired
	GroupService service;
	
	@Autowired
	AccountService account_service;
	
	@GetMapping("/request")
	public void request(Model model, @SessionAttribute("login") LoginVO login) {
		log.info("SupportController => 요청 게시판으로 이동");

		List<GroupVO> myGroups = service.myGroups(login.getMember().getNickName());
		List<GroupVO> groups = service.listStatus(1);
		
		model.addAttribute("myGroups", myGroups);		
		model.addAttribute("groups", groups);
	}
	

	@ResponseBody
	@PostMapping("/new/{groupCode}")
	public ResponseEntity<String> register(@PathVariable("groupCode") String groupCode, @RequestBody MemberVO member){
		log.info("SupportController => 그룹 가입");		

		return service.register(groupCode, member)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}
}
