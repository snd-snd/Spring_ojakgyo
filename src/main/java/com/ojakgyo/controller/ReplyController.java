package com.ojakgyo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;
import com.ojakgyo.service.ReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/{groupCode}/reply/")
public class ReplyController {

	@Autowired
	ReplyService service;
		
	@GetMapping("/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageVO> getList(@PathVariable("groupCode") String groupCode,
			@PathVariable("bno") int bno,@PathVariable("page") int page){
		log.info("ReplyController => 댓글 리스트 요청");
		CriteriaVO criteria = new CriteriaVO(page, 5);
		
		return new ResponseEntity<>(service.list(groupCode, criteria, bno), HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}")
	public ResponseEntity<ReplyVO> get(@PathVariable("groupCode") String groupCode, @PathVariable("rno") int rno){
		log.info("ReplyController => 댓글 하나 요청");
		
		return new ResponseEntity<ReplyVO>(service.read(groupCode, rno), HttpStatus.OK);
	}
	
	@PostMapping("/new")
	public ResponseEntity<String> create(@PathVariable("groupCode") String groupCode, @RequestBody ReplyVO reply){
		log.info("ReplyController => 새로운 댓글 삽입 요청");
		
		reply.setGroupCode(groupCode);
		return service.register(reply)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); 
	}
	
	@PutMapping(value = "/{rno}")
	public ResponseEntity<String> modify(@PathVariable("groupCode") String groupCode, @PathVariable("rno") int rno, @RequestBody ReplyVO reply){
		log.info("ReplyController => 댓글 수정");
		
		return service.modify(groupCode, reply)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); 
	}
	
	@DeleteMapping(value = "/{rno}")
	public ResponseEntity<String> remove(@PathVariable("groupCode") String groupCode, @PathVariable("rno") int rno){
		log.info("ReplyController ==> 댓글 삭제");

		return service.remove(groupCode, rno)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST); 
	}
	
}
