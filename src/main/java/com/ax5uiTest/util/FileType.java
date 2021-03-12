package com.ax5uiTest.util;

import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileType {
	
	public static Workbook getWorkbook(MultipartFile file) {
		
		Workbook wb = null;
		
		try {
			wb = WorkbookFactory.create(file.getInputStream());
		} catch(Exception e) {
			throw new IllegalArgumentException();
		}
	
		return wb;
	}
}