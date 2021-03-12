package com.ax5uiTest.file.service;

import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.web.multipart.MultipartFile;

public interface FileService {

	public List<List<JSONObject>> readExcelSheetForAx5ui(MultipartFile multiFile) throws Exception;
	
	public List<List<String>> readExcelSheet(MultipartFile multiFile, int columnCount) throws Exception;
	
}