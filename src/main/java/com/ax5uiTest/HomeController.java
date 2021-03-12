package com.ax5uiTest;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ax5uiTest.file.service.FileService;

@Controller
public class HomeController {
	
	@Autowired
	FileService fileService;
	
	@RequestMapping("/")
	public String home() {
		return "index";
	}
	
	@ResponseBody
	@RequestMapping("/file/ajaxExcelRead")
	public List<List<JSONObject>> excelRead(MultipartHttpServletRequest multiRequest) {
		
		MultipartFile userFile = multiRequest.getFile("userFile");
		
		if(userFile == null || userFile.isEmpty()) {
			throw new RuntimeException("파일을 선택하지 않았습니다.");
		}
		
		
		List<List<JSONObject>> excelContent = new ArrayList<List<JSONObject>>();
		
		try {
			excelContent = fileService.readExcelSheetForAx5ui(userFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return excelContent;
	}
	
}
