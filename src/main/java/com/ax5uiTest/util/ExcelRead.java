package com.ax5uiTest.util;

import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.json.simple.JSONObject;
import org.springframework.web.multipart.MultipartFile;

public class ExcelRead {
	
	/** 정해진 시트 인덱스만 읽는 방식 */
	public static List<List<String>> read(ReadOption readOption, int column){
		
		Workbook wb = FileType.getWorkbook(readOption.getFile());
		
		/* 읽을 시트값 변경 필요(0번부터 시작) */
		Sheet sheet = wb.getSheetAt(0);
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
		List<List<String>> result = new ArrayList<List<String>>();
		
		for (int rowIndex = readOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			row = sheet.getRow(rowIndex);
			
			//row != null은 꼭 넣어주어야 함(사용자가 입력한 Row가 아닐 때도 읽어들이는 오류가 발생)
			if(row != null) {
				numOfCells = column;
				
				List<String> list = new ArrayList<String>();
				
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					cell = row.getCell(cellIndex);
					
					list.add(CellRef.getValue(cell));
				}
				
				result.add(list);
			}
		}
		return result;
	}
	
	/** 시트 인덱스를 입력받아 읽을 수 있는 방식 */
	public static List<List<String>> readPlus(ReadOption readOption, int column, int sheetNumber){
		
		Workbook wb = FileType.getWorkbook(readOption.getFile());
		
		int numberOfSheets = wb.getNumberOfSheets();
		
		if(sheetNumber >= (numberOfSheets - 1)) {
			sheetNumber = numberOfSheets - 1;
		}else if(sheetNumber <= 0) {
			sheetNumber = 0;
		}
		
		Sheet sheet = wb.getSheetAt(sheetNumber);
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
		List<List<String>> result = new ArrayList<List<String>>();
		
		for (int rowIndex = readOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			row = sheet.getRow(rowIndex);
			
			//row != null은 꼭 넣어주어야 함(사용자가 입력한 Row가 아닐 때도 읽어들이는 오류가 발생)
			if(row != null) {
				numOfCells = column;
				
				List<String> list = new ArrayList<String>();
				
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					cell = row.getCell(cellIndex);
					
					list.add(CellRef.getValue(cell));
				}
				
				result.add(list);
			}
		}
		return result;
	}
	
	/** 정해진 시트 인덱스만 읽는 방식 */
	public static List<List<String>> specialRead(ReadOption readOption, int column){
	
		Workbook wb = FileType.getWorkbook(readOption.getFile());
		
		Sheet sheet = wb.getSheetAt(1);
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		int numOfCells = 0;
		
		Row row = null;
		Cell cell = null;
		
//		첫행, 마지막행, 첫열, 마지막열
		sheet.addMergedRegion(new CellRangeAddress(1, 1, 1, 2));
		
		List<List<String>> result = new ArrayList<List<String>>();
		
		for (int rowIndex = readOption.getStartRow() - 1; rowIndex < numOfRows; rowIndex++) {
			row = sheet.getRow(rowIndex);
			
			//row != null은 꼭 넣어주어야 함(사용자가 입력한 Row가 아닐 때도 읽어들이는 오류가 발생)
			if(row != null) {
				numOfCells = column;
				
				List<String> list = new ArrayList<String>();
				
				for(int cellIndex = 0; cellIndex < numOfCells; cellIndex++) {
					cell = row.getCell(cellIndex);
					
					list.add(CellRef.getValue(cell));
				}
				
				result.add(list);
			}
		}
		
		return result;
	}
	
	
	
	
	/*******************************************************/
	/*======================= ax5ui =======================*/
	/*******************************************************/
	
	/** setData  */
	public static List<List<JSONObject>> setData(MultipartFile file){
		
		Workbook wb = FileType.getWorkbook(file);
		
		int rowIndex = 0;
		int columnIndex = 0;
		
		Sheet sheet = wb.getSheetAt(0);
		
		int numOfRows = sheet.getPhysicalNumberOfRows();
		
		List<List<JSONObject>> result = new ArrayList<List<JSONObject>>();
		
		Row row;
		Cell cell;
		
		for (rowIndex = 0; rowIndex < numOfRows; rowIndex++) {
			row = sheet.getRow(rowIndex);
			
			if(row != null) {
				int lastCellIndex = row.getLastCellNum();
				
				List<JSONObject> list = new ArrayList<JSONObject>();
				
				for(columnIndex = 0; columnIndex < lastCellIndex; columnIndex++) {
					cell = row.getCell(columnIndex);
					
					if(rowIndex == 0) list.add(setDataNode(columnIndex, CellRef.getValue(cell), ""));
					else list.add(setDataNode(columnIndex, "", CellRef.getValue(cell)));
				}
				
				result.add(list);
			}
		}
		return result;
	}
	
	
	@SuppressWarnings("unchecked")
	public static JSONObject setDataNode(int cellIndex, String label, String content) {
		JSONObject obj = new JSONObject();
		
		int count = 0;
		int tempIndex = cellIndex;
		String cellKey = "";
		
		while(tempIndex >= 26) {
			count++;
			tempIndex = tempIndex - 26;
		}
		
		
		int characterNum = cellIndex % 26;
		
		while(count >= 0) {
			cellKey += Character.toString((char)(97 + characterNum));
			count--;
		}
		
		obj.put("key", cellKey);
		obj.put("label", label);
		obj.put("content", content);
		
		return obj;
	}
}