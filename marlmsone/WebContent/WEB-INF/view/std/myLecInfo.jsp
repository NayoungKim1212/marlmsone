<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>나의 수강목록</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>


<script type="text/javascript">

	var pageSize = 10;		//한 페이지당 몇개 보여줄 지
	var pageBlockSize = 5;	//페이지 당 번호

	/** OnLoad event */
	$(function() {
		
		//나의 수강목록 조회
		fSearch_myLecList();
		
		fRegisterButtonClickEvent();
	});	
	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSubmitSurvey':
				fSubmit_survey();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});	
	}
	
	/** 나의 수강목록 조회 */
	function fSearch_myLecList(currentPage){
		
		currentPage = currentPage || 1;	// undefined 일 때 1값 나오게 설정
		var searchKey = $("#searchKey").val();
		console.log(searchKey);
		
		// 나의 수강목록 검색 option 저장
		$("#tmp_searchKey").val(searchKey);	
		
		var param = {						
			currentPage : currentPage,
			pageSize : pageSize,
			searchKey : searchKey,
		};
		
		var callback = function(response) {
			fCallback_myLecList(response, currentPage);
		};
		
		callAjax("/std/myLecList.do", "post", "text", true, param, callback);
	}
	
	/** 나의 수강목록 조회 콜백 함수 */
	function fCallback_myLecList(response, currentPage) {
		
		console.log("fCallback_myLecList's response : " + response);
		
		// 나의 수강목록 초기화 후 생성
		$("#myLecListBody").empty().append(response);
		
		// 나의 수강목록 총 개수 추출				
		var myLecListCnt = $("#listCnt").val();
	
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml( currentPage, 
												myLecListCnt, 
												pageSize, 
												pageBlockSize, 
												'fSearch_myLecList' );
		console.log(paginationHtml);
		$("#myLecPagination").empty().append( paginationHtml );

		// 나의 수강목록 현재 페이지 임시 저장
		$("#tmp_currentPage").val(currentPage);				
	}
	
	/** 나의 수강목록 상세보기 */
	function fPopModal_myLecDetail(lec_id) {		
		
		gfModalPop("#ModalPop_myLecDetail");
		
		var param = {						
			lec_id : lec_id,
		};
		
		var callback = function(response) {
			console.log(response);
			$("#myLecDetailBody").empty().append(response);
		};
		
		callAjax("/std/myLecDetail.do", "post", "text", true, param, callback);
	}
	
	/** 설문조사 참여를 위해 설문문항 조회 */
	function fSurvey(lec_id, lec_name, tut_name) {	

		console.log("lec_id : " + lec_id);
		$("#lec_id").val(lec_id);
		console.log($("#lec_id").val());

		if (confirm("설문조사에 참여하겠습니까?")) {
			gfModalPop("#ModalPop_survey");
		}		
		
 		var param = {
 				lec_id : lec_id,
 				lec_name : lec_name,
 				tut_name : tut_name,
		};
		
		var callback = function(response) {
			
			console.log(response);

			$("#surveyItemBody").empty().append(response);
		};
		
		callAjax("/std/surveyItemList.do", "post", "text", true, param, callback);	
	}
	
	/** 설문조사 제출 */
	function fSubmit_survey() {
		
		var callback = function(data) {			
			
			
			if (data.result == 'SUCCESS') {
				
				// 응답 메시지 출력
				alert(data.resultMsg);
				
				// 모달 닫기
				gfCloseModal();
				
				// 나의 수강 목록 조회	
				var currentPage = $("#tmp_currentPage").val();
				fSearch_myLecList();
			}								
		};

		var survey_review = document.getElementById("review").value;		
		$("#survey_review").val(survey_review);
		
		callAjax("/std/submitSurvey.do", "post", "json", true, $("#surveyForm").serialize(), callback);
	}
   
</script>

</head>
<body>
<form id="myLecForm" action="" method="">
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
								class="btn_nav bold">나의 수강목록</span> <a href="../std/myLectureInfo.do" 
								class="btn_set refresh">새로고침</a>
						</p>						
						
						<p class="conTitle">
							<span>나의 수강목록</span>
							<span class="fr">
								<select id="searchKey" name="searchKey" style="width: 200px;"
										onchange="fSearch_myLecList()">
									<option id="option1" value="AllLec" selected="selected">전체 수강목록</option>
									<option id="option1" value="ProceedingLec">진행중인 수강목록</option>
									<option id="option1" value="LastLec" >지난 수강목록</option>
								</select>
							</span>
						</p>				
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="20%">
									<col width="10%">
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>						
										<th scope="col">강의번호</th>				
										<th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">강의실</th>										
										<th scope="col">기간</th>
										<th scope="col">승인여부</th>
										<th scope="col">설문조사여부</th>
									</tr>
								</thead>
								<tbody id="myLecListBody"></tbody>								
							</table>
						</div>
						                
						<div class="paging_area"  id="myLecPagination"> </div>						
						
					</div> <!--// content -->					
					

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div><!--// container -->
	</div><!--// wrap_area -->
</form>
	
	<!-- 나의 수강목록 상세보기 팝업창 -->
	<div id="ModalPop_myLecDetail" class="layerPop layerType2" style="width: 650px;">
		<dl>
			<dt>
				<strong>수강목록 상세보기</strong>
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
					
					<tbody id="myLecDetailBody"></tbody>
				</table>
	
				<!-- e : 여기에 내용입력 -->
				<div class="btn_areaC mt30">
					<a href="javascript:gfCloseModal();" class="btnType gray" id=""><span id="popupReload">확인</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div><!--// end 나의 수강목록 상세보기 팝업창 -->	
	
<!-- 설문조사 참여 모달팝업 -->
<form id="surveyForm">
	<input type="hidden" id="lec_id" value="">
	
	<div id="ModalPop_survey" class="layerPop layerType2" style="width: 800px;">
		<dl>
			<dt>
				<strong>설문 조사</strong>
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
					
					<tbody id="surveyItemBody"></tbody>			
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSubmitSurvey" name="btn"><span>제출</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		
	</div>
</form><!--// end 설문조사 참여 모달팝업 -->

</body>
</html>