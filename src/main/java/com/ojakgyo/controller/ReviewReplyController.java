package com.ojakgyo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.ReplyPageVO;
import com.ojakgyo.domain.ReplyVO;
import com.ojakgyo.service.ReviewReplyService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/replies")
public class ReviewReplyController {

	@Autowired
	private ReviewReplyService reviewreplyservice;

	// 댓글리스트
	@GetMapping(value = "/pages/{bno}/{page}")
	public ResponseEntity<ReplyPageVO> ReviewReplyList(@PathVariable("bno") int bno, @PathVariable("page") int page) {
		log.info("리뷰댓글리스트");
		CriteriaVO criteria = new CriteriaVO(page, 10);
		return new ResponseEntity<ReplyPageVO>(reviewreplyservice.ReviewReplyList(bno, criteria), HttpStatus.OK);
	}

	// 댓글등록
	@PostMapping("/new")
	public ResponseEntity<String> ReviewReplyInsert(@RequestBody ReplyVO vo) {
		log.info("리뷰댓글등록");
		return reviewreplyservice.ReviewReplyInsert(vo) ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>("fail", HttpStatus.BAD_REQUEST);
	}

	// 댓글삭제
	@DeleteMapping(value = "/{rno}")
	public ResponseEntity<String> ReviewReplyDelete(@PathVariable("rno") int rno) {
		log.info("리뷰댓글삭제");
		reviewreplyservice.ReviewReplyDelete(rno);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	// 한개읽어오기
	@GetMapping(value = "/{rno}")
	public ResponseEntity<ReplyVO> ReviewReplyGet(@PathVariable("rno") int rno, Model model) {
		log.info("리뷰댓글 조회");
		ReplyVO vo=reviewreplyservice.ReviewReplyRead(rno);
		model.addAttribute("replyvo", vo);
		return new ResponseEntity<>(reviewreplyservice.ReviewReplyRead(rno), HttpStatus.OK);
	}

	// 수정
	@RequestMapping(value = "/{rno}", method = { RequestMethod.PATCH, RequestMethod.PUT })
	public ResponseEntity<String> ReviewReplyUpdate(@PathVariable("rno") int rno, @RequestBody ReplyVO vo) {
		log.info("리뷰댓글 수정");
		vo.setRno(rno);
		return reviewreplyservice.ReviewReplyUpdate(vo) ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}

}
