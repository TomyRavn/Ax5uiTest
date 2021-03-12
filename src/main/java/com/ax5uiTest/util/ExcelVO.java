package com.ax5uiTest.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellStyle;

public class ExcelVO {
	
	HSSFWorkbook wb = null;
	HSSFSheet sheet = null;
	HSSFRow row = null;
	HSSFCell cell = null;
	CellStyle style = null;
	
	int rowNum = -1;
	int cellNum = 0;
	
	
	public HSSFWorkbook getWb() {
		return wb;
	}
	public void setWb(HSSFWorkbook wb) {
		this.wb = wb;
	}
	public HSSFSheet getSheet() {
		return sheet;
	}
	public void setSheet(HSSFSheet sheet) {
		this.sheet = sheet;
	}
	public HSSFRow getRow() {
		return row;
	}
	public void setRow(HSSFRow row) {
		this.row = row;
	}
	public HSSFCell getCell() {
		return cell;
	}
	public void setCell(HSSFCell cell) {
		this.cell = cell;
	}
	public CellStyle getStyle() {
		return style;
	}
	public void setStyle(CellStyle style) {
		this.style = style;
	}
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	public int getCellNum() {
		return cellNum;
	}
	public void setCellNum(int cellNum) {
		this.cellNum = cellNum;
	}
	
}