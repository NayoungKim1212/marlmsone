<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 강의계획서 관리</title>

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
                                   
<script type="text/javascript">
	var pageSize = 10;
	var pageBlock = 5;
	
	/* Onload Event */
	$(document).ready(function(){
		// 강의목록 조회
		fLectureList(1,'ing');
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				fsave();
				break;
			case 'btnWSave':
				fweek_plan_insert();
				break;
			case 'btnWadd':
				fweek_add();
				break;
			case 'btnWdel':
				fweek_del();
				break;
			case 'btnUpdate':
				fsave_adv();
				break;
			case 'btnClose':
				gfCloseModal();
				// fLectureList();
				break;
			case 'btnDel':
				fDelete_adv();
				break;
			}
		});
	}
	
	/** 계획서 폼 초기화 */
	function fInit(object) {
		
		if (object == "" || object == null) {
			$("#tutor_name,#tel,#mail,#lec_goal").val('');
			$("#week_plan").empty();
			$("#lec_sel option:eq(0)").prop("selected", true);
			$("#lec_type_name option:eq(0)").prop("selected", true);
			$("#lec_sort option:eq(0)").prop("selected", true);
			$("#lecrm_name option:eq(0)").prop("selected", true);

		} else {
			
			$("#lec_id option:eq(0)").prop("selected", true);
			$("#lec_sel").eq(0).val(object.lec_id);
			$("#tutor_id").val(object.tutor_id);
			$("#tutor_name").val(object.name);
			$("#tel").val(object.tel);
			$("#mail").val(object.mail);
			$("#lecrm_name").val(object.lecrm_id);
			$("#lec_goal").val(object.lec_goal);
			$("#slec_id").val(object.lec_name);
			$("#lec_sort").val(object.lec_sort);
			$("#lec_type_name").val(object.lec_type_id);
		}
	}
	
	/* 강의 목록 조회 */
	function fLectureList(currentPage, progress){
		if(progress =='ing'){
			$("#progress").val('ing');
		}else if(progress =='end'){
			$("#progress").val('end');
		}
		
		currentPage = currentPage || 1;
		progress=$("#progress").val();
		searchWord = $("#searchWord").val();
		searchKey = $("#searchKey").val();

		var param = {
			searchKey : searchKey,
			searchWord : searchWord,
			currentPage : currentPage,
			pageSize : pageSize,
			progress : progress
		}
		
		var resultCallback = function(data){
			fLectureListResult(data, currentPage);
		}
		
		callAjax("/tut/fLectureList.do", "post", "text", true, param, resultCallback);

	}
	
	/* 강의 목록 조회 콜백 함수 */
	function fLectureListResult(data, currentPage){
		
		$("#lectureList").empty();
		$("#lectureList").append(data);
		
		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();
		
		// 페이지네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlock, 'fLectureList');
		console.log("paginationHtml : " + paginationHtml);
		
		$("#lecturePlanPagination").empty().append(paginationHtml);
		
		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
		
	}
	
	/* 계획서 등록 모달 실행 */
	function fPopModal(lec_id){
		// 신규 저장
		if(lec_id == "" || lec_id == null){
			$("#action").val("I");
			
			// 계획서 모달 폼 초기화
			fInit();
			
			// 모달 팝업
			gfModalPop("#layer1");
		} else {
			// 수정
			$("#action").val("U");
			
			// 그룹 코드 단건 조회
			fSelec(lec_id);
		}
	}
	
	/** 계획서 단건 조회 */
	function fSelec(lec_id) {
		
		$("#tmp_lec").val(lec_id);
		
		var param = {
			lec_id : lec_id
		};

		var resultCallback = function(data) {
			fSelect_result(data);
		};

		callAjax("/tut/fLecInfo.do", "post", "json", true, param, resultCallback);
	}

	/** 계획서 단건 조회 콜백 함수*/
	function fSelect_result(data) {
		
		if (data.result == "SUCCESS") {
			// 모달 팝업
			gfModalPop("#layer1");

			// 계획서 폼 데이터 설정
			fInit(data.lec_info);
			fweek_plan(data.week_plan);

		} else {
			alert(data.resultMsg);
		}
	}
	
	/** 모달 강의정보 조회 */
	function flec_info() {

		var lec_id = $("#lec_sel").val();
		
		if(lec_id == null || lec_id == ""){
			fInit();
		} else {
			$("#tmp_lec").val(lec_id);
			
			var param = {
				lec_id : lec_id,
			}

			var resultCallback = function(data) {
				flec_info_result(data.lec_info,data.week_plan);
			};

			callAjax("/tut/fLecInfo.do", "post", "json", true, param, resultCallback);
		}
	}

	/** 강의정보 조회 콜백 */
	function flec_info_result(object,week) {
		
		$("#edit_table").find('input, textarea').empty();
		$("#lec_name").text(object.lec_name);
		$("#tutor_id").val(object.tutor_id);
		$("#tutor_name").val(object.name);
		$("#tel").val(object.tel);
		$("#mail").val(object.mail);
		$("#lecrm").val(object.lecrm_name);
		$("#lec_goal").val(object.lec_goal);
		$("#lec_type_id").val(object.lec_type_name);
		$("#lec_sort").val(object.lec_sort);
		 
		fSelec(object.lec_id);
	}

	function flec_sel(){
		$("#tmp_lec").val($("#lec_sel").val());
	}
	
	//계획서 저장 validation 
	function fValidate_lecInfo() {

		var chk = checkNotValue(
				[ 
				  	[ "lec_sel", "과목명을 선택해주세요." ]
				  , [ "lec_type_name", "과정명을 선택해주세요." ]
				  , [ "lec_sort", "대상자를 선택해주세요." ]
				  , [ "lecrm_name", "강의실을 선택해주세요." ]
				]
		
		)

		if (!chk) {
			return;
		}

		return true;
	} 

	/** 계획서 저장 */
	function fsave() {
		// vaildation 체크
		if (!fValidate_lecInfo()) {
			return;
		}
		
		var param = {
				lec_id :  $("#tmp_lec").val(),
				tutor_id :$("#tutor_id").val(),
				lec_goal :$("#lec_goal").val(),
				lecrm_id :$("#lecrm_name").val(),
				lec_type_id :$("#lec_type_name").val(),
				lec_sort : $("#lec_sort").val()
			}
		
		fweek_plan_insert();

		 var resultCallback = function(data) {
			fsave_result(data);
		};

		callAjax("/tut/savePlan.do", "post", "json", true, param, resultCallback);
		
	}

	/** 계획서 저장 콜백 함수 */
	function fsave_result(data) {

		// 목록 조회 페이지 번호
		var currentPage = "1";
		if ($("#action").val() != "I") {
			currentPage = $("#currentPage").val();
		}

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			// alert(data.resultMsg);

			// 모달 닫기
			// gfCloseModal();

			// fLectureList(1,'ing');

		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
	}

	
	/* 주차 칸 추가  */
	function fweek_add() {
		var trCnt = $('#week_table tr').length;

		var innerHtml = "";
		innerHtml += '<tr>';
		innerHtml += '    <td class="week">' + trCnt + "주차" + '</td>';
		innerHtml += '    <td><input type="text" name="learn_goal" class="inputTxt p100 learn_goal"></td>';
		innerHtml += '    <td><input type="text" name="learn_con" class="inputTxt p100 learn_con"></td>';
		innerHtml += '</tr>';

		$('#week_table > tbody:last').append(innerHtml);
	}

	// 주간 계획 삭제
	function fweek_del() {
		var trCnt = $('#week_table tr').length;

		if ($("#action").val() != "I") {
			var lec_id = $("#tmp_lec").val();
			var week = $('#week_table > tbody:last > tr:last .week').text();

			$.ajax({
				url : "delWeekPlan.do",
				type : "post",
				data : {
					lec_id : lec_id,
					week : week
				},
				success : function(result) {
					alert(result.resultMsg);
				}

			});
			
			$('#week_table > tbody:last > tr:last').remove();
		} else {
			$('#week_table > tbody:last > tr:last').remove();
		}
	}

	// 주간 계획 등록
	function fweek_plan_insert() {
		var lec_id = $("#tmp_lec").val();
		var week = new Array();
		var learn_goal = new Array();
		var learn_con = new Array();

		$(".week").each(function() {
			week.push($(this).text());
		});

		$(".learn_goal").each(function() {
			learn_goal.push($(this).val());
		});
		
		$(".learn_con").each(function() {
			learn_con.push($(this).val());
		});

		$.ajax({
			url : "saveWeekplan.do",
			type : "post",
			data : {
				lec_id : lec_id,
				week : week,
				learn_goal : learn_goal,
				learn_con : learn_con
			},
			success : function(result) {
				alert(result.resultMsg);
				
				// 모달 닫기
				gfCloseModal();

				fLectureList(1,'ing');
			}

		});

	}
	
	// 주간 계획 목록 조회
	function fweek_plan(object) {
		console.log("주차 계획 : " , object);
		var innerHtml = "";
		if (object == "" || object == null || object == undefined) {
			$("#week_plan").empty();

		} else {
			$("#week_plan").empty();
			$.each(object,
							function(index, item) {
								innerHtml += '<tr>';
								innerHtml += '    <td class="week">' + item.week + '</td>';
								innerHtml += '    <td><input type="text" value="'+item.learn_goal+'" name="learn_goal" class="inputTxt p100 learn_goal"></td>';
								innerHtml += '    <td><input type="text" value="'+item.learn_con+'" name="learn_con" class="inputTxt p100 learn_con"></td>';
								innerHtml += '</tr>';

							})
			$('#week_table > tbody:last').append(innerHtml);
		}
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
<input type="hidden" name="progress" id="progress" value="">	
<input type="hidden" id="currentPage" value="1">
<input type="hidden" name="action" id="action" value="">
<input type="hidden" id="tmp_lec"  name="lec_id"  value="">

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
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">학습지원</span> 
							<span class="btn_nav bold">강의계획서 </span> 
							<a href="../tut/lecturePlan.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
								<span>강의계획서 관리</span><span class="fr">
									<strong> 강 의 명&nbsp;</strong>
									<input type="text" id="searchWord" name="searchWord" style="height: 28px;"> 
									<a class="btnType blue" href="javascript:fLectureList()" name="search">
									<span id="searchEnter">검색</span></a> 
								</span>
							</p>
							
							<a href="javascript:fLectureList(1,'ing')" class="btnType blue"><span>진행중 강의</span></a> 
							<a href="javascript:fLectureList(1,'end')" class="btnType red"><span>종료된 강의</span></a>
							
						
						<div class="divLectureList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="40%">
									<col width="30%">
									<col width="30%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">분류</th>
										<th scope="col">강의명</th>
										<th scope="col">기간</th>
										<th scope="col">수강인원</th>
									</tr>
								</thead>
								<tbody id="lectureList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="lecturePlanPagination"> </div>
				
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 800px; height:600px; overflow:auto"; >
			<dl>
				<dt>
					<strong>강의 계획서</strong>
				</dt>
				<dd class="content">
					<table class="row" id="edit_table" name="edit_table">
						<caption>caption</caption>
						<colgroup>
							<col width="120px">
							<col width="200px">
							<col width="100px">
							<col width="150px">
						</colgroup>

						<tbody>
							<tr id="load">
							<th scope="row">과목<span class="font_red"> *</span></th>
							<td colspan="4">
									<select value="" id="lec_sel" onchange="flec_info()" class="inputTxt p100">
										<option value="">과목명 선택</option>
										<c:forEach items="${lecList}" var="list">
											<option value="${list.lec_id}">${list.lec_name}</option>
										</c:forEach> 
									</select>
								</td>
							
							</tr>
							<tr>
								<th scope="row">강의분류<span class="font_red"> *</span></th>
								
								<td>
									<select name="lec_type_name" id="lec_type_name">
										<option value="">과정명 선택</option>
										<c:forEach items="${typeList}" var="list">
											<option value="${list.lec_type_id}">${list.lec_type_name}</option>
										</c:forEach>
								  </select>
								</td>	
								<th scope="row">대상자<span class="font_red"> *</span></th>
								<td>
									<select name="lec_sort" id="lec_sort">
											<option value="">대상자 선택</option>
											<option value="실업자">실업자</option>
											<option value="직장인">직장인</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row">강사명</th>
								<td>
									<input type="text" name="tutor_name" id="tutor_name" class="form-control inputTxt p100" readonly style="background-color:#DCDCDC;">
									<input type="hidden" name="tutor_id" id="tutor_id">
								</td>
								<th scope="row">강의실<span class="font_red"> *</span></th>
								<td>
									<select name="lecrm_id" id="lecrm_name">
										<option value="">강의실 선택</option>
										<c:forEach items="${lecRoom}" var="list">
											<option value="${list.lecrm_id}">${list.lecrm_name}</option>
										</c:forEach>
								  	</select>
								</td>	
							</tr>
							<tr>
								<th scope="row">이메일</th>
								<td>
									<input type="text" name="mail" id="mail" class="form-control inputTxt p100" readonly style="background-color:#DCDCDC;">
								</td>
								<th scope="row">연락처</th>
								<td>
									<input type="text" name="tel" id="tel" class="form-control inputTxt p100" readonly style="background-color:#DCDCDC;">
								</td>
							</tr>
							<tr>
								<th scope="row">수업목표</th>
								<td colspan="3">
									<textarea name="lec_goal" id="lec_goal" style="resize:none"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
					<!-- <div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div> -->
				</dd>
			</dl>
			<dl>
				<dd class="content">
					<a href="" class="btnType blue" id="btnWadd" name="btn">
						<span>주차 추가</span>
					</a> 
					<a href="" class="btnType red" id="btnWdel" name="btn">
						<span>주차 삭제</span>
					</a>
					<table id="week_table" class="col2 mb10">
						<thead>
							<tr>
								<th scope="col">주차수</th>
								<th scope="col">학습목표</th>
								<th scope="col">학습내용</th>
							</tr>
						</thead>
							<tbody id="week_plan">
						</tbody>
					</table>
					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
		</div>
</form>
</body>
</html>