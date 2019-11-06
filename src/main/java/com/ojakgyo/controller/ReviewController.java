package com.ojakgyo.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.service.ReviewService;
import com.ojakgyo.service.ReviewServiceImpl;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping(value="/review/*")
@Controller
public class ReviewController {
	

	@Inject
	public ReviewService reviewservice;
	
	//사이드메뉴의 Review를 누르면 나오는 페이지 : 리뷰리스트/지도출력
	@RequestMapping(value="review", method = RequestMethod.GET)
	public void ReviewList(Model model) {		
		log.info("리뷰게시판/지도출력");
		List<BoardVO> list=reviewservice.ReviewList();
		System.out.println("1"+list);
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			System.out.println("2"+list);
		}
	}
}
