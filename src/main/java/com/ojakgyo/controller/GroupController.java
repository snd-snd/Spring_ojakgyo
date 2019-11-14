package com.ojakgyo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.service.GroupService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/groups")
public class GroupController {

	@Autowired
	GroupService service;

	@PostMapping("/new")
	public ResponseEntity<String> groupRegister(@RequestBody GroupVO group) {
		log.info("GroupController => 그룹 신청 요청으로 DB에 신청 내역을 저장");
		System.out.println(group);
		return service.groupRegister(group)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}
	
	@GetMapping("/{groupCode}")
	public ResponseEntity<GroupVO> groupRead(@PathVariable("groupCode") String groupCode) {
		log.info("GroupController => 그룹 신청 모달의 수정을 위해 그룹 신청 내역을 GET");
		
		GroupVO group = service.groupRead(groupCode);
		return new ResponseEntity<GroupVO>(group, HttpStatus.OK);
	}
	
	@PutMapping("/")
	public ResponseEntity<String> groupModify(@RequestBody GroupVO group) {
		log.info("GroupController => 그룹 신청 내역 변경");
		
		return service.groupModify(group)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}
	
	@DeleteMapping("/{groupCode}")
	public ResponseEntity<String> groupRemove(@PathVariable("groupCode") String groupCode) {
		log.info("GroupController => 그룹 신청 철회");
		
		return service.groupRemove(groupCode)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}
	
	@GetMapping("/status")
	public ResponseEntity<List<List<GroupVO>>>listStatus(int success, int pending, int failed){
		List<GroupVO> groups_success = service.listStatus(success);
		List<GroupVO> groups_pending = service.listStatus(pending);
		List<GroupVO> groups_failed = service.listStatus(failed);
		
		List<List<GroupVO>> groupsList = new ArrayList<List<GroupVO>>();
		
		groupsList.add(groups_success);
		groupsList.add(groups_pending);
		groupsList.add(groups_failed);
		
		return new ResponseEntity<List<List<GroupVO>>>(groupsList, HttpStatus.OK);
	} 
	
	
	@PatchMapping("/runrun")
	public ResponseEntity<String> statusChange(@RequestBody GroupVO group) {
		log.info("GroupController => 스테이터스 변경 및 프로시저이용 테이블 생성");
			
		return service.changeStatus(group)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}
	
}
