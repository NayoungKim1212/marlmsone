<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강의목록</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	var pageSize = 10;		//한 페이지당 몇개 보여줄 지
	var pageBlockSize = 5;	//페이지 당 번호

	/** OnLoad event */
	$(function() {

		//강사의 시험출제 목록 조회s
		fSearch_tutLecList();
		
		//버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		$("#start_datepicker").datepicker({minDate: 0});
		$("#end_datepicker").datepicker({minDate: 0});
	});
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnGenerateTest':
				fGenerate_test();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});		
	}
	
	/** 강사의 시험출제 목록 조회 */
	function fSearch_tutLecList(currentPage){
		
		console.log("currentPage : " + currentPage);
		currentPage = currentPage || 1;	// undefined 일 때 1값 나오게 설정
		var searchKey = $("#searchKey").val();
		
		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {						
			currentPage : currentPage,
			pageSize : pageSize,
			searchKey : searchKey,
		};
		
		var callback = function(response) {
			fCallback_tutTestList(response, currentPage);
		};
		
		callAjax("/tut/tutTestList.do", "post", "text", false, param, callback);
	}	
	
	/** 강사의 시험출제 목록 조회 콜백 함수 */
	function fCallback_tutTestList(response, currentPage) {
		
		console.log("fCallback_tutTestList's response : " + response);
		
		// 나의 시험응시 목록 초기화 후 생성
		$("#tutTestListBody").empty().append(response);
		
		// 나의 시험응시 목록 총 개수 추출
		var tutTestListCnt = $("#listCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml( currentPage, 
												tutTestListCnt, 
												pageSize, 
												pageBlockSize, 
												'fSearch_tutLecList' );
		console.log(paginationHtml);		
		$("#tutTestPagination").empty().append( paginationHtml );		
		
		// 나의 시험응시 목록 현재 페이지 임시 저장
		$("#tmp_currentPage").val(currentPage);
	}
	
	/** 시험문제 출제 모달 실행 */
	function fPopModal_generateTest(lec_id, lec_name, lec_type_id, lec_type_name) {
		
		console.log("lec_id : " + lec_id);
		console.log("lec_name : " + lec_name);
		console.log("lec_type_id : " + lec_type_id);
		console.log("lec_type_name : " + lec_type_name);
		
		// 시험문제 출제 모달 초기화 
		fInit_generateTest(lec_id, lec_name, lec_type_id, lec_type_name);
		//mfSearch_lecList(lec_id, lec_name, lec_type_name);
		
		// 모달 팝업
		gfModalPop("#ModalPop_generateTest");
	}
	
	function fInit_generateTest(lec_id, lec_name, lec_type_id, lec_type_name) {

		$("#lecId").val(lec_id);
		$("#lecName").val(lec_name);
		$("#lecTypeId").val(lec_type_id);
		$("#lecTypeName").val(lec_type_name);
		$("#testName").val("");
		$("#testItemCnt").val("");
	}
	
	
	/** 시험문제 출제 */
	function fGenerate_test() {
		
		// validation 체크
		if (!fValidate_generateTest()) {
			return;
		}
		
		console.log("lec_id : " + $("#lecId").val());				
		console.log("lec_type_id : " + $("#lecTypeId").val());
		console.log("test_name : " + $("#testName").val());
		console.log("test_item_cnt : " + $("#testItemCnt").val());	
			
		var param = {
 				lec_id : $("#lecId").val(),				
				lec_type_id : $("#lecTypeId").val(),
				test_name : $("#testName").val(),
				generate_cnt : $("#testItemCnt").val(),
				test_start : $("#start_datepicker").val(),
				test_end : $("#end_datepicker").val(),
		};
			
		var callback = function(data) {
			
			if (data.result == 'SUCCESS') {
				
				// 응답 메시지 출력
				alert(data.resultMsg);			
				
				// 모달 닫기
				gfCloseModal();
				
				// 강사의 시험출제 목록 조회	
				var currentPage = $("#tmp_currentPage").val();
				
				fSearch_tutLecList(currentPage);
			}								
		};		
		
		callAjax("/tut/generateTest.do", "post", "json", true, param, callback);
	}
	
	/** 시험문제지 상세보기 */
	function fView_testDetail(lec_name, test_id) {		
		
		console.log("(fView_testDetail) test_id : " + test_id);
		gfModalPop("#ModalPop_testDetail");
		
 		var param = { 								
				lec_name : lec_name,
				test_id : test_id,
		};
		
		var callback = function(response) {
			
			console.log("fView_testDetail's response : " + response);				
			$("#testDetailBody").empty().append(response);		
		};
		
		callAjax("/tut/tutTestDetail.do", "post", "text", true, param, callback);
	}
	
	/** 시험응시 확인, 시험문제 조회 */
	function fApply_test(lec_id, lec_name, test_id, test_name, tut_name) {	

		console.log("lec_id : " + lec_id);
		console.log("lec_name : " + lec_name);
		console.log("test_id : " + test_id);
		console.log("test_name : " + test_name);
		console.log("tut_name : " + tut_name);
		
		$("#lec_id").val(lec_id);
		console.log($("#lec_id").val());


		if (confirm("시험에 응시하겠습니까?")) {
			gfModalPop("#ModalPop_testApply");
		}		
		
 		var param = {
 				lec_id : lec_id,				
				lec_name : lec_name,
				test_id : test_id,
				test_name : test_name,
				tut_name : tut_name,
		};
		
		var callback = function(response) {
			
			console.log(response);

			$("#testItemBody").empty().append(response);
		};
		
		callAjax("/std/testItemList.do", "post", "text", true, param, callback);	
	}
	
	/** 시험지 생성모달 validation */
	function fValidate_generateTest() {
		
		var chk;		
		chk = checkNotEmpty([ 	[ "testName", "시험명을 입력해 주세요." ]
		  					  , [ "testItemCnt", "시험항목 수를 입력해 주세요." ] ]);
	
		if (!chk) {
			return;
		}
		console.log("valid OK");

		return true;
	}
	
	/** 시험응시 취소시 확인 */
	function fConfirm_close(){
		
		if(confirm("정말 시험 응시를 취소하시겠습니까?")){
			gfCloseModal();
		}
	};
	
	
	/** 시험응시 후 시험제출 */
	function fSubmit_test() {

		if (confirm("정말 제출하시겠습니까?")){
			
			var callback = function(data) {
				
				if (data.result == 'SUCCESS') {
					
					// 응답 메시지 출력
					alert(data.resultMsg);
					
					// 모달 닫기
					gfCloseModal();
					
					// 시험 결과 확인
					fView_testResult(lec_id, test_id);
				}
			};			
		}
		
		callAjax("/std/submitTest.do", "post", "json", true, $("#testApplyForm").serialize(), callback);
	}
	
	
	/** 시험 결과 확인 */
	function fView_testResult(lec_id, test_id) {
		
		console.log("lec_id : " + lec_id);
		console.log("test_id : " + test_id);

 		var param = {
 				lec_id : lec_id,				
				test_id : test_id,
		};
		
		var callback = function(response) {
			
			console.log("fView_testResult's response : " + response);				
			$("#testResultBody").empty().append(response);
			
			
			// 나의 시험응시 목록 조회	
			var currentPage = $("#tmp_currentPage").val();
			
			fSearch_myTestList(currentPage);
		};
		
		callAjax("/std/testResult.do", "post", "text", true, param, callback);
	}

