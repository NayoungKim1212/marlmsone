<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>수강상담</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script src="${CTX_PATH}/js/summernote/summernote-ko-KR.js"></script>


<script type="text/javascript">

	var pageSize = 10;		//한 페이지당 몇개 보여줄 지
	var pageBlockSize = 5;	//페이지 당 번호

	/** OnLoad event */
	$(function() {
		//강의 목록 조회
		fSearch_lecList();
		
		//강의목록 조회
		//fSearchAdvList();
		
		//버튼 이벤트 등록
		fRegisterButtonClickEvent();
		
		$("#datepicker").datepicker({});
		$( "#datepicker" ).datepicker({ minDate: 0});

		fInitSummernote();
	});	
	
	
	function fInitSummernote() {
		$('#summernote').summernote({
			  height: 300,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '상담내용을 입력해주세요.',	//placeholder 설정
			  toolbar: [
			            // [groupName, [list of button]]
			            ['style', ['bold', 'italic', 'underline', 'clear']],
			            ['font', ['strikethrough']],
			            ['fontsize', ['fontsize']],
			            ['color', ['color']],
			            ['para', ['ul', 'ol', 'paragraph']],
			            ['height', ['height']]
			          ]
		});	
	}	
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				mfSave_adv();
				break;
			case 'btnUpdate':
				mfUpdate_adv();
				break;			
			case 'btnClose':				
				gfCloseModal();
				break;
			case 'btnDelete' :
				mfDelete_adv();
				break;	
			}
		});	
	}
	
	/** 강의목록 조회 */
	function fSearch_lecList(currentPage){
		
		currentPage = currentPage || 1;	// undefined 일 때 1값 나오게 설정		
		
		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
		};
		
		var callback = function(response) {
			fCallback_lecList(response, currentPage);
		};
		
		callAjax("/adv/lecList.do", "post", "text", false, param, callback);
	}
	
	/** 강의 목록 조회 콜백 함수 */
	function fCallback_lecList(response, currentPage) {
		
		console.log("fCallback_lecList's response : " + response);
		
		// 강의 목록 초기화 후 생성 (select option 생성)
		$("#lecList").empty().append(response);
		
		// 상담 목록 조회
		fSearch_advList();	
	}
	
	/** 상담 목록 조회 */	
	function fSearch_advList(currentPage){
		
		currentPage = currentPage || 1;	// undefined 일 때 1값 나오게 설정		
		
		lec_id = $("#lecList").val();
		
		// 강의ID 임시 저장
		$("#tmp_lec_id").val(lec_id);
		
		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {
			lec_id : lec_id,
			currentPage : currentPage,
			pageSize : pageSize,
		};
		
		console.log(param);
		
		var callback = function(response) {
			fCallback_advList(response, currentPage);
		};
		
		callAjax("/adv/advList.do", "post", "text", true, param, callback);
	}
	
	/** 상담 목록 조회 콜백 함수 */
	function fCallback_advList(response, currentPage) {
		
		console.log("fCallback_advList's response : " + response);		
		
		// 상담 목록 초기화 후 생성 
		$("#advListBody").empty().append(response);
		console.log("listCnt : " + $("#listCnt").val());
		
		// 상담 목록 총 개수 추출
		var advListCnt = $("#listCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml( currentPage, 
												advListCnt, 
												pageSize, 
												pageBlockSize, 
												'fSearch_advList' );	 
		$("#advPagination").empty().append( paginationHtml );
		
		// 상담 목록 현재 페이지 임시 저장
		$("#tmp_currentPage").val(currentPage);
	}
	
	/** 상담 상세 조회 */
	function fSearch_advDetail(adv_id, lec_id){
		
		console.log("fSearch_advDetail( adv_id : " + adv_id + ", lec_id : " + lec_id + " )");
		$("#tmp_adv_id").val(adv_id);
		
		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {			
			adv_id : adv_id,
			lec_id : lec_id,			
		};
		
		console.log(param);
		
		var callback = function(response) {			
			var responseObject = JSON.parse(response);	
			console.log("[ fSearch_advDetail ] response : " + response);			
			
			if (responseObject.result == "SUCCESS") {
				
				console.log(responseObject.data);
				console.log("##### adv_id : " + adv_id);
				
				// 상담폼에 상세보기 데이터 저장 
				mfInit_advForm(responseObject.data, responseObject.loginID);
				
				// 모달 팝업
				gfModalPop("#ModalPop_adv");
				
			} else {
				alert(response.resultMsg);
			}
		};
		
		callAjax("/adv/advDetail.do", "post", "text", true, param, callback);
	}
	
	/** (모달)강의 목록 조회 */
	function mfSearch_lecList(){		
		
		var param = {};
		
		var callback = function(response) {
			
			console.log(response);			
			// 기존 강의 목록 삭제 후 생성
			$("#mlecList").empty().append(response);			
		};
		
		callAjax("/adv/mlecList.do", "post", "text", true, param, callback);
	}
	
	/** (모달)강의 수강 학생 목록 조회 */
	function mfSearch_lecStdList(){
		
		var lec_id = $("#mlecList").val();
		console.log("mfSearch_lecStdList() lec_id : " + lec_id)
		
		var param = {
				lec_id : lec_id,
		};
		
		var callback = function(response) {
			
			console.log(response);			
			// 기존 학생 목록 삭제 후 생성
			$("#mlecStdList").empty().append(response);
		};
		
		callAjax("/adv/mlecStdList.do", "post", "text", true, param, callback);
	}	
	
	/** (모달)상담 저장 */
	function mfSave_adv(){

		// validation 체크
		if (!mfValidate_adv()) {
			return;
		}		
		
		var param = {
				action : $("#action").val(),
				lec_id : $("#mlecList").val(),
				std_id : $("#mlecStdList").val(),
				adv_place : $("#advPlace").val(),
				adv_content : $("#summernote").val(),
				adv_date : $("#datepicker").val(),				
				tmp_lec_id : $("#tmp_lec_id").val(),
		};
		
		var callback = function(response) {
			mfSave_advResult(response);			
		};
		
		callAjax("/adv/advSave.do", "post", "text", false, param, callback);
	}
	
	/** (모달)상담 저장 콜백 함수 */
	function mfSave_advResult(response){
									
		var responseObject = JSON.parse(response);	
		console.log("[ mfSave_advResult ] response : " + response);			
		
		if (responseObject.result == "SUCCESS") {					
			
			// 응답  메시지 출력
			alert(responseObject.resultMsg);	
			
			// 모달 닫기
			gfCloseModal();								
			
			// 상담 목록 조회
			var currentPage = "1";
			var lec_id = $("#tmp_lec_id").val();
			
			fSearch_advList(currentPage, lec_id);
			
		} else {
			alert(responseObject.resultMsg);				
		}
		
		// 상담 모달 폼 초기화
		mfInit_advForm();
	}
	
	/** (모달)상담 수정 */
	function mfUpdate_adv(){

		// validation 체크
		if (!mfValidate_adv()) {
			return;
		}		
		
		var param = {
				action : $("#action").val(),
				adv_id : $("#tmp_adv_id").val(),
				adv_place : $("#advPlace").val(),
				adv_date : $("#datepicker").val(),
				adv_content : $("#summernote").val(),				
				tmp_lec_id : $("#tmp_lec_id").val(),
		};
		
		console.log(param);
		
		var callback = function(response) {
			mfUpdate_advResult(response);			
		};
		
		callAjax("/adv/advSave.do", "post", "text", false, param, callback);
	}
	
	/** (모달)상담  수정 콜백 함수 */
	function mfUpdate_advResult(response){
									
		var responseObject = JSON.parse(response);	
		console.log("[ mfUpdate_advResult ] response : " + response);			
		
		if (responseObject.result == "SUCCESS") {					
			
			// 응답  메시지 출력
			alert(responseObject.resultMsg);	
			
			// 모달 닫기
			gfCloseModal();								
			
			// 상담 목록 조회	
			var currentPage = $("#tmp_currentPage").val();
			var lec_id = $("#tmp_lec_id").val();
			
			fSearch_advList(currentPage, lec_id);			
			
		} else {
			alert(responseObject.resultMsg);				
		}
		
		// 상담 모달 폼 초기화
		mfInit_advForm();
	}
	
	/** (모달)상담 삭제 */
	function mfDelete_adv(){

		var param = {
				action : $("#action").val(),
				adv_id : $("#tmp_adv_id").val(),
		};
		
		console.log(param);
		
		var callback = function(response) {
			mfDelete_advResult(response);			
		};
		
		callAjax("/adv/advDelete.do", "post", "text", false, param, callback);
	}
	
	/** (모달)상담  삭제 콜백 함수 */
	function mfDelete_advResult(response){
									
		var responseObject = JSON.parse(response);	
		console.log("[ mfUpdate_advResult ] response : " + response);			
		
		if (responseObject.result == "SUCCESS") {					
			
			// 응답  메시지 출력
			alert(responseObject.resultMsg);	
			
			// 모달 닫기
			gfCloseModal();								
			
			// 상담 목록 조회	
			var currentPage = $("#tmp_currentPage").val();
			var lec_id = $("#tmp_lec_id").val();
			
			fSearch_advList(currentPage, lec_id);			
			
		} else {
			alert(responseObject.resultMsg);				
		}
	}
	
	/** 상담 등록폼 validation */
	function mfValidate_adv() {
		
		var chk;
		if($("#action").val() == "I") {
			
			chk = checkNotEmpty([ 	[ "mlecList", "강의를 선택해 주세요." ]
			  				      , [ "mlecStdList", "수강 학생을 선택해 주세요." ]	
			  					  ,	[ "datepicker", "상담 날짜를 선택해 주세요." ]
            					  , [ "summernote", "상담 내용을 입력해 주세요." ] ]);
			
		} else if($("#action").val() == "U") {
			
			chk = checkNotEmpty([   [ "datepicker", "상담 날짜를 선택해 주세요." ]
			  					  , [ "summernote", "상담 내용을 입력해 주세요." ] ]);
		}			
		
		if (!chk) {
			return;
		}
		console.log("valid OK");

		return true;
	}
	
	/** 상담 모달 실행 */
	function fPopModal_adv(adv_id, lec_id) {
		
		console.log("fPopModal_adv( adv_id: " + adv_id + ", lec_id: " + lec_id + " )");
		
		if (adv_id == null || adv_id == "") { // 상담 신규 저장 (등록)
		
			// action type 설정
			$("#action").val("I");
		
			// 상담 모달 폼 초기화 
			mfInit_advForm();
			mfSearch_lecList();
			
			// 모달 팝업
			gfModalPop("#ModalPop_adv");
			
		} else { // 상담 상세보기 (수정/삭제)
			
			// action type 설정
			$("#action").val("U");
		
			// 상담 상세조회
			fSearch_advDetail(adv_id, lec_id);
		}
	}
	
	function mfInit_advForm(object, loginID) {		
		
		if (object == null || object == "" || object == undefined ) {
			
			$("#mlecList").show();
			$("#mlecList").val("");
			$("#lecName").hide();
			
			$("#mlecStdList").show();
			$("#mlecStdList").val("");			
			$("#stdName").hide();
			
			$("#datepicker").val("");
			$("#advPlace").val("");	
			
			$(".trDtlInfo").hide();					
			$('#summernote').summernote('reset');
			
			$("#btnSave").show();
			$("#btnUpdate").hide();
			$("#btnDelete").hide();
			
		} else {
			
			$("#tmp_adv_id").val(object.adv_id);
			
			$("#mlecList").hide();
			$("#mlecStdList").hide();
			$("#btnSave").hide();
			
			
			$("#lecName").show();
			$("#lecName").val(object.lec_name);		
								
			$("#stdName").show();
			$("#stdName").val(object.std_name + " (" + object.std_id + ")");

			$("#datepicker").val(object.adv_date);
			$("#advPlace").val(object.adv_place);

			$(".trDtlInfo").show();
			$("#modDate").val(object.mod_date);
			$("#tutName").val(object.tut_name + " (" + object.tut_id + ")");
	
			$('#summernote').summernote('code', object.adv_content);
			
			if(object.tut_id != loginID) {	//로그인ID와 작성자ID를 비교 

				$("#datepicker").prop('disabled', true);				
				$("#advPlace").prop("readonly", true);
				$("#summernote").summernote('disable');
				
				$("#btnUpdate").hide();
				$("#btnDelete").hide();				
			} else {
				$("#btnUpdate").show();
				$("#btnDelete").show();				
			}
		}		
	}
   
