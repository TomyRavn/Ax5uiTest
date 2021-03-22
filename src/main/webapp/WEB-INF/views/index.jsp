<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
	<title>Home</title>
	
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5grid.css">
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5calendar.css">
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5formatter.css">
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5picker.css">
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5select.css">
	<link rel="stylesheet" type="text/css" href="/resources/ax5ui/dist/ax5ui.all.css">
	<script type="text/javascript" src="/resources/common/jquery-3.4.1.js"></script>
	<script type="text/javascript" src="/resources/ax5ui/dist/ax5core.min.js"></script>
	<script type="text/javascript" src="/resources/ax5ui/dist/ax5grid.min.js"></script>
	<script type="text/javascript" src="/resources/ax5ui/dist/ax5calendar.min.js"></script>
	<script type="text/javascript" src="/resources/ax5ui/dist/ax5formatter.min.js"></script>
	<script type="text/javascript" src="/resources/ax5ui/dist/ax5picker.min.js"></script>
	<script type="text/javascript" src="/resources/ax5ui/dist/ax5select.min.js"></script>
	<script type="text/javascript" src="/resources/ax5ui/dist/ax5ui.all.min.js"></script>
	<script type="text/javascript" src="/resources/sheetJS/dist/xlsx.full.min.js"></script>
	<script type="text/javascript" src="/resources/fileSaver/dist/FileSaver.min.js"></script>
	
	<style>
		table{
			text-align: center;
			border:1px solid gray;
		}
		td{
			padding:10px;
		}
	</style>
