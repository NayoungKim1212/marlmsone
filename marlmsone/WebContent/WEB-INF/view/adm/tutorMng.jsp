<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>강사 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/register.js"></script>

<script type="text/javascript">
	//강사 목록 페이징 설정
	var pageSize = 10;
	var pageBlockSize = 5;

	/** OnLoad event */
	$(document).ready(function() {

		//강사목록 조회
		flist_tut();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

		$("#to_date").change(function() {
			if ($("#to_date").val() < $("#from_date").val()) {
				alert("최소기간 보다 작을수 없습니다.")
				$("#to_date").val('');
			}
		});
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnSave':
				fsave_adv();
				break;
			case 'RegisterCom':
				IDCheck('BRegisterForm');
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});
	}

	/** 강사 목록 조회 */
	function flist_tut(currentPage, user_type) {

		currentPage = currentPage || 1;
		user_type = user_type || '';
		searchWord = $("#searchWord").val();
		searchKey = $("#searchKey").val();
		from_date = $("#from_date").val();
		to_date = $("#to_date").val();
		lec_id = $("#lec_list").val();
		
		if(from_date != '' && to_date == ''){
			alert("끝 날짜를 선택해주세요.");
			return;
		} else if(from_date == '' && to_date != ''){
			alert("시작 날짜를 선택해주세요.");
			return;
		}
		

		$("#tmp_type").val(user_type);

		var param = {
			searchKey : searchKey,
			searchWord : searchWord,
			lec_id : lec_id,
			currentPage : currentPage,
			pageSize : pageSize,
			from_date : from_date,
			to_date : to_date,
			user_type : user_type
		}

		var resultCallback = function(data) {
			flist_tut_result(data, currentPage);
		};

		callAjax("/adm/list_tut.do", "post", "text", true, param,
				resultCallback);
	}

	/** 강사목록 조회 콜백 함수 */
	function flist_tut_result(data, currentPage) {

		// 기존 목록 삭제
		$('#tut_list').empty();

		// 신규 목록 생성
		$('#tut_list').append(data);

		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();

		// 페이지 네비게이션 생성
		var user_type = $("#tmp_type").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'flist_tut', [ user_type ]);
		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);

	}

	/** 유저 단건 조회 */
	function ftut_info(loginID) {
		$("#tmp_user").val(loginID);

		var param = {
			loginID : loginID
		};

		var resultCallback = function(data) {
			ftut_info_result(data);
		};

		callAjax("/adm/user_info.do", "post", "json", true, param,
				resultCallback);
	}

	/** 유저 단건 조회 콜백 함수*/
	function ftut_info_result(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			fInit_tut(data.user_model);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 학생 정보출력  */
	function fInit_tut(object) {
		$("#tut_id").text(object.loginID);
		$("#tut_num").text(object.tut_num);
		$("#tut_name").text(object.name);
		$("#tut_birth").text(object.birth);
		$("#tut_tel").text(object.tel);
		$("#tut_sex").text(object.sex);
		if(object.addr != null){
			$("#tut_addr").text(object.addr.replace(/,/gi, " "));
		}
		$("#tut_mail").text(object.mail);

		fslist_lecture(object.loginID);
	}

	/**학생 수강 목록 조회 */
	function fslist_lecture(loginID) {

		var param = {
			loginID : loginID,
			user_type : 'b'
		}

		var resultCallback = function(data) {
			flist_lecture_result(data);
		};

		callAjax("/adm/slist_lec.do", "post", "text", true, param,
				resultCallback);
	}

	/** 모달 강의목록 콜백 함수 */
	function flist_lecture_result(data) {

		// 기존 목록 삭제
		$('#slec_list').empty();

		// 신규 목록 생성
		$('#slec_list').append(data);
	}

	/** 회원 생성 모달 실행 */
	function fPopModal_user(loginID) {
		// 상담 모달 폼 초기화
		fInit_tut();
		fslist_lecture();

		gfModalPop("#layer1");

	}

	/** 유저 밴 */
	function ban_user(loginID) {

		var result = confirm('정말 탈퇴시키시겠습니까?');

		if (result) {
			var param = {
				loginID : loginID
			}
			var resultCallback = function(data) {
				ban_user_result(data);
			};

			callAjax("/adm/ban_user.do", "post", "json", true, param, resultCallback);
			flist_tut();
		} else {
		
		}

	}

	/** 유저 밴 콜백 함수 */
	function ban_user_result(data) {

		var currentPage = $("#currentPage").val();
		var lec_id = $("#tmp_lec").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 학생 목록 조회
			flist_tut(currentPage, lec_id);

		} else {
			alert(data.resultMsg);
		}
	}

	//강사 승인 
	function apv_tut(loginID) {
		var result = confirm('승인 하시겠습니까?');

		if (result) {
			var param = {
				loginID : loginID
			}
			var resultCallback = function(data) {
				apv_tut_result(data);
			};

			callAjax("/adm/apv_tut.do", "post", "json", true, param,
					resultCallback);
			flist_tut();
		} else {

		}

	}

	//강사 승인 콜백
	function apv_tut_result(data) {

		var currentPage = $("#currentPage").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 학생 목록 조회
			flist_tut(currentPage);

		} else {
			alert(data.resultMsg);
		}
	}
	
	function dateSelect(docForm,selectIndex) {
		watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
		hourDiffer = watch - 86400000;
		calendar = new Date(hourDiffer);
		var daysInMonth = calendar.getDate();
		
			for (var i = 0; i < docForm.day.length; i++) {
				docForm.day.options[0] = null;
			}
			for (var i = 0; i < daysInMonth; i++) {
				docForm.day.options[i] = new Option(i+1);
		}
		document.form1.day.options[0].selected = true;
	}
	
	function formatPhoneNumber() {
		  var selectBox = document.getElementById("searchKey");
		  var searchWord = document.getElementById("searchWord");
		  
		  // 셀렉트박스의 선택된 옵션이 'tel'인지 확인
		  if (selectBox.value === "tel") {
		    // 숫자로만 이루어진 문자열인지 확인
		    var phoneNumber = searchWord.value.replace(/[^0-9]/g, "");
		    
		    // 휴대폰 번호 형식에 맞게 하이픈 추가
		    if (phoneNumber.length >= 3 && phoneNumber.length <= 7) {
		      phoneNumber = phoneNumber.replace(/(\d{3})(\d{1,4})/, "$1-$2");
		    } else if (phoneNumber.length >= 8) {
		      phoneNumber = phoneNumber.replace(/(\d{3})(\d{3,4})(\d{0,4})/, "$1-$2-$3");
		    }
		    
		    if (phoneNumber.length > 13) {
	            phoneNumber = phoneNumber.substring(0, 13);
			}
		    
		    // 입력된 내용을 변경된 번호로 업데이트
		    searchWord.value = phoneNumber;
		  }
		
	}
