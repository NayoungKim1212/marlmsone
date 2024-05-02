<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>시설 관리 : 강의실</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	

	/** 페이징 사이즈 조절 */
	var pagesize = 5;			// -- 한 페이지 당 몇개 보여줄 지
	var pageblocksize = 10;		// -- 페이지 당 번호

	/** OnLoad event */ 
	$(function() {
		lectureRoomSearch();
		fRegisterButtonClickEvent();
		$("#equ").hide();
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e){
			e.preventDefault();	// submit시에 창이 넘어가는 것을 방지
			lectureRoomSearch();
		});
		
		// a 태그의 이름이 btn 인 경우
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
			
			// 현재 입력된 객체의 id 를 가져옴
			var btnId = $(this).attr('id');
          
			// id 값으로 행동을 분기
			switch (btnId) {
				case 'btnSave' :
					Save();
					break;
				case 'btnDelete' :
					Delete();
					break;
				case 'btnSaveEqu' :
					SaveEqu();
					break;
				case 'btnDeleteEqu' :
					DeleteEqu();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
		
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 강의실 명 검색
	function lectureRoomSearch(cpage){
		cpage = cpage || 1;	// undefined 일 때 1값 나오게 설정
		
		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {
			searchRoomName : $("#searchRoomName").val(),
			cpage : cpage,
			pagesize : pagesize,
		};
		
		var listCallback = function(response){
			console.log(response);
			$("#listLectureBody").empty().append(response);
			console.log($("#listcnt").val());
			// common.js 의 페이징 getPaginationHtml() 함수 사용
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'lectureRoomSearch'); 
			console.log("paginationHtml : " + paginationHtml);	
			
			$("#lectureRoomPagination").empty().append(paginationHtml); 
			
			// 장비 관리 쪽 정보 초기화 하고 숨기기
			$("#equcpage").val("");
			$("#equ_id").val("");
			$("#equ").hide();			
			
			// 보고있는 페이지 유지를 하기 위함
			$("#cpage").val(cpage);
			
			
			
		};
		
		// callAjax(url, method, dataType, async, param, callback)
			// async : false , sync : true -- 비동기(요청하고 다른 동작 가능) / 동기
		callAjax("/adm/lectureRoomList.do", "post", "text", false, param, listCallback);
		
	}
	
	// 등록 모달 팝업 하는 함수
	function newReg(){
		// 초기화
		init();
		gfModalPop("#layer1");
	}
	
	// 값 초기화 함수
	// data 여부를 판단해 등록과 수정으로 나누어 초기화 
	function init(data){
		if(data!=null){
			$("#lecrm_id").val(data.lecrm_id);
			$("#lecrm_name").val(data.lecrm_name);
			$("#lecrm_size").val(data.lecrm_size);
			$("#lecrm_snum").val(data.lecrm_snum);
			$("#lecrm_note").val(data.lecrm_note);
			$("#action").val("U");	// 수정일 때 U 값으로 초기화
			$("#btnDelete").show();	// 신규 등록일 때 삭제 버튼을 드러내기
		} else {
			$("#lecrm_id").val("");
			$("#lecrm_name").val("");
			$("#lecrm_size").val("");
			$("#lecrm_snum").val("");
			$("#lecrm_note").val("");
			$("#action").val("I");	// 신규 등록일 때 I 값으로 초기화
			$("#btnDelete").hide();	// 신규 등록일 때 삭제 버튼을 숨기기
		}
		
	}
		
	// 모달에서 글 저장 하는 함수
	function Save(){
		// flase 값이 들어오면 -> return
		if(!fValidate()){
			return;
		}
		
		if(nameCheck()){
			return;
		}
		
		// 들어온 값을 저장하기위해 값을 저장
		var param = {
				lecrm_name : $("#lecrm_name").val()
				, lecrm_size : $("#lecrm_size").val()
				, lecrm_snum : $("#lecrm_snum").val()
				, lecrm_note : $("#lecrm_note").val()
				, action : $("#action").val() 
				, lecrm_id : $("#lecrm_id").val()
		}
		
		console.log(param.lecrm_id);
		
		var savecallback = function(response){
			// json 형태로 가져오기 때문에 그대로 찍으면 object 로 나옴 -> String 으로 변환하여 출력
		
			// 값이 저장되었는지에 대한 return 을 처리
			alert(response.resultmsg);
			// 값 저장 성공시
			if(response.result == "S") {
				gfCloseModal();
				if($("#action").val() == "I") {
					lectureRoomSearch();
				} else {
					lectureRoomSearch($("#cpage").val());
				}
			}
			
		}
		
		callAjax("/adm/lectureRoomSave.do", "post", "json", false, param, savecallback);
		
	}
	
	
	// 강의실 수정 - 상세
	function modify(lecrm_id){
		var param = {
				lecrm_id : lecrm_id
		}
		
		var delcallback = function(response){
			console.log(JSON.stringify(response));
			// 가져온 값 넣어서 수정 창 뜰 수 있게
			init(response.selinfo);	
			gfModalPop("#layer1");
		}
		
		callAjax("/adm/lectureRoomDtl.do", "post", "json", false, param, delcallback);
	}
	

	// 강의실 삭제
	function Delete(lecrm_id){
		$("#action").val("D");
		Save();
	}
	
	/** 강의실 등록/수정 저장 validation */
	function fValidate() {
		var chk = checkNotEmpty(
				[
						[ "lecrm_name", "강의실 명을 입력해 주세요." ]
					,	[ "lecrm_size", "강의실 크기를 입력해 주세요" ]
					,	[ "lecrm_snum", "강의실 자리수를 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}
		return true;
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 강의실 장비 리스트(아이디)
	function equSearchList(lecrm_id) {
		$("#lecrm_id").val(lecrm_id);
		equSearch();
	}
	
	// 강의실 장비 리스트(페이지)
	function equSearch(cpage){
		$("#equ").show();
		
		cpage = cpage || 1;	// undefined 일 때 1값 나오게 설정
		
		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {
			lecrm_id : $("#lecrm_id").val()
			, cpage : cpage
			, pagesize : pagesize
		};
		
		
		var listCallback = function(response){
			console.log(response);
			$(".divEquList").show();
			$("#equPagination").show();
			$("#listEquBody").empty().append(response);
			console.log("listcnt : " + $("#listcnt").val());
			// common.js 의 페이징 getPaginationHtml() 함수 사용
			// equSearch 는 어떤 함수를 사용할 지에 대한 부분? 명시하는 듯
			var paginationHtml = getPaginationHtml(cpage, $("#equlistcnt").val(), pagesize, pageblocksize, 'equSearch'); 
			console.log("paginationHtml : " + paginationHtml);	
			
			$("#equPagination").empty().append(paginationHtml); 
			
			// 보고있는 페이지 유지를 하기 위함
			$("#equcpage").val(cpage);
		};
		
		// callAjax(url, method, dataType, async, param, callback)
			// async : false , sync : true -- 비동기(요청하고 다른 동작 가능) / 동기
		callAjax("/adm/equList.do", "post", "text", false, param, listCallback);
	}
	
	// data 여부를 판단해 등록과 수정으로 나누어 초기화 
	function initEqu(data){
		if(data!=null){
			$("#equ_id").val(data.equ_id);
			$("#equ_name").val(data.equ_name);
			$("#equ_num").val(data.equ_num);
			$("#equ_note").val(data.equ_note);
			$("#action").val("U");	// 수정일 때 U 값으로 초기화
			$("#btnDeleteEqu").show();	// 신규 등록일 때 삭제 버튼을 드러내기
		} else {
			$("#equ_id").val("");
			$("#equ_name").val("");
			$("#equ_num").val("");
			$("#equ_note").val("");
			$("#action").val("I");	// 신규 등록일 때 I 값으로 초기화
			$("#btnDeleteEqu").hide();	// 신규 등록일 때 삭제 버튼을 숨기기
		}
	}
	
	// 등록 모달 팝업 하는 함수
	function newRegEqu(){
		initEqu();
		console.log("action : " + $("#action").val());
		gfModalPop("#layer2");
	}
	
	// 장비 관리 Validation check
	function eValidate() {
		var chk = checkNotEmpty(
				[
						[ "equ_name", "장비 명을 입력해 주세요." ]
					,	[ "equ_num", "장비 수를 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}
		return true;
	}

	
	// 장비 관리 등록/수정 하는 함수
	function SaveEqu(){
		
		if(!eValidate()){
			return;
		}
		
		var param = {
				lecrm_id : $("#lecrm_id").val()
				, equ_name : $("#equ_name").val()
				, equ_num : $("#equ_num").val()
				, equ_note : $("#equ_note").val()
				, equ_id : $("#equ_id").val()
				, action : $("#action").val()
		}
		
		
		var saveCallback = function(response){
			alert(response.resultmsg);
			
			if(response.result==="S"){
				gfCloseModal();
				if($("#action").val()=="I"){
					equSearch();
				} else {
					equSearch($("#equcpage").val());
				}
			}
		}
		
		callAjax("/adm/equSave.do", "post", "json", false, param, saveCallback);
		
	}
	
	// 장비 상세
	function equDtl(equ_id){
		var param = {
				equ_id : equ_id
		}
		
		var dtlCallback = function(response){
			console.log(JSON.stringify(response));
			initEqu(response.selinfo);	
			gfModalPop("#layer2");
		}
		
		callAjax("/adm/equDtl.do", "post", "json", false, param, dtlCallback);
	}
	
	// 장비 삭제
	function DeleteEqu(){
		$("#action").val("D");
		SaveEqu();
	}

	// 필터링
	/** 숫자 필터링 */
    function formatNumber(id) {
        var searchWord_std = document.getElementById(id);
        // 숫자로만 이루어진 문자열인지 확인
        var number = searchWord_std.value.replace(/[^0-9]/g, "");
        console.log(number);
        
        // 입력된 내용을 변경된 번호로 업데이트
        searchWord_std.value = number;
    }
	
	/** 강의실 이름 중복 체크 */
	function nameCheck(){
		var lecrm_name = $("#lecrm_name").val().trim();
		$("#lecrm_name").val(lecrm_name);
		
		var param = {
			lecrm_id : $("#lecrm_id").val(),
			lecrm_name : lecrm_name,
		}
		
		var savecallback = function(response){
			
			if(response.result==="N"){
				alert(response.resultmsg);
				$("#lecrm_name").focus();
				return false;
			} else {
				
				return true;
			}
			
		}
		
		callAjax("/adm/lectureRoomNameCheck.do", "post", "json", false, param, savecallback);
	}
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	
	<!--
		lecrm_id	-> 강의실 정보 수정/삭제시 PK 값으로 인덱싱하기 위해서 hidden 으로 저장
		action		-> I : insert , U : update, D : delete 
	 -->
	 <input type="hidden" id="lecrm_id" name="lecrm_id" value=""/>
	 <input type="hidden" id="equ_id" name="equ_id" value=""/>
	 <input type="hidden" id="action" name="action" value=""/>
	 <input type="hidden" id="cpage" name="cpage" value=""/>
	 <input type="hidden" id="equcpage" name="equcpage" value=""/>
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb (메뉴) 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../notice/aNotice.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">시설 관리</span> <span class="btn_nav bold"> 강의실
								</span> <a href="" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>강의실</span> <span class="fr">

		                     <span style="font-size: 15px; font-weight: bold;">강의실 명 </span>
		                     <input type="text" id="searchRoomName" name="searchRoomName"  
		                     class="form-control" placeholder="" style="height: 28px;" >
	
		                       <a class="btnType blue" href="" name="searchbtn" id="searchbtn" ><span>검색</span></a>
		                       <a class="btnType blue" href="javascript:newReg();" name="newReg" id="newReg"><span>강의실 신규등록</span></a>
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="15%">
									<col width="10%">
									<col width="40%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의실 명</th>
										<th scope="col">강의실 크기</th>
										<th scope="col">강의실 자리수</th>
										<th scope="col">비고</th>
										<th scope="col"></th>
									</tr>
								</thead>
								
								<%-- 목록을 뿌리는 tbody --%>
								<tbody id="listLectureBody"></tbody>
								
							</table>
						</div>
	
						<div class="paging_area"  id="lectureRoomPagination"  style="margin-bottom: 50px;"> </div>
						
						<div id="equ">
							<p class="conTitle">
			                     <span>장비 목록</span> <span class="fr">
			                       <a class="btnType blue" href="javascript:newRegEqu();" name="newRegEqu" id="newRegEqu"><span>장비 신규등록</span></a>
			                     </span>
	                  		</p>
							
							
							<%-- 강의실 장비정보 table --%>
							<div class="divEquList divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="15%">
										<col width="10%">
										<col width="40%">
										<col width="15%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">강의실 명</th>
											<th scope="col">장비 명</th>
											<th scope="col">장비 수</th>
											<th scope="col">비고</th>
											<th scope="col"></th>
										</tr>
									</thead>
									
									<tbody id="listEquBody"></tbody>
									
								</table>
							</div>
							<div class="paging_area"  id="equPagination"> </div>
				
						</div> <!--// content -->
	
						<h3 class="hidden">풋터 영역</h3>
							<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</div>
				</li>
			</ul>
		</div>
	</div>

	<!-- 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>강의실 등록</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">강의실 명 <span class="font_red">*</span></th>
							<td colspan=3>
								<input type="text" class="inputTxt p100" name="lecrm_name" id="lecrm_name" 
								placeholder="강의실 명 앞,뒤로 공백 문자 입력 불가" />
							</td>
						</tr>
						<tr>
							<th scope="row">강의실 크기 <span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="lecrm_size" id="lecrm_size" /></td>
							<th scope="row">강의실 자리수 <span class="font_red">*</span></th>
							<td>
								<input type="text"  class="inputTxt p100" name="lecrm_snum" id="lecrm_snum" 
								oninput="javascript:formatNumber('lecrm_snum');"
								placeholder="숫자 입력"/>
							</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan=3><input type="text" class="inputTxt p100" name="lecrm_note" id="lecrm_note" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
	
	<!-- 모달팝업 // 장비 수정 -->
	<div id="layer2" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>장비 관리</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th scope="row">장비 명<span class="font_red">*</span></th>
							<td><input type="text" class="inputTxt p100" name="equ_name" id="equ_name" /></td>
							<th scope="row">장비 수<span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="equ_num" id="equ_num"
								oninput="javascript:formatNumber('equ_num');"
								placeholder="숫자 입력"/>
							</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan=3><input type="text" class="inputTxt p100" name="equ_note" id="equ_note" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveEqu" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteEqu" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>