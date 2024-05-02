<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>나의 시험응시 목록</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	var pageSize = 10;		//한 페이지당 몇개 보여줄 지
	var pageBlockSize = 5;	//페이지 당 번호

	/** OnLoad event */
	$(function() {
		
		fSearch_myTestList(); //나의 시험응시 목록 조회	
		fRegisterButtonClickEvent();
	});	
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSubmitTest':
				fSubmit_test();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});		
	}
	
	/** 나의 시험응시 목록 조회 */
	function fSearch_myTestList(currentPage){
		
		currentPage = currentPage || 1;	// undefined 일 때 1값 나오게 설정
		var searchKey = $("#searchKey").val();
		
		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {						
			currentPage : currentPage,
			pageSize : pageSize,
			searchKey : searchKey,
		};
		
		var callback = function(response) {
			fCallback_myTestList(response, currentPage);
		};
		
		callAjax("/std/myTestList.do", "post", "text", false, param, callback);
	}
	
	/** 나의 시험응시 목록 조회 콜백 함수 */
	function fCallback_myTestList(response, currentPage) {
		
		console.log("fCallback_myTestList's response : " + response);
		
		// 나의 시험응시 목록 초기화 후 생성
		$("#myTestListBody").empty().append(response);
		
		// 나의 시험응시 목록 총 개수 추출
		var myTestListCnt = $("#listCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml( currentPage, 
												myTestListCnt, 
												pageSize, 
												pageBlockSize, 
												'fSearch_myTestList' );
		console.log(paginationHtml);		
		$("#myTestPagination").empty().append( paginationHtml );		
		
		// 나의 시험응시 목록 현재 페이지 임시 저장
		$("#tmp_currentPage").val(currentPage);
	}
	
	/** 시험응시 확인, 시험문제 조회 */
	function fApply_test(lec_id, lec_name, test_id, tut_name) {	

		console.log("lec_id : " + lec_id);
		console.log("lec_name : " + lec_name);
		console.log("test_id : " + test_id);
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
				tut_name : tut_name,
		};
		
		var callback = function(response) {
			
			console.log(response);

			$("#testItemBody").empty().append(response);
		};
		
		callAjax("/std/testItemList.do", "post", "text", true, param, callback);	
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
					alert("시험 문제가 제출되었습니다.");
					var lec_id = data.lec_id;
					var test_id = data.test_id;
					
					gfCloseModal();
					
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

		gfModalPop("#ModalPop_testResult");
		

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
<form id="myTestForm" action="" method="">
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
								class="btn_nav bold">시험응시</span> <a href="../std/myTestInfo.do" 
								class="btn_set refresh">새로고침</a>
						</p>						
						
						<p class="conTitle">
							<span>시험응시</span>
							<span class="fr">
								<select id="searchKey" name="searchKey" style="width: 130px;"
										onchange="fSearch_myTestList()">
									<option id="option1" value="AllTest" selected="selected">전체 시험목록</option>
									<option id="option1" value="ProceedingTest">진행중인 시험</option>
									<option id="option1" value="LastTest" >지난 시험</option>
								</select>
							</span>
						</p>					
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
								</colgroup>
								
								<thead>
									<tr>										
										<th scope="col">과정명</th>
										<th scope="col">시험명</th>
										<th scope="col">강사명</th>
										<th scope="col">응시기간</th>
										<th scope="col">결과</th>
										<th scope="col">시험응시</th>
									</tr>
								</thead>
								<tbody id="myTestListBody"></tbody>								
							</table>
						</div>
						                
						<div class="paging_area"  id="myTestPagination"> </div>						
						
					</div> <!--// content -->					
					

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div><!--// container -->
	</div><!--// wrap_area -->
</form>
	
<!-- 시험응시 모달팝업 -->
<form id="testApplyForm">
	<input type="hidden" id="lec_id" value="">
	
	<div id="ModalPop_testApply" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>시험 응시</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="10%">
						<col width="40%">
						<col width="10%">
						<col width="40%">
					</colgroup>
					
					<tbody id="testItemBody"></tbody>			
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSubmitTest" name="btn"><span>제출</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		
	</div>
</form><!--// end 시험응시 모달팝업 -->

	<!-- 시험결과 확인 팝업창 -->
	<div id="ModalPop_testResult" class="layerPop layerType2" style="width: 650px; top: 100px !important;">
		<dl>
			<dt>
				<strong>시험 결과 확인</strong>
			</dt>
			<dd class="content" style="height: 600px !important; overflow: auto !important;">
	
				<!-- s : 여기에 내용입력 -->
	
				<table class="row" >
					<caption>caption</caption>
					<colgroup>
						<col width="20%">
						<col width="30%">
						<col width="20%">
						<col width="30%">
					</colgroup>
					
					<tbody id="testResultBody"></tbody>
				</table>
	
				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="javascript:gfCloseModal();" class="btnType gray" id=""><span id="popupReload">확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div><!--// end 시험결과 확인 팝업창 -->

</body>
</html>