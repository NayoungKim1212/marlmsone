<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>취업 정보</title>
<!-- sweet alert import -->

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
	var pageSize = 5; // -- 한 페이지 당 몇개 보여줄 지
	var pageBlocksize = 5; // -- 페이지 당 번호

	$(document).ready(function(e) {
		console.log('employ')
		fRegisterButtonClickEvent();
		fRegisterButtonClickEvent2();
		fListEmp(); // 취업 목록 리스트
		stdSearch();
	})

	function fRegisterButtonClickEvent() {

		$("#searchEnter").click(function(e) {
			// ?
			e.preventDefault();

			fListEmp();
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
			case 'btnSaveEqu':
				SaveEqu();
				break;
			case 'btnDeleteEqu':
				DeleteEqu();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	function fRegisterButtonClickEvent2() {

		$("#searchEnter1").click(function(e) {
			// ?
			e.preventDefault();

			stdSearch();
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
			case 'btn_employ':
				btn_employ();
				break;
			case 'btnSaveEqu':
				SaveEqu();
				break;
			case 'btnDeleteEqu':
				DeleteEqu();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	/* 취업 목록 조회 */
	function fListEmp(currentPage) {

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
			url : '/employ/listEmp.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "text",
			success : function(data) {
				console.log(data);
				getListEmp(data, currentPage);
			},
			error : function(error) {
				console.log(error)
			}
		})

	}

	function getListEmp(data, currentPage) {
		console.log("data : ", data);
		$("#listEmp").empty().append(data);
		var totCnt = $("#emp_Total").val();
		console.log("totCnt : " + totCnt);

		var paginationHtml = getPaginationHtml(currentPage, totCnt, pageSize,
				pageBlocksize, 'fListEmp');

		console.log(currentPage);
		console.log(totCnt);
		console.log(pageSize);
		console.log(pageBlocksize);

		console.log("paginationHtml : " + paginationHtml);

		$("#Pagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage);
	}

	/* 강의 별 학생 리스트(아이디) */
	function stdList(std_id) {
		$("#std_id").val(std_id);
		stdSearch();
	}

	/* 강의 별 학생 리스트(페이지)*/
	function stdSearch(currentPage) {

		currentPage = currentPage || 1;

		console.log("stdSearch탐 : " + currentPage);

		var param = {
			loginID : $("#std_id").val(),
			currentPage : currentPage,
			pageSize : pageSize,
			searchInfo1 : $("#searchInfo1").val(),
			searchKey1 : $("#searchKey1").val()
		};

		console.log("학생param : ", param);

		$.ajax({
			url : '/employ/empstdList.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "text",
			success : function(data) {
				console.log(data);
				getStdList(data, currentPage);
			},
			error : function(error) {
				console.log(error)
			}
		})
	}

	function getStdList(data, currentPage) {
		console.log("학생data: ", data);

		$("#div_std_list").show();
		$("#EmpStdPagination").show();
		$("#listEmpStd").empty().append(data);

		var totCnt = $("#std_Total").val();
		console.log("학생totCnt : " + totCnt);

		var paginationHtml = getPaginationHtml(currentPage, totCnt, pageSize,
				pageBlocksize, 'stdSearch');

		console.log(currentPage);
		console.log(totCnt);
		console.log(pageSize);
		console.log(pageBlocksize);

		console.log("학생paginationHtml : " + paginationHtml);

		$("#EmpStdPagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage);
	}

	function std_Detail(std_id) {
		console.log("id : ", std_id);
		
		var param = {
				std_id : std_id,
		}
		console.log("param : ", param);
		
		$.ajax({
			url : '/employ/stdDetail.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "text",
			success : function(data) {
				console.log(data);
				
				$("#lecList").empty().append(data);
				/* gfModalPop("#layer1");
				
				init(data.std_info);
				listEmpStd(data.std_info); */
			},
			error : function(error) {
				console.log(error)
			}
		})
	}
	
	function listEmpStd(data) {
		console.log("listEmpStd", data);
		
		$('#listEmpStd').empty();
		
		$('#listEmpStd').append(data);
	}
	
	/** 유저 단건 조회 */
	function fstd_info(std_id) {
		console.log("std_id : ", std_id);
		$("#std_id").val(std_id);
		// $("#rstdval").val(loginID);

		var param = {
				std_id : std_id
		};

		var resultCallback = function(data) {
			fstd_info_result(data);
		};

		callAjax("/employ/stdInfoDetail.do", "post", "json", true, param,
				resultCallback);
	}

	/** 유저 단건 조회 콜백 함수*/
	function fstd_info_result(data) {
		console.log("유저 단건 조회 콜백 함수 : ", data);

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			fInit_std(data.std_detail);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 학생 정보출력  */
	function fInit_std(object) {
		console.log("fInit : ", object);
		
		$("#loginID").val(object[0].std_id);
		$("#std_num").val(object[0].std_num);
		$("#std_name").val(object[0].name);
		$("#tel").val(object[0].tel);
		$("#sex").val(object[0].sex);
		$("#mail").val(object[0].mail);
		
		/* if(object.addr != null){
			$("#std_addr").text(object.addr.replace(/,/gi, " "));
		}
		
		$("#std_mail").text(object.mail); */

		std_Detail(object[0].std_id);
	}
	
	// 등록 모달 팝업 하는 함수
	function modify(std_id, action) {
		console.log("loginID : " , std_id);

		$.ajax({
			url : '/employ/stdinfo.do',
			type : "POST",
			data : {
				std_id : std_id,
				action : action
			},
			async : true,
			dataType : "json",
			success : function(data) {
				console.log("등록 모달 데이터" ,data);
				init(data.stdinfo, action);
				$("#lecList").empty().append(data);
				/* gfModalPop("#layer1");
				
				init(data.std_info);
				listEmpStd(data.std_info); */
			},
			error : function(error) {
				console.log(error)
			}
		})
		

		// layer1 을 모달 팝업 -> 닫기
		gfModalPop("#layerB");
		//Close();
	}
	
	function init(data, action) {
		console.log("init 값 확인 : ", data);
		console.log("action : ", action);
		
		if(action == "I") {
			$("#loginID").val(data.loginID);
			$("#stdName").val(data.name);
			$("#stdtel").val(data.tel);
			$("#comp_Name").val(""); 
			$("#employ_day").val("");
			$("#resign_day").val("");
			$("#action").val("I");
		}
		if(action == "U"){
			$("#loginID").val(data.loginID);
			$("#stdName").val(data.name);
			$("#stdtel").val(data.tel);
			$("#comp_Name").val(data.comp_name); 
			$("#employ_day").val(data.employ_day);
			$("#resign_day").val("");
			$("#action").val("U");
		}
	}
	
	function btn_employ() {
		
		// vaildation 체크
		if (!fValidate_empInfo()) {
			return;
		}
		
		console.log($("#comp_Name").val());
		console.log("loginId : ", std_id);
		
		$.ajax({
			url : '/employ/stdEmploy.do',
			type : "POST",
			data : {
				std_id : $("#loginID").val(),
				comp_name : $("#comp_Name").val(),
				employ_day : $("#employ_day").val(),
				resign_day : $("#resign_day").val(),
				action : $("#action").val()
			},
			async : true,
			dataType : "json",
			success : function(data) {
				console.log(data);
				btn_employ_result(data);
				
				//$("#listEmpStd").empty().append(data);
				/* gfModalPop("#layer1");
				
				init(data.std_info);
				listEmpStd(data.std_info); */
			},
			error : function(error) {
				console.log(error)
			}
		})
	}
	
	function btn_employ_result(data) {
		
		var currentPage = "1";
		console.log("여기 탔나");
		
		if (data.result == "SUCCESS") {
			alert(data.resultMsg);
			gfCloseModal();
			fListEmp(); 
			stdSearch();
		}
	}
	
	//계획서 저장 validation 
	function fValidate_empInfo() {

		var chk = checkNotValue(
				[ 
				  	[ "comp_Name", "회사명을 선택해주세요." ]
				]
		
		)
		var cnk = checkNotEmpty(
				[
				 	[ "employ_day", "입사일을 적어주세요."]
				 ]		
		)

		 if (!chk) {
			return;
		}
		
		 if (!cnk) {
			return;
		}
		return true;
	}
	
	// 취업 목록 삭제
	function delete_emp(std_id) {
		
		var param = {
				std_id : std_id
		};
		
		$.ajax({
			url : '/employ/delEmploy.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "json",
			success : function(result) {
				console.log(result);
				alert(result.resultMsg);						
				fListEmp($("#currentPage").val());				
			},
			error : function(error) {
				console.log(error)
			}
		})
	}
	
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="action" name="action" value="" /> <input
			type="hidden" id="std_id" name="std_id" value="" /> <input
			type="hidden" id="currentPage" name="currentPage" value="1" />
			<input type="hidden" id="tmp_user" name="loginID" value=""> 

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
								<a href="../employ/employmentInfo.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">취업관리</span> <span
									class="btn_nav bold">취업 정보 관리 </span> <a
									href="../employ/employmentInfo.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>취업목록</span> <span class="fr"> <!-- searchbar --> <select
									id="searchKey" name="searchKey" style="width: 80px;">
										<option value="all" id="all" selected="selected">전체</option>
										<option value="name" id="name">학생명</option>
										<option value="comp_name" id="comp_name">회사명</option>
								</select> <input type="text" id="searchInfo" name="searchInfo"
									class="form-control" placeholder="" style="height: 28px;">
									<!-- // searchbar --> <!-- button --> <a class="btnType blue"
									href="" name="searchEnter" id="searchEnter"><span>검색</span></a>
								</span>
							</p>
							<div class="employList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="25%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">학번</th>
											<th scope="col">학생명</th>
											<th scope="col">연락처</th>
											<th scope="col">입사일</th>
											<th scope="col">퇴사일</th>
											<th scope="col">회사명</th>
											<th scope="col">재직여부</th>
											<th scope="col">수정/삭제</th>
										</tr>
									</thead>
									<tbody id="listEmp"></tbody>
								</table>
							</div>
							<div class="paging_area" id="Pagination"
								style="margin-bottom: 50px;"></div>

							<div id="EmpStd">
								<p class="conTitle">
									<span>학생정보</span> <span class="fr"> <!-- searchbar --> <select
										id="searchKey1" name="searchKey1" style="width: 80px;">
											<option value="all1" id="all1" selected="selected">전체</option>
											<option value="t_name" id="t_name">학생명</option>
											<option value="lec_nm" id="lec_nm">강의명</option>
									</select> <input type="text" id="searchInfo1" name="searchInfo1"
										class="form-control" placeholder="" style="height: 28px;">
										<!-- // searchbar --> <!-- button --> <a class="btnType blue"
										href="" name="searchEnter1" id="searchEnter1"><span>검색</span></a>

										<div class="div_std_list">
											<table class="col">
												<caption>caption</caption>
												<colgroup>
													<col width="10%">
													<col width="10%">
													<col width="15%">
													<col width="15%">
													<col width="15%">
													<col width="10%">
												</colgroup>

												<thead>
													<tr>
														<th scope="col">학번</th>
														<th scope="col">학생명</th>
														<th scope="col">연락처</th>
														<th scope="col">강의명</th>
														<th scope="col">가입일자</th>
														<th scope="col">등록</th>
													</tr>
												</thead>
												<tbody id="listEmpStd"></tbody>
											</table>
										</div>
										<div class="paging_area" id="EmpStdPagination"></div>

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
	</form>

	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>학생 정보</strong>
			</dt>

			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<tbody>
						<tr>
							<th scope="row">ID</th>
							<td><input type="text" class="inputTxt p100"
								id="loginID" name="loginID" /></td>
							<th scope="row">학번</th>
							<td><input type="text" class="inputTxt p100"
								id="std_num" name="std_num" /></td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td><input type="text" class="inputTxt p100"
								id="std_name" name="std_name" /></td>
							<th scope="row">전화 번호</th>
							<td><input type="text" class="inputTxt p100"
								id="tel" name="tel" /></td>
						<tr>

							<th scope="row">성별</th>
							<td><input type="text" class="inputTxt p100"
								id="sex" name="sex" /></td>
							<th scope="row">이메일</th>
							<td><input type="text" class="inputTxt p100"
								id="mail" name="mail" /></td>
						</tr>
						<tr>
							<td colspan="6">
								<p class="conTitle mt50">
									<span>수강 내역</span>
								</p>
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="20%">
										<col width="30%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강의ID</th>
											<th scope="col">강의명</th>
											<th scope="col">기간</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody id="lecList"></tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
		<!-- 취업 등록  -->
		<form id="employ_form">
		<div id="layerB" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" value="" name="std_id" id="rstdval">
			<dl>
				<dt>
					<strong>취업 등록</strong>
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
								<tr>
								<th scope="row">학생명</th>
								<td colspan=3><input type="text" class="inputTxt p100"
									name="stdName" id="stdName" readonly /></td>
							</tr>
								<tr>
								<th scope="row">회사명 <span class="font_red">*</span></th>
								<td colspan="10"><input type="text" class="inputTxt p100"
									name="comp_Name" id="comp_Name" />
								</td>
							</tr>
							<tr>
								<th scope="row">연락처</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="stdtel" id="stdtel"  readonly /></td>
							</tr>
							<tr>
								<th scope="row">입사일 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="employ_day" id="employ_day"/></td>
							</tr>
							<tr>
								<th scope="row">퇴사일</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="resign_day" id="resign_day" /></td>
							</tr>
						</tbody>
					</table>
				<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btn_employ" name="btn"><span>등록</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		</form>
</body>
</html>