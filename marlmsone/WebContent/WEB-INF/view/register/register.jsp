<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>강의 관리</title>
<!-- sweet alert import -->

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
	var pageSize = 5; // -- 한 페이지 당 몇개 보여줄 지
	var pageBlocksize = 5; // -- 페이지 당 번호

	$(document).ready(function(e) {
		console.log('test123')
		fRegisterButtonClickEvent();
		fListLec(); // 강의 리스트
		$("#std").hide();
	})

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {

		$("#searchEnter").click(function(e) {
			// ?
			e.preventDefault();

			fListLec();
		});
		// a 태그의 이름이 btn 인 경우
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			// 현재 입력된 객체의 id 를 가져옴
			var btnId = $(this).attr('id');

			// id 값으로 행동을 분기
			switch (btnId) {
			case 'btnSave':
				Save();
				break;
			case 'btnDelete':
				deletelec();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	/* 강의 목록 조회 */
	function fListLec(currentPage) {

		currentPage = currentPage || 1;

		console.log("currentPage : " + currentPage + " searchKey : ", searchKey
				+ " searchInfo : ", searchInfo);

		var param = {
			pageSize : pageSize,
			currentPage : currentPage,
			searchInfo : $("#searchInfo").val(),
			searchKey : $("#searchKey").val()
		}

		console.log("param : ", param);

		$.ajax({
			url : '/register/listLec.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "text",
			success : function(data) {
				console.log(data);
				getLecList(data, currentPage);
			},
			error : function(error) {
				console.log(error)
			}
		})

	}

	function getLecList(data, currentPage) {
		console.log("콜스택 체크 : " + data);
		$("#listLecture").empty().append(data);
		var totCnt = $("#lec_Total").val();
		console.log("totCnt : " + totCnt);

		var paginationHtml = getPaginationHtml(currentPage, totCnt, pageSize,
				pageBlocksize, 'fListLec');

		console.log(currentPage);
		console.log(totCnt);
		console.log(pageSize);
		console.log(pageBlocksize);

		console.log("paginationHtml : " + paginationHtml);

		$("#Pagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage);
	}

	// 등록 모달 팝업 하는 함수
	function newreg() {
		init();

		// layer1 을 모달 팝업 -> 닫기
		gfModalPop("#layer1");
		//Close();
	}

	function init(data) {
		console.log("init 값 확인 : ", data)

		if (data != null) {
			$("#lec_id").val(data.lec_id);
			$("#lecnm").val(data.lec_name);
			$("#maxnum").val(data.max_pnum);
			$("#lec_type_id").val(data.lec_type_id);
			$("#tutor_id").val(data.tutor_id);
			$("#lecrm_id").val(data.lecrm_id);
			$("#proday").val(data.process_day);
			$("#startday").val(data.start_date);
			$("#endday").val(data.end_date);
			$("#action").val("U"); // 수정일 때 U 값으로 초기화
			
		} else {
			$("#lec_id").val("");
			$("#lecnm").val("");
			$("#maxnum").val("");
			$("#lec_type_id").val("");
			$("#tutor_id").val("");
			$("#lecrm_id").val("");
			$("#proday").val("");
			$("#startday").val("");
			$("#endday").val("");
			$("#action").val("I"); // 신규 등록일 때 I 값으로 초기화
		}
	}

	function Save() {

		if (!fValidate()) {
			return;
		}

		// 들어온 값을 저장하기위해 값을 저장
		var param = {
			lec_id : $("#lec_id").val(),
			lec_name : $("#lecnm").val(),
			lec_type_id : $("#lec_type_id").val(),
			max_pnum : $("#maxnum").val(),
			tutor_id : $("#tutor_id").val(),
			lecrm_id : $("#lecrm_id").val(),
			process_day : $("#proday").val(),
			start_date : $("#startday").val(),
			end_date : $("#endday").val(),
			action : $("#action").val()
		}
		console.log("param 확인 " , param);
		console.log(param.lec_name);

		$.ajax({
			url : '/register/saveRegister.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "json",
			success : function(data) {
				console.log(data);
				fsave_result(data);
			},
			error : function(error) {
				console.log(error)
			}
		})
	}

	function fsave_result(data) {
		var currentPage = "1";

		if (data.result == "SUCCESS") {
			alert(data.resultMsg);
			gfCloseModal();					
			fListLec($("#currentPage").val());	 
		}
		if ($("#action").val() != "I") {
			currentPage = $("#currentPage").val();
		}
		
	}

	function fValidate() {

		var chk = checkNotEmpty(
				[ 
				  [ "lecnm", "강의명을 입력해주세요." ],
				  [ "tutor_id", "강사명을 선택해주세요" ],
				  [ "startday", "개강일을 입력해주세요" ],
				  [ "endday", "종강일을 입력해주세요" ]
				 ]

		)

		if (!chk) {
			return;
		}

		return true;
	}
	/* 
	function modify(lec_id, action) {
		console.log("id : " , lec_id);
		console.log("action : " , action);
		
		var param = {
				lec_id : lec_id,
				action : action
		} 
		
		console.log("param : ", param);
		
		$.ajax({
			url : '/register/lecInfo.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "json",
			success : function(data) {
				console.log(data);
				gfModalPop("#layer1");
				init(data.lec_info);
			},
			error : function(error) {
				console.log(error)
			}
		})
	} */
	
	function modify(lec_id, action) {
		console.log("id : " , lec_id);
		console.log("action : " , action);
		
		var param = {
				lec_id : lec_id,
				action : action
		} 
		
		console.log("param : ", param);
		
		$.ajax({
			url : '/register/lecInfo.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "json",
			success : function(data) {
				console.log(data);
				gfModalPop("#layer1");
				init(data.lec_info);
			},
			error : function(error) {
				console.log(error)
			}
		})
	}
	
	function deletelec(lec_id) {
	//	$("#action").val("D");
		
		var param = { action: "D", lec_id: lec_id };
		console.log("삭제param : ", param);
		
		$.ajax({
			url : '/register/delRegister.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "json",
			success : function(result) {
				console.log(result);
				alert(result.resultMsg);						
				fListLec($("#currentPage").val());				
			},
			error : function(error) {
				console.log(error)
				alert("강의를 삭제할 수 없습니다.");
			}
		})
	}

	/* 강의 별 학생 리스트(아이디) */
	function stdList(lec_id) {
		$("#lec_id").val(lec_id);
		stdSearch();
	}

	/* 강의 별 학생 리스트(페이지)*/
	function stdSearch(currentPage) {
		$("#std").show();

		currentPage = currentPage || 1;

		console.log("stdSearch탐 : " + currentPage);

		var param = {
			lec_id : $("#lec_id").val(),
			currentPage : currentPage,
			pageSize : pageSize
		};
		console.log("param : ", param);

		$.ajax({
			url : '/register/stdList.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "text",
			success : function(data) {
				console.log(data)
				getStdList(data, currentPage);
			},
			error : function(error) {
				console.log(error)
			}
		})
	}

	function getStdList(data, currentPage) {
		console.log("data: ", data);

		$("#div_std_list").show();
		$("#stdPagination").show();
		$("#listStd").empty().append(data);

		var totCnt = $("#std_Total").val();
		console.log("totCnt : " + totCnt);

		var paginationHtml = getPaginationHtml(currentPage, totCnt, pageSize,
				pageBlocksize, 'stdSearch');

		console.log(currentPage);
		console.log(totCnt);
		console.log(pageSize);
		console.log(pageBlocksize);

		console.log("paginationHtml : " + paginationHtml);

		$("#stdPagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage);
	}
	
	function checkDate(){
		var date = document.getElementsByName("date")[0];

		  // 사용자 입력값은 모두 숫자만 받는다.(나머지는 ""처리)
		  var val = date.value.replace(/\D/g, "");
		  var leng = val.length;
		  
		  // 출력할 결과 변수
		  var result = '';
		  
		  // 5개일때 - 20221 : 바로 출력
		  if(leng < 6) result = val;
		  // 6~7일 때 - 202210 : 2022-101으로 출력
		  else if(leng < 8){
		  	result += val.substring(0,4);
		    result += "-";
		    result += val.substring(4);
		  // 8개 일 때 - 2022-1010 : 2022-10-10으로 출력
		  } else{
		  	result += val.substring(0,4);
		    result += "-";
		    result += val.substring(4,6);
		    result += "-";
		    result += val.substring(6);
		  }
		  date.value = result;

	}
</script>
</head>
<body>
	<form id="myForm" action="" method="">

		<!--
		신규와 수정을 동일한 창으로 넘기기 때문에 flag 값을 주어 확인할 수 있도록 한다
		초기 값 = 빈값
		수정할 때, 게시판 번호 사용하기 위해서 hidden 
	 -->
		<input type="hidden" id="action" name="action" value="" /> 
		<input type="hidden" id="lec_id" name="lec_id" value="" /> 
		<input type="hidden" id="currentPage" name="currentPage" value="1" />

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
								<a href="../register/registerListControl.do"
									class="btn_set home">메인으로</a> <span class="btn_nav bold">학습관리</span>
								<span class="btn_nav bold">강의목록 </span> <a
									href="../register/registerListControl.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>강의목록</span> <span class="fr"> <!-- searchbar --> <select
									id="searchKey" name="searchKey" style="width: 80px;">
										<option value="all" id="all" selected="selected">전체</option>
										<option value="lec_name" id="lec_name">강의명</option>
										<option value="t_name" id="t_name">강사명</option>
								</select> <input type="text" id="searchInfo" name="searchInfo"
									class="form-control" placeholder="" style="height: 28px;">
									<!-- // searchbar --> <!-- button --> <a class="btnType blue"
									href="" name="searchEnter" id="searchEnter"><span>검색</span></a>
									<a class="btnType blue" href="javascript:newreg();"
									name="newreg" id="newreg"><span>과정등록</span></a>

								</span>
							</p>

							<div class="div_lec_list">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="25%">
										<col width="15%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">강의번호</th>
											<th scope="col">강의명</th>
											<th scope="col">담당교수</th>
											<th scope="col">강의실</th>
											<th scope="col">수강인원</th>
											<th scope="col">기간</th>
											<th scope="col">수정/삭제</th>
										</tr>
									</thead>
									<tbody id="listLecture"></tbody>
								</table>
							</div>
							<div class="paging_area" id="Pagination"
								style="margin-bottom: 50px;"></div>

							<div id="std">
								<p class="conTitle">
									<span>학생정보</span> <span class="fr">

										<div class="div_std_list">
											<table class="col">
												<caption>caption</caption>
												<colgroup>
													<col width="20%">
													<col width="20%">
													<col width="20%">
												</colgroup>

												<thead>
													<tr>
														<th scope="col">학번</th>
														<th scope="col">학생명</th>
														<th scope="col">과정명</th>
													</tr>
												</thead>
												<tbody id="listStd"></tbody>
											</table>
										</div>
										<div class="paging_area" id="stdPagination"></div>

									</span>
								</p>
							</div>
							<!--// content -->

							<h3 class="hidden">풋터 영역</h3>
							<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>

		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>과정 등록</strong>
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
								<th scope="row">강의명 <span class="font_red">*</span></th>
								<td colspan=3><input type="text" class="inputTxt p100"
									name="lecnm" id="lecnm" /></td>
							</tr>
							<tr>
								<th scope="row">강의 분류</th>
								<td colspan="3"><select class="inputTxt p100"
									name="lec_type_id" id="lec_type_id">
									<option value="" id="">강의 분류 선택</option>
										<c:forEach items="${typeList}" var="list">
											<option value="${list.lec_type_id}">${list.lec_type_name}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<th scope="row">최대인원</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="maxnum" id="maxnum" /></td>
							</tr>
							<tr>
								<th scope="row">강사명 <span class="font_red">*</span></th>
								<td colspan="3"><select class="inputTxt p100" id="tutor_id"
									name="tutor_id">
									<option value="" id="">강사 선택</option>
										<c:forEach items="${tutList}" var="list">
											<option value="${list.loginID}">${list.t_name}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<th scope="row">강의실</th>
								<td colspan="3"><select class="inputTxt p100"
									name="lecrm_id" id="lecrm_id">
									<option value="" id="">강의실 선택</option>
										<c:forEach items="${lecrmList}" var="list">
											<option value="${list.lecrm_id}">${list.lecrm_name}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<th scope="row">과정일수</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="proday" id="proday" /></td>
							<tr>
								<th scope="row">개강일 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="date" id="startday" oninput="checkDate()"/></td>
							</tr>
							<tr>
								<th scope="row">종강일 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="date" id="endday" oninput="checkDate()"/></td>
							</tr>

						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>등록</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!--// 모달팝업 -->
	</form>
</body>
</html>
