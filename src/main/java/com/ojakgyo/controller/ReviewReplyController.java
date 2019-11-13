package com.ojakgyo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;
import com.ojakgyo.service.ReviewReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/reply")
public class ReviewReplyController {

	@Autowired
	private ReviewReplyService reviewservice;
	
	@GetMapping(value="/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageVO> ReviewReplyList(@PathVariable("bno") int bno,@PathVariable("page") int page){
		log.info("댓글리스트");
		CriteriaVO criteria = new CriteriaVO(page,10);
		return new ResponseEntity<ReplyPageVO>(reviewservice.ReviewReplyList(bno, criteria), HttpStatus.OK);
	}
	
	@PostMapping("/new")
	public ResponseEntity<String> ReviewReplyInsert(@RequestBody ReplyVO vo){
		log.info("댓글등록");
		return reviewservice.ReviewReplyInsert(vo)?new ResponseEntity<String>("success",HttpStatus.OK):
			new ResponseEntity<String>("fail",HttpStatus.BAD_REQUEST);
	}
	
	
	@DeleteMapping(value="/{rno}")
	public ResponseEntity<String> delete(@PathVariable("rno") int rno){
		log.info("댓글삭제");
		reviewservice.ReviewReplyDelete(rno);
		return new ResponseEntity<String>("success",HttpStatus.OK);
	}
	
	
}
