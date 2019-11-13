package com.ojakgyo.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.PageVO;
import com.ojakgyo.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping(value = "/review/*")
@Controller
public class ReviewController {

	@Inject
	public ReviewService reviewservice;

	// 사이드메뉴의 Review를 누르면 나오는 페이지 : 리뷰리스트/지도출력
	@RequestMapping(value = "reviewlist", method = RequestMethod.GET)
	public void ReviewList(Model model, CriteriaVO cri) {
		log.info("리뷰게시판/지도출력");
		List<BoardVO> list = reviewservice.ReviewList(cri);
		if (!list.isEmpty()) {
			model.addAttribute("list", list);
			model.addAttribute("pageVO", new PageVO(cri, reviewservice.totalCnt(cri)));
		}
	}

	// 리뷰글 한개읽어오기, reviewupdate폼불러오기
	@GetMapping(value = { "reviewread", "reviewupdate" })
	public void ReviewReadOne(@RequestParam int bno, Model model, @ModelAttribute("cri") CriteriaVO cri) {
		log.info("ReviewReadOne요청 " + ", bno : " + bno + ", cri : " + cri);
		BoardVO vo = reviewservice.ReviewReadOne(bno);
		model.addAttribute("vo", vo);
	}

	// 리뷰글 등록폼불러오기
	@GetMapping("reviewinsert")
	public String insertform() {
		return "review/reviewinsert";
	}

	// 리뷰글 등록
	@PostMapping("reviewinsert")
	public String ReviewInsert(BoardVO vo, RedirectAttributes rttr) {
		reviewservice.ReviewInsert(vo);
		if (vo != null) {
			rttr.addFlashAttribute("result", vo.getBno());
			return "redirect:reviewlist";
		} else {
			return "reviewinsert";
		}
	}

	// 리뷰글 수정
	@PostMapping("reviewupdate")
	public String ReviewUpdate(BoardVO vo, CriteriaVO cri,RedirectAttributes rttr) {
		log.info("리뷰글수정"+cri);
		reviewservice.ReviewUpdate(vo);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:reviewlist";
	}

	// 리뷰글 삭제
	@PostMapping("reviewdelete")
	public String ReviewDelete(int bno, CriteriaVO cri,RedirectAttributes rttr) {
		log.info("리뷰글삭제");
		reviewservice.ReviewDelete(bno);
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		return "redirect:reviewlist";
	}

}
