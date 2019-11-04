package com.ojakgyo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping(value="/board/*")
@Controller
public class ReviewController {

	
	@RequestMapping(value="review", method = RequestMethod.GET)
	public void bootstrapform() {
		
	}
}
