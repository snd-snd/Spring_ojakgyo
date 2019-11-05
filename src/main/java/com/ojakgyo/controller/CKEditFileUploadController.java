package com.ojakgyo.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/file")
public class CKEditFileUploadController {

	
	@ResponseBody
	@PostMapping("/fileupload")
	public String imageUpload(@RequestParam MultipartFile uploadFile) {
		log.info("CKEditFileUploadController => 업로드 된 이미지");
		
		System.out.println(uploadFile);
		
		String uploadPath = "d:\\upload";
		File file = new File(uploadPath, uploadFile.getOriginalFilename());
		
		
		try {
			uploadFile.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		
		
		
		return null;
	}


}
