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
<title>강의 목록</title>
<!-- sweet alert import -->

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	var pageSize = 10; // -- 한 페이지 당 몇개 보여줄 지
	var pageBlocksize = 10; // -- 페이지 당 번호
	
	$(document).ready(function(e) {
		console.log('lecture');
		
		fLectureButtonClickEvent();
	
		flec_list(); // 강의 목록 리스트
	})
	
		/** 버튼 이벤트 등록 */
	function fLectureButtonClickEvent() {

		$("#searchEnter").click(function(e) {
			// ?
			e.preventDefault();
			
		});

			// a 태그의 이름이 btn 인 경우
			$('a[name=btn]').click(function(e) {
				e.preventDefault();
			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnReg':
				course_reg();
				break;
			case 'btnClose':
				gfCloseModal();
				flec_list();
				break;
			
		};
	})
	
	}
	/* 강의 목록 조회 */
	function flec_list(currentPage) {
		
		currentPage = currentPage || 1;
		
		console.log("currentPage : ", currentPage);
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchInfo : $("#searchInfo").val(),
				searchKey : $("#searchKey").val()
		}
		
		console.log("param : ", param);
		
		$.ajax({
			url : '/std/lecList.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "text",
			success : function(data) {
				console.log(data);
				flec_list_result(data, currentPage);
			},
			error : function(error) {
				console.log(error)
			}
		})
	}
	
	/* 강의 목록 조회 콜백 */
	function flec_list_result(data, currentPage) {
		console.log("data : ", data);
		
		$("#lectureList").empty().append(data);
		var totCnt = $("#lecTotal").val();
		console.log("totCnt : " + totCnt);

		var paginationHtml = getPaginationHtml(currentPage, totCnt, pageSize,
				pageBlocksize, 'flec_list');

		console.log(currentPage);
		console.log(totCnt);
		console.log(pageSize);
		console.log(pageBlocksize);

		console.log("paginationHtml : " + paginationHtml);

		$("#Pagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage);
	}
	
	/* 계획서 단건 조회 */
 	function lec_List(lec_id) {
		console.log("lec_id : ", lec_id);
		
		$("#lec_id").val(lec_id);
		var param = {
				lec_id : lec_id
		};
		
		$.ajax({
			url : '/std/lecInfo.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "json",
			success : function(data) {
				console.log(data);
				lec_List_result(data);
			},
			error : function(error) {
				console.log(error)
			}
		})
		
	}
 	
 	function lec_List_result(data) {
 		console.log("강의 정보 : ", data);
 		
		if (data.result == "SUCCESS") {

			// 모달 팝업
			gfModalPop("#layer1");

			// 그룹코드 폼 데이터 설정
			init(data.lecInfo);
			week_plan(data.week_plan);
			
		} else {
			alert(data.resultMsg);
		}
 	}
	
	/** 모달 강의정보 조회 */
	function flec_info() {
		console.log("flec_info");

		if(lec_id == null || lec_id == ""){
			
			init();
			
		} else {
			$("#lec_id").val(lec_id);
			
			var param = {
				lec_id : lec_id,
			}

			console.log("lec_id : ", lec_id);
			
			$.ajax({
				url : '/std/lecInfo.do',
				type : "POST",
				data : param,
				async : true,
				dataType : "json",
				success : function(data) {
					console.log(data);
					lec_info_result(data.lec_info,data.week_plan);
				},
				error : function(error) {
					console.log(error)
				}
			})
		}
	}
	
	/** 강의정보 가져오기 */
	function lec_info_result(data,week) {
		console.log("lec_info_result ", data);
		
		$("#table").find('input, textarea').empty();
		$("#lec_id").text(data.lec_id);
		$("#lecnm").text(data.lec_name);
		$("#tutor_id").val(data.tutor_id);
		$("#t_name").val(data.name);
		$("#tel").val(data.tel);
		$("#mail").val(data.mail);
		$("#lecrm_id").val(data.lecrm_id);
		$("#lecrm_name").val(data.lecrm_name);
		$("#lec_goal").val(data.lec_goal);
		$("#lec_sort").val(data.lec_sort);
 
		lec_List(data.lec_id);
	}
	
	/** 계획서 폼 초기화 */
	function init(data) {
		console.log("폼 초기화 : ", data);
		
		if (data == "" || data == null) {
			$("#t_name,#tel,#mail,#lec_goal").val('');
			$("#week_plan").empty();

		} else {
			
			$("#lec_id").val(data.lec_id);
			$("#lecnm").val(data.lec_name);
			$("#tutor_id").val(data.tutor_id);
			$("#t_name").val(data.name);
			$("#tel").val(data.tel);
			$("#mail").val(data.mail);
			$("#lecrm_name").val(data.lecrm_id);
			$("#lec_goal").val(data.lec_goal);
			$("#lec_id").val(data.lec_id);
			$("#lec_sort").val(data.lec_sort);
		}
	}
	
	//계획서 단건 조회 주차목록
	function week_plan(data) {
		console.log("주차 계획 : " , data);
		var innerHtml = "";
		if (data == "" || data == null || data == undefined) {
			$("#week_plan").empty();

		} else {
			$("#week_plan").empty();
			$.each(data,
							function(index, item) {
								innerHtml += '<tr>';
								innerHtml += '    <td class="week">'
										+ item.week + '</td>';
								innerHtml += '    <td><input type="text" value="'+item.learn_goal+'" name="learn_goal" class="inputTxt p100 learn_goal" readonly></td>';
								innerHtml += '    <td><input type="text" value="'+item.learn_con+'" name="learn_con" class="inputTxt p100 learn_con" readonly></td>';
								innerHtml += '</tr>';

							})
			$('#week_table > tbody:last').append(innerHtml);
		}
	}
	
	function course_reg() {
		console.log($("#lec_id").val());
		
		 var param = {
				lec_id : $("#lec_id").val()
		}
		console.log("신청파람 : ", param);
		 
			$.ajax({
				url : '/std/lecReg.do',
				type : "POST",
				data : param,
				async : true,
				dataType : "json",
				success : function(data) {
					console.log(data);
					alert(data.resultMsg);
					gfCloseModal();
					flec_list($("#currentPage").val());			
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
								<a href="../notice/aNotice.do" class="btn_set home">메인으로</a>
								<span class="btn_nav bold">학습 지원</span> <span
									class="btn_nav bold">강의 목록 </span> <a
									href="../std/lectureList.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>강의목록</span> <span class="fr"> <!-- searchbar --> 
								<select id="searchKey" name="searchKey" style="width: 80px;">
										<option value="all" id="all" selected="selected">전체</option>
										<option value="name" id="name">강사명</option>
										<option value="lec_name" id="lec_name">강의명</option>
								</select> <input type="text" id="searchInfo" name="searchInfo"
									class="form-control" placeholder="" style="height: 28px;">
									<!-- // searchbar --> <!-- button --> <a class="btnType blue"
									href="" name="searchEnter" id="searchEnter"><span>검색</span></a>
								</span>
							</p>
							<div class="lectureList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">수강대상</th>
											<th scope="col">강사명</th>
											<th scope="col">개강일</th>
											<th scope="col">종강일</th>
											<th scope="col">수강인원</th>
											<th scope="col">최대인원</th>
										</tr>
									</thead>
									<tbody id="lectureList"></tbody>
								</table>
							</div>
							<div class="paging_area" id="Pagination"
								style="margin-bottom: 50px;"></div>
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
				<strong>강의 정보</strong>
			</dt>

			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row" id="table" name="table">
					<caption>caption</caption>
					<tbody>
						<tr>
							<th scope="row">강의명</th>
							<td><input type="text" class="inputTxt p100"
								id="lecnm" name="lecnm" readonly /></td>
							<th scope="row">수강대상</th>
							<td><input type="text" class="inputTxt p100"
								id="lec_sort" name="lec_sort" /></td>
						</tr>
						<tr>
							<th scope="row">강사명</th>
							<td><input type="text" class="inputTxt p100"
								id="t_name" name="t_name" readonly/></td>
							<th scope="row">연락처</th>
							<td><input type="text" class="inputTxt p100"
								id="tel" name="tel" readonly/></td>
						<tr>
							<th scope="row">이메일</th>
							<td><input type="text" class="inputTxt p100"
								id="mail" name="mail" readonly/></td>
							<th scope="row">강의실</th>
							<td><input type="text" class="inputTxt p100"
								id="lecrm_name" name="lecrm_name" readonly/></td>
						</tr>
						<tr>
							<th scope="row">수업목표</th>
							<td colspan="3"><textarea name="lec_goal" id="lec_goal" style="resize:none" readonly></textarea></td>
						</tr>
<!-- 						<tr>
							<th scope="row">강의계획</th>
							<td><input type="text" class="inputTxt p100"
								id="mail" name="mail" /></td>
						</tr>  -->
					</tbody>
				</table>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
			<dl>	
				<td colspan="3">
					<p class="conTitle" >
						<span>강의 계획</span>
							</p>
					</td>		
				<dd class="content">
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
						<a href="" class="btnType blue" id="btnReg" name="btn"><span>수강 신청</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
	</div>

</body>
</html>