</script>
</head>

<body>
<form id="tutTestForm" action="" method="">
	<input type="hidden" id="tmp_lec_id" value="">
	<input type="hidden" id="tmp_std_id" value="">
	<input type="hidden" id="tmp_currentPage" value="">	
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">
	
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					
					<div class="content">
						<p class="Location">
							<a href="../dashboard/dashboard.do" 
								class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습관리</span> <span 
								class="btn_nav bold">시험출제</span> <a href="../tut/testGenerate.do" 
								class="btn_set refresh">새로고침</a>
						</p>						
						
						<p class="conTitle">
							<span>시험출제 목록</span>
							<span class="fr">
								<select id="searchKey" name="searchKey" style="width: 130px;"
										onchange="fSearch_tutLecList()">
									<option id="option1" value="AllTest" selected="selected">전체 강의목록</option>
									<option id="option1" value="ProceedingTest">진행중인 강의</option>
									<option id="option1" value="LastTest" >종료된 강의</option>
								</select>
							</span>
						</p>					
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="20%">
									<col width="30%">
									<col width="20%">									
								</colgroup>
								
								<thead>
									<tr>										
										<th scope="col">강의명</th>
										<th scope="col">강의분류</th>
										<th scope="col">강의기간</th>
										<th scope="col">시험문제</th>										
									</tr>
								</thead>
								<tbody id="tutTestListBody"></tbody>								
							</table>
						</div>
						                
						<div class="paging_area"  id="tutTestPagination"> </div>						
						
					</div> <!--// content -->					
					

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div><!--// container -->
	</div><!--// wrap_area -->
</form>

	<!-- 시험문제 출제 모달팝업 -->
	<div id="ModalPop_generateTest" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>시험문제 출제</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>
					<tbody>
						<tr>
							<th>강의명 </th>
							<td>
								<input type="hidden" id="lecId" value="">						
								<input type="text" class="inputTxt p100"
									id="lecName" name="lecName" disabled="disabled"/>
							</td>
							<th>강의분류 </th>
							<td>
								<input type="hidden" id="lecTypeId" value="">						
								<input type="text" class="inputTxt p100"
									id="lecTypeName" name="lecTypeName" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<th>시험명 </th>
							<td>
								<input type="text" class="inputTxt p100" 
									id="testName" name="testName"/>
							</td>
							<th>문항 수 </th>
							<td>
								<input type="number" class="inputTxt p100" 
									id="testItemCnt" name="testItemCnt"/>
							</td>							
						</tr>
						<tr>
						</tr>
						<tr>
							<th>시험 시작일 </th>
							<td>
								<input type="text" class="inputTxt p100" 
									id="start_datepicker" name="testStartDate" 
									data-date-format='yyyy.mm.dd'/>
							</td>
							<th>시험 종료일 </th>
							<td>
								<input type="text" class="inputTxt p100" 
									id="end_datepicker" name="testEndDate" 
									data-date-format='yyyy.mm.dd'/>
							</td>							
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnGenerateTest" name="btn"><span>시험지 생성</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		
	</div><!--// 시험문제 출제 모달팝업 -->
	
	<!-- 시험문제지 상세보기 팝업창 -->
	<div id="ModalPop_testDetail" class="layerPop layerType2" style="width: 650px; top: 100px !important;">
		<dl>
			<dt>
				<strong>시험문제지 확인</strong>
			</dt>
			<dd class="content" style="height: 600px !important; overflow: auto !important;">
	
				<!-- s : 여기에 내용입력 -->
	
				<table class="row" >
					<caption>caption</caption>
					<colgroup>
						<col width="15%">
						<col width="40%">
						<col width="15%">
						<col width="20%">
					</colgroup>
					
					<tbody id="testDetailBody"></tbody>
				</table>
	
				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="javascript:gfCloseModal();" class="btnType gray" id=""><span id="popupReload">확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div><!--// end 시험지 상세보기 팝업창 -->

</body>
</html>