</head>
<body>
	<div>
		<div style="text-align:center;">
			<h1>엑셀 파일 업로드</h1>
		</div>
			<hr/>
			<br/>
		<div>
			<form id="fileForm" style="margin-left:42%;">
				<table>
					<colgroup>
						<col width="70%">
						<col width="30%">
					</colgroup>
					
					<thead>
						<tr>
							<td colspan="2"><h2>엑셀 파일 선택</h2></td>
						</tr>	
					</thead>
					<tbody>
						<tr>
							<td>
								<h3 style="display:inline;">선택한 파일</h3>
							</td>
							<td>
								<input type="file" id="userFile" name="userFile" accept=".xls, .xlsx, .csv" style="display:none;" onchange="previewExcelFile()"/>
								<label for="userFile" >
									<span style="border:1px solid black; padding:5px;">Upload</span>
								</label>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			
			<hr/>
			
			<div style="text-align:center;">
				<div>
					<h2>- 파일 미리보기 -</h2>
				</div>
				
				<button type="button" style="float:right;" onclick="downloadExcel()">Download</button>
				
				<br/><br/>
				
				<div data-ax5grid="first-grid"
         			style="height: 600px; display:none;"
         			id="gridDiv">
    			</div>
    			
    			<div style="padding:10px;">
    				<button class="btn" data-grid-control="row-add">row 추가</button>
    				<button class="btn" data-grid-control="row-remove">row 삭제</button>
    				<button class="btn" data-grid-control="row-update">row 수정</button>
    			</div>
    			<div style="padding:10px;">
    				<button class="btn" data-grid-control="column-add">column 추가</button>
    				<button class="btn" data-grid-control="column-remove">column 삭제</button>
    				<button class="btn" data-grid-control="column-update">column 수정</button>
    			</div>
			</div>
			
			<table id="gridTable" style="display:none;"></table>
		</div>
	</div>
	
	
	<script type="text/javascript">
		const firstGrid = new ax5.ui.grid();
		
		//setting formatter
		
		//formatter : number & editor : money 
		ax5.ui.grid.formatter["number"] = function(){
			let num = this.value;
			return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		//formatter : select 의 CD 값이 value로 표현되는 것을 변환
// 		ax5.ui.grid.formatter["select"] = function(){
// 			if(this.value == "indvd") return "개인";
// 			else if(this.value == "grp") return "단체";
// 			else return this.value;
// 		}
		
		//setGrid
// 		function gridInit(){
// 			//setConfig
// 			dataGrid.setConfig({
// 				target: $('[data-ax5grid="data-grid"]'),
// 				columns: [
// 					{key: "unitNm", label: "기관"},
// 					{label: "일정", 
// 						columns:[
// 							{key: "ethrmDt", label: "입실(시작일)"},
// 							{key: "lthrmDt", label: "퇴실(종료일)"}
// 						]
// 					},
// 					{key: "bsnssTypeNm", label: "사업별 구분"},
// 					{key: "nofprTypeNm", label: "개인/단체", formatter: "select",
// 						editor: {
// 							type:"select", config: {
// 								columnKeys:{
// 									optionValue: "CD", optionText: "NM"
// 								},
// 								options: [
// 									{CD: "indvd", NM : "개인"},
// 									{CD: "grp", NM : "단체"}
// 								]
// 							}
// 						}
// 					},
// 					{key: "grpNm", label: "단체명"},
// 					{key: "cstmrNm", label: "고객명"},
// 					{key: "netNofprCnt", label: "이용인원(명)", formatter: "number"},
// 					{label: "성별(명)",
// 						columns:[
// 							{key: "mNofprCnt", label: "남", formatter: "number"},
// 							{key: "fNofprCnt", label: "여", formatter: "number"}
// 						]
// 					},
// 					{label: "연령(명)",
// 						columns:[
// 							{key: "nofpr0Cnt", label: "10대 미만", formatter: "number"},
// 							{key: "nofpr10Cnt", label: "10대", formatter: "number"},
// 							{key: "nofpr20Cnt", label: "20대", formatter: "number"},
// 							{key: "nofpr30Cnt", label: "30대", formatter: "number"},
// 							{key: "nofpr40Cnt", label: "40대", formatter: "number"},
// 							{key: "nofpr50Cnt", label: "50대", formatter: "number"},
// 							{key: "nofpr60Cnt", label: "60대 이상", formatter: "number"}
// 						]
// 					},
// 					{key: "cstmrAddr", label: "지역(주소)"},
// 					{label: "연락처",
// 						columns:[
// 							{key: "cstmrCbleTlno", label: "유선전화"},
// 							{key: "cstmrWrlssTlno", label: "무선전화"},
// 							{key: "cstmrEmail", label: "전자우편"}
// 						]
// 					},
// 					{label: "이용실태",
// 						columns:[
// 							{key: "useCntNm", label: "이용횟수", formatter: "number"},
// 							{key: "infoAcqstPathNm", label: "정보취득경로"},
// 							{key: "usePrpsNm", label: "이용목적"},
// 							{key: "tfcmnNm", label: "교통수단"},
// 							{key: "chcWhyNm", label: "시설선택사유"}
// 						]
// 					}
// 				],
// 				showLineNumber: true,
// 				lineNumberColumnWidth: 40,
// 				header: {align: "center"},
// 				body: {align: "center"}
// 			});
	
		$(document).ready(function(){
			$('[data-grid-control]').click(function(){
				switch(this.getAttribute("data-grid-control")){
					
					case "row-add":
						firstGrid.addRow($.extend({}, firstGrid.list[Math.floor(Math.random() * firstGrid.list.length)], {__index:undefined}));
						break;
					case "row-remove":
						firstGrid.removeRow();
						break;
					case "row-update":
						break;
						
					case "column-add":
						firstGrid.addColumn({key:"test", label:"test field"});
						break;
					case "column-remove":
						firstGrid.removeColumn();
						break;
					case "column-update":
						break;
						
				}
			})
		})
	

// 		formatter 커스텀 세팅 
// 		ax5.ui.grid.formatter["test"] = function(){
			
// 			if(this.value != null){
// 				var test = this.value;
			
// 				if(test.length == 5){
// 					return test.substr(0, 1) + "/" + test.substr(1, 3) + "/" + test.substr(4);
// 				}else{
// 					return test;
// 				}
// 			}
// 		}
	
		function previewExcelFile(){
        	const excelFormData = new FormData();
        	excelFormData.append('userFile', $('#userFile')[0].files[0]);
        	
			$.ajax({
				url : '<c:url value="/file/ajaxExcelRead"/>',
				type : 'post',
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				data : excelFormData,
				success : function(data){
					$('#gridDiv').css('display', 'block');
					
					//첫 번째 열
					const configArr = [];
					
					for(var i = 0; i < data[0].length; i++){
						configArr[i] = {key: data[0][i].key, label: data[0][i].label};
						configArr[i].width = 150;
					}
					
					//컬럼 속성 추가
					configArr[0].width = 200;
// 					configArr[5].formatter = "test";

					//컬럼 에디터 설정(추후 java에서 셀을 판별 후 넣어줄 예정)
// 					configArr[0].editor = {type:"text"};
// 					configArr[1].editor = {type:"text"};
// 					configArr[2].editor = {type:"text"};
// 					configArr[3].editor = {type:"text"};
// 					configArr[5].editor = {type:"money"};
// 					configArr[6].editor = {type:"text"};
// 					configArr[7].editor = {type:"checkbox"};
// 					configArr[8].editor = {type:"checkbox"};
// 					configArr[9].editor = {type:"text"};
// 					configArr[10].editor = {type:"text"};
// 					configArr[11].editor = {type:"date"};
// 					configArr[12].editor = {type:"textarea"};
// 					configArr[13].editor = {type:"textarea"};

					//컬럼 분할
					delete configArr[4].key;	//delete 하지 않을 시 멀티 라인
					configArr[4].columns = [{key: data[0][0].key, label: data[0][0].label}, {key: data[0][1].key, label: data[0][1].label}];

					//====================== 1. JSON.parse ======================//
					//나머지 열
					const dataArr = new Array(data.length);
					
					for(var i = 1; i < data.length; i++){
						dataArr[i] = new Array(data[0].length);
					}
					
					for(var i = 1; i < data.length; i++){
						var str = '{';
						for(var j = 0; j < data[i].length; j++){
// 							str += '"'+data[i][j].key+'": ' + '"' + data[i][j].content.replace(/"/g, '').replace(/,/g, ' ').replace(/'/g, '') +'"';
							str += '"'+data[i][j].key+'": ' + '"' + data[i][j].content.replaceAll('"', '').replaceAll(',', '') +'"';
							if(data[i].length-1 != j){
								str += ',';
							}
						}
						str += '}';
						
// 						console.log(str);

						dataArr[i] = JSON.parse(str);
					}
					//================================================//
					
					
					//====================== 2. 객체 ======================//
					const dataList = [];
					
					for(var i = 1; i < data.length; i++){
						dataList[i] = new Object();
					}
					
					for(var i = 1; i < data.length; i++){
						for(var j = 0; j < data[i].length; j++){
// 							dataList[i] = Object.fromEntries([[data[i][j].key, data[i][j].content]]);
							dataList[i][data[i][j].key] = data[i][j].content;
						}
					}
					//================================================//
					
					firstGrid.setConfig({
						//ax5grid 설정 타겟
		            	target: $('[data-ax5grid="first-grid"]'),
		            	//컬럼명
		            	columns: configArr,
		            	//열 번호 출력 여부
		            	showLineNumber: true,
		            	//열 체크박스 출력 여부
		            	showRowSelector: true,
		            	//체크박스 여러 개 선택 가능 여부
		            	multipleSelect: true,
		            	//열 번호 컬럼 너비
		            	lineNumberColumnWidth: 40,
		            	//열 체크박스 너비(체크박스 크기도 같이 커짐)
		            	rowSelectorColumnWidth: 25,
		            	//정렬 기능 설정(오름차순, 내림차순, off)
		            	sortable: true,
		            	//정렬 여러 개 동시 가능 여부 설정
		            	multiSort: false,
		            	//첫번째 열(header) 부분 설정
		            	header: {
		                    align: "center",
		                    columnHeight: 40
		                    
		                    //전체선택 숨기기
// 		                    selector: false
		                },
		                //body 부분 설정
		                body:{
								align: "left",
								columnHeight: 50,
								onClick: function () {
									//해당 셀 선택을 통한 속성 조회 가능
// 		                          console.log(this);
									//열 선택 처리
// 		                          this.self.select(this.dindex);
								}
		                },
		                //틀 고정
		                frozenColumnIndex : 2,
// 		                frozenRowIndex : 2
						
						//페이지네이션
// 						page: { 
// 							navigationItemCount: 9, 
// 							height: 30, 
// 							display: true, 
// 							firstIcon: '|<', 
// 							prevIcon: '<', 
// 							nextIcon: '>', 
// 							lastIcon: '>|', 
// 							onChange: function () { 
// 								search(this.page.selectPage, data.length. dataList); 
// 							}
// 						}
		        	});
					
// 					firstGrid.setData(dataArr);
					
					firstGrid.setData({
						list : dataList,
						page : {
							currentPage : 0,
							pageSize : 10,
							totalElements: data.length,
							totalPages : data.length / 10
						}
					});
				},
				error : function(){
					alert('시스템 오류가 발생하였습니다.');
				}
			});
		}  
	
		
		function downloadExcel(){
			//1. ax5ui export Excel
// 			firstGrid.exportExcel("grid-to-excel.xls");	//ax5ui 기본 export

			//2. Sheet JS export Excel
			var gridTableHtml = firstGrid.exportExcel();	//인자를 적어주지 않으면, table 태그 export
			
			$('#gridTable').html(gridTableHtml);
			
			var wb = XLSX.utils.table_to_book(document.getElementById('gridTable'), {sheet:"sheet1", raw:true});
			XLSX.writeFile(wb, ('test.xlsx'));
			
			//3. Sheet JS Demo export Excel
// 			var wb = XLSX.utils.table_to_sheet( gridTable );
// 			wb.SheetNames.push("Test Sheet2");
// 			wb.Sheets["Test Sheet2"] = ws2;
			
// 			var wbout = XLSX.write(wb, {bookType:'xlsx', bookSST:true, type:'binary'});
			
// 			function s2ab(s){
// 				var buf = new ArrayBuffer(s.length);
// 				var view = new Uint8Array(buf);
// 				for(var i = 0; i < s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
// 				return buf;
// 			}
			
// 			saveAs(new Blob([s2ab(wbout)], {type:"application/octet-stream"}), "test.xlsx");
		}
 		
		//setConfig 예제
// 		const configList = [{key : "a", label : "조성년도"}, {key : "b", label : "사업명"}];
// 		firstGid.setConfig({
// 			target: $('[data-ax5grid="first-grid"]'),
//         	columns: configList
// 		});
       
       	//setData 예제 	
//     	const gridList = '{"b":"2016", "a":"1", "h":"1,000", "d":"평창군청"}';
//      const gridList2 = {a:'2', c:"구암로 외 3개소 무장애나눔길 조성"};
//      const totalList = [gridList, gridList2];
        	
//      firstGrid.setData(totalList);

		
		//자체 pagination 함수(현재 안됨)
// 		function search(_pageNo, totalLength, objectList){
			
// 			firstGrid.setData({
// 				list : objectList,
// 				page : {
// 					currentPage : _pageNo,
// 					pageSize : 10,
// 					totalElements: totalLength,
// 					totalPages : totalLength / 10
// 				}
// 			});
// 		}
	</script>
</body>
</html>
