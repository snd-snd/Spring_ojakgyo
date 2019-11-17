package com.ojakgyo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ojakgyo.domain.BoardInfoVO;
import com.ojakgyo.domain.BoardVO;
import com.ojakgyo.domain.CriteriaVO;
import com.ojakgyo.domain.GroupVO;
import com.ojakgyo.domain.PageVO;
import com.ojakgyo.service.BoardService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/{groupCode}/board/")
public class BoardController {

	@Autowired
	BoardService service;
	
	@GetMapping("/list")
	public String board(@PathVariable("groupCode") String groupCode, CriteriaVO criteria, Model model) {
		log.info("BoardController => 그룹별 게시판 리스트 요청");
	
		criteria.setGroupCode(groupCode);
		BoardInfoVO info = service.list(criteria);
	  
		if (info != null) {
			model.addAttribute("info", info);
			model.addAttribute("page", new PageVO(criteria, service.totalCount(criteria)));
		}	 
		return "/board/list";
	}

	@GetMapping("/read/{bno}")
	public String read(@PathVariable("groupCode") String groupCode, @PathVariable("bno") int bno,
			@ModelAttribute("criteria") CriteriaVO criteria, Model model) {
		log.info("BoardController => 요청한 글 읽기");
		
		BoardVO board = service.read(groupCode, bno);
		
		if (board != null) {
			board.setGroupCode(groupCode);
			model.addAttribute("board", board);
		}
			
		return "/board/read";
	}
	
	@GetMapping("/register")
	public String register(@PathVariable("groupCode") String groupCode, Model model) {
		log.info("BoardController => 글쓰기 페이지로 이동");
			
		GroupVO group = new GroupVO();
		group.setGroupCode(groupCode);
		model.addAttribute("group", group);
		
		return "/board/register";
	}
	
	@PostMapping("/register")
	public String register(@PathVariable("groupCode") String groupCode, BoardVO board, RedirectAttributes rttr) {
		log.info("BoardController => 게시물 삽입");

		board.setGroupCode(groupCode);
		
		if(service.register(board)) {
			rttr.addFlashAttribute("result", board.getBno());
		}	
		
		return "redirect:/"+groupCode+"/board/list";
	}	
		
	
	@GetMapping("/modify/{bno}")
	public String modify(@PathVariable("groupCode") String groupCode, @PathVariable("bno") int bno,
			@ModelAttribute("criteria") CriteriaVO criteria, Model model) {
		log.info("BoardController => 요청한 글 수정");

		BoardVO board = service.read(groupCode, bno);
		
		if (board != null) {
			board.setGroupCode(groupCode);
			String temp = board.getContent();
			temp = temp.replace("\n","");//공백제거 
			temp = temp.replace("\r","");//공백제거 
			
			board.setContent(temp);
			model.addAttribute("board", board);
		}		

		return "/board/modify";
	}
	
	@PostMapping("/modify")
	public String modify(@PathVariable("groupCode") String groupCode, BoardVO board
			,CriteriaVO criteria, RedirectAttributes rttr) {
		log.info("BoardController => 요청한 글 수정");

		board.setGroupCode(groupCode);		
		if (service.modify(board)) {
			rttr.addAttribute("pageNum", criteria.getPageNum());
			rttr.addAttribute("amount", criteria.getAmount());
			rttr.addAttribute("type", criteria.getType());
			rttr.addAttribute("keyword", criteria.getKeyword());
		}	
						
		return "redirect:/"+groupCode+"/board/list";
	}
	
	@PostMapping("/remove")
	public String getRemove(@PathVariable("groupCode") String groupCode, int bno,
			@ModelAttribute("criteria") CriteriaVO criteria, RedirectAttributes rttr) {
		log.info("BoardController => 게시물 삭제");
		
		service.remove(groupCode, bno);
					
		rttr.addAttribute("pageNum", criteria.getPageNum());
		rttr.addAttribute("amount", criteria.getAmount());
		rttr.addAttribute("type", criteria.getType());
		rttr.addAttribute("keyword", criteria.getKeyword());
		
		return "redirect:/"+groupCode+"/board/list";
	}
	
}
