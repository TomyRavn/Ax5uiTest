package com.ax5uiTest.file.service;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ax5uiTest.util.ExcelRead;
import com.ax5uiTest.util.ReadOption;

@Service("FileService")
public class FileServiceImpl implements FileService {
	
	@Override
	public List<List<JSONObject>> readExcelSheetForAx5ui(MultipartFile multiFile) throws Exception {
		List<List<JSONObject>> excelContent = new ArrayList<List<JSONObject>>();
		
		excelContent = ExcelRead.setData(multiFile);

		return excelContent;
	}
	
	@Override
	public List<List<String>> readExcelSheet(MultipartFile multiFile, int columnCount) throws Exception {
		ReadOption readOption = new ReadOption();

		readOption.setFile(multiFile);
		readOption.setStartRow(1);

		List<List<String>> excelContent = new ArrayList<List<String>>();
		
		/* '컬럼 갯수 변경'이 필요한 곳*/
		excelContent = ExcelRead.read(readOption, columnCount);

		return excelContent;
	}
}