</script>


</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> 
		<input type="hidden" id="tmp_type" name="user_type" value=""> 
		<input type="hidden" id="tmp_user" name="loginID" value=""> 
		<input type="hidden" name="action" id="action" value="">

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
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">

							<p class="Location">
								<a href="/notice/aNotice.do" class="btn_set home">메인으로</a> 
								<a href="" class="btn_nav">인원 관리</a> 
								<span class="btn_nav bold">강사 관리</span> 
								<a href="/adm/tutorControl.do" class="btn_set refresh">새로고침</a>
							</p>


							<!--학생 목록  -->
							<p class="conTitle mt50">
								<span>강사 목록</span> <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;">
									<option value="all" id="option1" selected="selected">전체</option>
									<option value="name" id="option1">강사명</option>
									<option value="id" id="option1">ID</option>
									<option value="tel" id="option2">전화번호</option>
								</select>
									<input type="text" id="searchWord" name="searchWord" style="height: 28px;" oninput="formatPhoneNumber()" > 
									<a class="btnType blue" href="javascript:flist_tut()" name="search">
										<span id="searchEnter">검색</span>
									</a> 
								</span>
							</p>
							<span class="fr">
								<p class="Location">
									<Strong>가입일 조회 </Strong> 
									<input type="date" id="from_date">~<input type="date" id="to_date"> 
									<a class="btnType blue" href="javascript:flist_tut()" name="search">
									<span id="searchEnter">조회</span></a>
								</p>
							</span>

							<span class="fl"> 
								<a id="user_typeB" class="btnType3 color2" href="javascript:flist_tut(1,'B')">
									<span>승인 강사</span>
								</a> 
								<a id="user_typeD" class="btnType3 color1" href="javascript:flist_tut(1,'E')">
									<span>미승인 강사</span>
								</a>
							</span>

							<!--강사 리스트  -->
							<div class="div_list_tutor" id="div_list_tutor">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
										<col width="5%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">강사명 (ID)</th>
											<th scope="col">휴대전화</th>
											<th scope="col">가입일자</th>
											<th scope="col">승인여부</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody id="tut_list"></tbody>
								</table>
							</div>

							<div class="paging_area" id="Pagination"></div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>


		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>강사 정보</strong>
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
								<th scope="row">ID</th>
								<td id="tut_id"></td>
								<th scope="row">이름</th>
								<td id="tut_name"></td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td id="tut_birth"></td>
								<th scope="row">성별</th>
								<td id="tut_sex"></td>
							</tr>
							<tr>
								<th scope="row">전화 번호</th>
								<td id="tut_tel"></td>
								<th scope="row">이메일</th>
								<td id="tut_mail"></td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td colspan="6" id="tut_addr"></td>
							</tr>
							<tr>
								<td colspan="6">
									<p class="conTitle mt20">
										<span>강의 목록</span>
									</p>
									<table class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="5%">
											<col width="10%">
											<col width="20%">
											<col width="10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">강의ID</th>
												<th scope="col">강의명</th>
												<th scope="col">기간</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody id="slec_list"></tbody>
									</table>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->
					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		</form>
	</body>
</html>