package com.ax5uiTest.util;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.RegionUtil;

public class ExcelWrite {
	
	/**
	 * 첫 행을 구성
	 *  - 파라미터 : 셀 정보를 담는 excelVO, 해당 row의 첫 시작이 몇 번째 셀인지 알려주기 위한 cellNum
	 * */
	public void rowInit(ExcelVO excelVO, int cellNum) {
		excelVO.setRowNum(excelVO.getRowNum() + 1);
		excelVO.setCellNum(cellNum);
		excelVO.setRow(excelVO.getSheet().createRow(excelVO.getRowNum()));
	}
	
	
	/**
	 * 행을 추가
	 *  - 파라미터 : 셀 정보 담을 excelVO, 병합을 위한 row/cellMerge, 셀의 내용을 담을 val
	 */
	public void addNewCell(ExcelVO excelVO, int rowMerge, int cellMerge, String val) {
		//rowNum과 cellNum은 옮겨진 rowNum과 cellNum의 정보를 받아와 반영하기 위함
		int rowNum = excelVO.getRowNum();
		int cellNum = excelVO.getCellNum();
		
		excelVO.getSheet().addMergedRegion(new CellRangeAddress(rowNum, rowNum+rowMerge, cellNum, cellNum+cellMerge));
		excelVO.setCell(excelVO.getRow().createCell(excelVO.getCellNum()));
		
		if(excelVO.getStyle() != null) {
			excelVO.getCell().setCellStyle(excelVO.getStyle());
		}
		
		excelVO.getCell().setCellValue(val);
		
		excelVO.setCellNum(excelVO.getCellNum() + cellMerge + 1);
	}
	
	public void addNewCell(ExcelVO excelVO, String val) {

		excelVO.setCell(excelVO.getRow().createCell(excelVO.getCellNum()));
		
		if(excelVO.getStyle() != null) {
			excelVO.getCell().setCellStyle(excelVO.getStyle());
		}
		
		excelVO.getCell().setCellValue(val);
		
		excelVO.setCellNum(excelVO.getCellNum() + 1);
	}
	
	public void addNewCell(ExcelVO excelVO, int cellType) {

		excelVO.setCell(excelVO.getRow().createCell(excelVO.getCellNum()));
		
		if(excelVO.getStyle() != null) {
			excelVO.getCell().setCellStyle(excelVO.getStyle());
		}
		
		excelVO.getCell().setCellType(cellType);
		
		excelVO.setCellNum(excelVO.getCellNum() + 1);
	}
	
	public void addCellNum(ExcelVO excelVO) {
		excelVO.setCellNum(excelVO.getCellNum() + 1);
	}
	
	public void addRowNum(ExcelVO excelVO) {
		excelVO.setRowNum(excelVO.getRowNum() + 1);
	}
	
	//병합된 셀 테두리 스타일 적용
	public void setBordersToMergedCells(ExcelVO excelVO) {
	       int numMerged = excelVO.getSheet().getNumMergedRegions();
	       for (int i = 0; i < numMerged; i++) {
	           CellRangeAddress mergedRegions =  excelVO.getSheet().getMergedRegion(i);
	           RegionUtil.setBorderLeft(CellStyle.BORDER_THIN, mergedRegions, excelVO.getSheet(), excelVO.getWb());
	           RegionUtil.setBorderRight(CellStyle.BORDER_THIN, mergedRegions, excelVO.getSheet(), excelVO.getWb());
	           RegionUtil.setBorderTop(CellStyle.BORDER_THIN, mergedRegions, excelVO.getSheet(), excelVO.getWb());
	           RegionUtil.setBorderBottom(CellStyle.BORDER_THIN, mergedRegions, excelVO.getSheet(), excelVO.getWb());
	       }
	}
}