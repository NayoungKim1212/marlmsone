<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>학생 관리</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;
	var pageSize_std = 5;
	var pageBlockSize = 5;
	
	/** OnLoad event */
	$(document).ready(function() {
		// 강의목록 조회
		fLecList();

		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

		// 달력 설정
		$("#Datepicker").datepicker({});
		$("#to_date").change(function() {
			if ($("#to_date").val() <$("#from_date").val()){
				alert("최소기간 보다 작을수 없습니다.")
				$("#to_date").val('');
			} 
		});
	});

	/** 버튼 이벤트 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnClose':
				gfCloseModal();
				break;
			case 'btn_lec_reg':
				std_lec_reg();
				break;	
			}
		});
	}

	/** 강의목록 조회 */
	function fLecList(currentPage) {

		currentPage = currentPage || 1;
		searchWord = $("#searchWord_lec").val();

		var param = {
			searchWord_lec : searchWord,
			currentPage : currentPage,
			pageSize : pageSize
		}

		var resultCallback = function(data) {

			flist_lec_result(data, currentPage);
		};
		
		callAjax("/adm/plist_lec.do", "post", "text", true, param, resultCallback);
	}

	/** 강의목록 조회 콜백 함수 */
	function flist_lec_result(data, currentPage) {

		// 기존 목록 삭제
		$('#lecList').empty();

		// 신규 목록 생성
		$("#lecList").append(data);

		// 총 개수 추출
		var totalCnt_lec = $("#totalCnt_lec").val();

		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt_lec, pageSize, pageBlockSize, 'fLecList');
		
		$("#Pagination_lec").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage_lec").val(currentPage);
		

		// flist_std();

	}
	
	/** 학생 목록 조회 */
	function flist_std(currentPage, lec_id) {
		currentPage = currentPage || 1;
		searchWord = $("#searchWord_std").val();
		searchKey = $("#searchKey_std").val();
		from_date =$("#from_date").val();
		to_date =$("#to_date").val();
		
		if(from_date != '' && to_date == ''){
			alert("끝 날짜를 선택해주세요.");
			return;
		} else if(from_date == '' && to_date != ''){
			alert("시작 날짜를 선택해주세요.");
			return;
		}
		
		// 강의 정보 설정
		$("#tmp_lec").val(lec_id);

		var param = {
			searchKey_std : searchKey,
			searchWord_std : searchWord,
			lec_id : lec_id,
			currentPage_std : currentPage,
			pageSize_std : pageSize_std,
			from_date:from_date,
			to_date:to_date
		}

		var resultCallback = function(data) {
			flist_std_result(data, currentPage);
		};

		callAjax("/adm/list_std.do", "post", "text", true, param,
				resultCallback);
	}

	/** 학생 목록 조회 콜백 함수 */
	function flist_std_result(data, currentPage) {
		console.log("학생 목록 : ", data);

		// 기존 목록 삭제
		$('#std_list').empty();

		// 신규 목록 생성
		$('#std_list').append(data);

		// 총 개수 추출
		var totalCnt_std = $("#totalCnt_std").val();
		
		// 페이지 네비게이션 생성
		var lec_id = $("#tmp_lec").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCnt_std, pageSize_std, pageBlockSize, 'flist_std', [ lec_id ]);
		$("#Pagination_std").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage_std").val(currentPage);


	}
	/** 유저 단건 조회 */
	function fstd_info(loginID) {
		$("#tmp_user").val(loginID);
		$("#rstdval").val(loginID);

		var param = {
			loginID : loginID
		};

		var resultCallback = function(data) {
			fstd_info_result(data);
		};

		callAjax("/adm/user_info.do", "post", "json", true, param,
				resultCallback);
	}

	/** 유저 단건 조회 콜백 함수*/
	function fstd_info_result(data) {

		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			fInit_std(data.user_model);

		} else {
			alert(data.resultMsg);
		}
	}

	/** 학생 정보출력  */
	function fInit_std(object) {
		$("#std_id").text(object.loginID);
		$("#std_num").text(object.std_num);
		$("#std_name").text(object.name);
		$("#std_birth").text(object.birth);
		$("#std_tel").text(object.tel);
		$("#std_sex").text(object.sex);
		
		if(object.addr != null){
			$("#std_addr").text(object.addr.replace(/,/gi, " "));
		}
		
		$("#std_mail").text(object.mail);

		fslist_lecture(object.loginID);
	}

	/**학생 수강 목록 조회 */
	function fslist_lecture(loginID) {
	
		var param = {
			loginID : loginID,
			user_type:'a'
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
	
	/**수강 등록 모달 실행  */
	function fPopModal_std_lec_reg() {
		gfModalPop("#layerB");
	}

	/* 학생 수강신청 */
	function std_lec_reg(){
		$.ajax({
		url : "/adm/std_lec_reg.do",
		type : "post",
		dataType : "json",
		async : true,
		data : $("#lec_reg_form").serialize(),
		/* beforeSend: function(xhr) {
			xhr.setRequestHeader("AJAX", "true");
			$.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
		}, */
		success : function(data) {
			std_lec_reg_result(data);
		},
		error : function(xhr, status, err) {
			console.log("xhr : " + xhr);
			console.log("status : " + status);
			console.log("err : " + err);
      			
			if (xhr.status == 901) {
				alert("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
				location.replace('/login.do');
			} else {
				alert('이미 수강신청 된 강의입니다.');
			}
		}
	});
	};
	
	/** 수강등록 저장 콜백 함수 */
	function std_lec_reg_result(data) {
		var currentPage = $("#currentPage_adv").val();
		var lec_id = $("#tmp_lec").val();
		var std_id=$("#tmp_user").val();
		
		console.log("여기 탔나");
		
		if (data.result == "SUCCESS") {
			// 응답 메시지 출력
			alert(data.resultMsg);
			// 모달 닫기
			gfCloseModal();
			
		} else {
			// 오류 응답 메시지 출력
			alert(data.resultMsg);
		}
		
		flist_std();
	} 
	
	//학생 수강취소 
	function std_lec_del(lec_id){
		var std_id=$("#tmp_user").val();
		
		var result = confirm('정말 수강 취소하시겠습니까?');

		if(result){
		var param = {
				std_id : std_id,
				lec_id : lec_id
		}			
		var resultCallback = function(data) {
				std_lec_del_result(data);
		};

		callAjax("/adm/std_lec_del.do", "post", "json", true, param, resultCallback);
		}else{
			
		}
	}	
	
	/** 수강취소 콜백 함수 */
	function std_lec_del_result(data) {
		var std_id=$("#tmp_user").val();
		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 강의 목록 갱신
			fslist_lecture(std_id);

		} else {
			alert(data.resultMsg);
		}
	}


	/** 회원 탈퇴 */
	function ban_user(loginID) {
		
		var result = confirm('정말 탈퇴시키시겠습니까?');

		if(result){
			var param = {
					loginID : loginID
			};
			
			var resultCallback = function(data) {
				ban_user_result(data);
			};
	
			callAjax("/adm/ban_user.do", "post", "json", true, param, resultCallback);
			
		}else{
			flist_std();
		}
		
		flist_std();
	}

	/** 회원 탈퇴 콜백 함수 */
	function ban_user_result(data) {

		var currentPage = $("#currentPage_adv").val();
		var lec_id = $("#tmp_lec").val();

		if (data.result == "SUCCESS") {

			// 응답 메시지 출력
			alert(data.resultMsg);

			// 모달 닫기
			gfCloseModal();

			// 학생 목록 조회
			flist_std(currentPage, lec_id);

		} else {
			alert(data.resultMsg);
		}
	}
	
		function dateSelect(docForm,selectIndex) {
			console.log("1");
			watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
			console.log("2");
			hourDiffer = watch - 86400000;
			console.log("3");
			calendar = new Date(hourDiffer);
			console.log("4");
			var daysInMonth = calendar.getDate();
			console.log("5");
			
				for (var i = 0; i < docForm.day.length; i++) {
					docForm.day.options[0] = null;
				}
				for (var i = 0; i < daysInMonth; i++) {
					docForm.day.options[i] = new Option(i+1);
			}
			document.form1.day.options[0].selected = true;
		}
		
		/* 전화번호 검색 정규식 */
		function formatPhoneNumber() {
			  var selectBox = document.getElementById("searchKey_std");
			  var searchWord_std = document.getElementById("searchWord_std");
			  
			  // 셀렉트박스의 선택된 옵션이 'tel'인지 확인
			  if (selectBox.value === "tel") {
			    // 숫자로만 이루어진 문자열인지 확인
			    var phoneNumber = searchWord_std.value.replace(/[^0-9]/g, "");
			    
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
			    searchWord_std.value = phoneNumber;
			  }
			
		}

	
</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage_lec" value="1"> 
		<input type="hidden" id="currentPage_std" value="1"> 
		<input type="hidden" id="tmp_lec" value=""> 
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
								<span class="btn_nav">학생 관리</span> 
								<a href="/adm/studentControl.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle" id="searcharea">
								<span>강의 목록</span> 
								<span class="fr"> <strong>강 의 명</strong> 
								<input type="text" id="searchWord_lec" name="searchWord_lec" style="height: 28px;"> 
								<a class="btnType blue" href="javascript:fLecList()" name="search">
								<span id="searchEnter">검색</span></a></span>
							</p>


							<!--강의 리스트  -->
							<div class="lectureList" id="lectureList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="30%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">과정 ID</th>
											<th scope="col">과정명 명</th>
											<th scope="col">기간</th>
										</tr>
									</thead>
									<tbody id="lecList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="Pagination_lec"></div>

							<!--학생 목록  -->
							<p class="conTitle mt50">
								<span>학생 목록</span> <span class="fr"> 
								<select id="searchKey_std" name="searchKey_std" style="width: 80px;">
										<option value="all" id="option1" selected="selected">전체</option>
										<option value="stdNm" id="option1">학생명</option>
										<option value="stdId" id="option2">id</option>
										<option value="tel" id="option2">전화번호</option>
								</select>
								<input type="text" id="searchWord_std" name="searchWord_std" oninput="formatPhoneNumber()" style="height: 28px;"> 
								
								<a class="btnType blue" href="javascript:flist_std()" name="search">
									<span id="searchEnter">검색</span>
								</a>
								</span>
							</p>
							
							<span class="fr">
							<p class="Location">
								<Strong>가입일 조회 </Strong>
								<input type="date" id="from_date">~<input type="date" id="to_date">
								<a class="btnType blue" href="javascript:flist_std()" name="search">
									<span id="searchEnter">조회</span>
								</a> 	
							</p>
							</span>
							<span class="fl"> 
								<a class="btnType3 color2" href="javascript:flist_std()">
									<span>전체 학생</span>
								</a>
								<a class="btnType3 color1" href="javascript:flist_std(1,'미수강')">
									<span>미수강 학생</span>
								</a>
							</span>
							
							<!--학생 리스트  -->
							<div class="div_list_student" id="div_list_student">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">학번</th>
											<th scope="col">수강강의</th>
											<th scope="col">학생 명(ID)</th>
											<th scope="col">휴대전화</th>
											<th scope="col">가입일자</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody id="std_list"></tbody>
								</table>
							</div>

							<div class="paging_area" id="Pagination_std"></div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		</form>
		<!-- 모달팝업 -->
		<div id="layer1" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>학생 정보</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="10%">
							<col width="10%">
							<col width="10%">
							<col width="10%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">ID</th>
								<td id="std_id"></td>
								<th scope="row">학번</th>
								<td id="std_num"></td>
							</tr>
							<tr>
								<th scope="row">이름</th>
								<td id="std_name"></td>
								<th scope="row">생년월일</th>
								<td id="std_birth"></td>
							</tr>
							<tr>
								<th scope="row">전화 번호</th>
								<td id="std_tel"></td>
								<th scope="row">성별</th>
								<td id="std_sex"></td>
							</tr>
							<tr>
								<th scope="row">이메일</th>
								<td id="std_mail" colspan="6"></td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td id="std_addr" colspan="6"></td>
							</tr>
							<tr>
								<td colspan="6">
									<p class="conTitle mt20">
										<span>수강 내역</span>
										<span class="fr" style="margin-right:20px"> 
											<a class="btnType3 color2" href="javascript:fPopModal_std_lec_reg()">
												<span>수강 등록</span>
											</a>
										</span>
									</p>
									
									<table class="col">
										<caption>caption</caption>
										<colgroup>
											<col width="5%">
											<col width="10%">
											<col width="20%">
											<col width="10%">
											<col width="10%">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">강의ID</th>
												<th scope="col">강의명</th>
												<th scope="col">기간</th>
												<th scope="col">상태</th>
												<th scope="col"></th>
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
		
		<!-- 강의  -->
		<form id="lec_reg_form">
		<div id="layerB" class="layerPop layerType2" style="width: 600px;">
		<input type="hidden" value="" name="std_id" id="rstdval">
			<dl>
				<dt>
					<strong>수강 등록</strong>
				</dt>
				
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
							<tr>
								<th>과정선택</th>
								<td colspan="4">
								<select id="reg_lec" name="lec_id" style="width:350px">
									<c:forEach items="${list_lec }" var="list">
										<option value="${list.lec_id }"> ${list.lec_name}  ( ${list.start_date} ~ ${list.end_date})</option>
									</c:forEach>
								</select>
								</td>
							</tr>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btn_lec_reg" name="btn"><span>수강 등록</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		</form>
	
	</body>

</html>