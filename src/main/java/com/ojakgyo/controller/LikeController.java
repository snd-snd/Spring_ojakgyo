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

import com.ojakgyo.domain.LikeVO;
import com.ojakgyo.service.LikeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/{groupCode}/like/")
public class LikeController {

	@Autowired
	LikeService service;
	
	@GetMapping("/{bno}")
	public ResponseEntity<Integer> likeTotal(@PathVariable("groupCode") String groupCode, @PathVariable("bno") int bno) {
		log.info("LikeController => 게시글의 좋아요 개수 조회");
				
		return new ResponseEntity<Integer>(service.likeTotal(groupCode, bno), HttpStatus.OK);
	}
	
	@PostMapping("/likeCheck")
	public ResponseEntity<Boolean> search(@PathVariable("groupCode") String groupCode, @RequestBody LikeVO like) {
		log.info("LikeController => 좋아요 체크여부");
		like.setGroupCode(groupCode);
		
		return service.likeCheck(like) == 1
				? new ResponseEntity<>(true, HttpStatus.OK)
				: new ResponseEntity<>(false, HttpStatus.OK);
	}
	
	@PostMapping("/action")
	public ResponseEntity<String> action(@PathVariable("groupCode") String groupCode, @RequestBody LikeVO like) {
		log.info("LikeController => 게시글 좋아요");
		like.setGroupCode(groupCode);
		
		return service.action(like)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}
	
	@DeleteMapping("/cancel")
	public ResponseEntity<String> cancel(@PathVariable("groupCode") String groupCode, @RequestBody LikeVO like) {
		log.info("LikeController => 게시글 좋아요 취소");
		like.setGroupCode(groupCode);
		
		return service.cancel(like)
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}
}
