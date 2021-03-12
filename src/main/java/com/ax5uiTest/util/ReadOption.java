package com.ax5uiTest.util;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ReadOption {
	
	/** 엑셀 파일 */
	private MultipartFile file;
	
	/** 추출할 컬럼명 */
	private List<String> outputColumns;
	
	/** 추출을 시작할 행 번호 */
	private int startRow;

	
	/** getter, setter */
	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public List<String> getOutputColumns() {
		return outputColumns;
	}

	public void setOutputColumns(List<String> outputColumns) {
		this.outputColumns = outputColumns;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	
}