</script>

</head>
<body>
<form id="advForm" action="" method="">
	<input type="hidden" id="action" name="action" value="">
	<input type="hidden" id="tmp_adv_id" value="">
	<input type="hidden" id="tmp_lec_id" value="">
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
								class="btn_nav bold">수강상담 관리</span> <a href="../adv/advice.do" 
								class="btn_set refresh">새로고침</a>
						</p>						
						
						<p class="conTitle">
							<span>수강상담 관리</span>
							<span class="fr">
								<select id="lecList" style="width: 200px"; onchange="fSearch_advList()">							
								</select>
								<a class="btnType blue" href="javascript:fPopModal_adv();" name="modal"><span>상담 등록</span></a>						
							</span>	
						</p>				
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>										
										<th scope="col">상담 번호</th>
										<th scope="col">과정 명</th>
										<th scope="col">학생 명 (ID)</th>
										<th scope="col">상담일자</th>
										<th scope="col">상담자 명 (ID)</th>
									</tr>
								</thead>
								<tbody id="advListBody"></tbody>								
							</table>
						</div>
						                
						<div class="paging_area"  id="advPagination"> </div>						
						
					</div> <!--// content -->					
					

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div><!--// container -->
	</div><!--// wrap_area -->
	
	<!-- 모달팝업 -->
	<div id="ModalPop_adv" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>수강상담 관리</strong>
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
							<th>과정명 </th>
							<td>
								<select id="mlecList" 
									class="inputTxt p100" onchange="mfSearch_lecStdList()">
								</select>
								<input type="text" class="inputTxt p100" 
									id="lecName" name="lecName" disabled="disabled"/>
							</td>			
							<th>학생명 </th>
							<td>
								<select id="mlecStdList" class="inputTxt p100">									
								</select>
								<input type="text" class="inputTxt p100"
									id="stdName" name="stdName" disabled="disabled"/>
							</td>
						</tr>
						<tr>
							<th>상담일자 </th>
							<td>
								<input type="text" class="inputTxt p100" 
									id="datepicker" name="advDate" 
									data-date-format='yyyy.mm.dd'/>
							</td>
							<th>상담장소</th>
							<td>
								<input type="text" class="inputTxt p100"
									id="advPlace" name="advPlace"/>
							</td>						
						</tr>						
						<tr class="trDtlInfo">
							<th>최종 수정일자</th>
							<td>
								<input type="text" class="inputTxt p100" 
									id="modDate" name="modDate"
									data-date-format='yyyy.mm.dd HH:MM' readonly>
							</td>
							<th>상담자</th>
							<td>
								<input type="text" class="inputTxt p100"
									id="tutName" name="tutName" disabled="disabled"/>
							</td>						
						</tr>
						<tr>
							<td colspan="4">
								<textarea id="summernote" name="advContent"
									style="height: 300px"></textarea>
							</td>
						</tr>			
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
					<a href="" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a>
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a>
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
		
	</div><!--// 모달팝업 -->
</form>
</body>
</html>