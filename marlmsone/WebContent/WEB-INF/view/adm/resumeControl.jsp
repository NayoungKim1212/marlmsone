<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 5;
	var pageBlock = 5;

	$(function() {
		getLectureList()
	});	
	
	function getLectureList(currentPage) {
		currentPage = currentPage || 1;
		
		var param = {
			currentPage : currentPage,
			pageSize : pageSize
		}
		
		$.ajax({
			url: '/adm/allLectureList',
			type: "GET",
			dataType: "text",
			data: param,
			async: true,
			success: function(data) {
				console.log(data);
				lectureListResult(data, currentPage);
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	// 강사 해당 강의 리스트 화면에 보여주기
	function lectureListResult(data, currentPage) {
		
		currentPage = currentPage || 1;
		
		$("#lectureList").empty();
		$("#lectureList").append(data);
		
		var totalCount = $("#totalCount").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'getLectureList');
		
		$("#lecturePagination").empty().append(paginationHtml);
		$("#lectureCurrentPage").val(currentPage);
	}
	
	function getLectureStudentResume(lectureId) {
		console.log("lectureId : ", lectureId);
		
		$.ajax({
			url: '/adm/studentResumeList/'+ lectureId,
			type: "GET",
			dataType: "text",
			async: true,
			success: function(data) {
				console.log(data);
				studentResumeListResult(data);
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	function studentResumeListResult(data, currentPage) {
		
		currentPage = currentPage || 1;
		
		$("#studentResumeList").empty();
		$("#studentResumeList").append(data);
		
		var totalCount = $("#studentResumeTotalCount").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'getLectureStudentResume');
		
		$("#studentResumePagination").empty().append(paginationHtml);
		$("#studentResumeCurrentPage").val(currentPage);
	}
	
	/*
	//강사 해당 강의 리스트
	function getTutorLectureList(currentPage) {
		var tutorId = $("#tutorId").val();
		var lectureValue = $("#lectureValue").val();
		
		console.log("lectureValue : " + lectureValue);
		
		currentPage = currentPage || 1;
		
		var param = {
				tutorId : tutorId,
				lectureValue : lectureValue,
				currentPage : currentPage,
				pageSize : pageSize
		}
		
		console.log(param);
		
		$.ajax({
			url: '/tut/tutorLectureList',
			type: "POST",
			dataType: "text",
			async: true,
			data: param,
			success: function(data) {
				tutorLectureListResult(data, currentPage);
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	
	// 강사 해당 강의 리스트 화면에 보여주기
	function tutorLectureListResult(data, currentPage) {
		
		$("#lectureList").empty();
		$("#lectureList").append(data);
		
		var totalCount = $("#totalCount").val();
		var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'getTutorLectureList');
		
		$("#lecturePagination").empty().append(paginationHtml);
		$("#lectureCurrentPage").val(currentPage);
	}
	
	// 수강생 리스트
	function getLectureStudentList(lectureId, currentPage) {
		var tutorId = $("#tutorId").val();
		var searchKey = $("#searchKey").val();
		var studentValue = $("#studentValue").val();
		
		currentPage = currentPage || 1;
		
		console.log("tutorId : " + tutorId);
		console.log("currentPage : " + currentPage);
		console.log("pageSize : " + pageSize);
		console.log("searchKey : " + searchKey);
		console.log("studentValue : " + studentValue);
		
		var param = {
			tutorId : tutorId,
			lectureValue : lectureId,
			currentPage : currentPage,
			pageSize : pageSize,
			searchKey: searchKey,
			studentValue : studentValue
		}
		
		console.log(param);
		
		$.ajax({
			url: '/tut/LectureStudentList',
			type: "POST",
			dataType: "text",
			async: true,
			data: param,
			success: function(data) {
				console.log(data);
				lectureStudentListResult(data, currentPage);
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	// 수강생 리스트 보여주기
	function lectureStudentListResult(data, currentPage) {
		$("#lecStudentList").empty();
		$("#lecStudentList").append(data);
		
		var studentTotalCount = $("#studentTotalCount").val();
		console.log("studentTotalCount : " + studentTotalCount);
		var paginationHtml = getPaginationHtml(currentPage, studentTotalCount, pageSize, pageBlock, 'getLectureStudentList');
		
		$("#lecStudentPagination").empty().append(paginationHtml);
		$("#studentCurrentPage").val(currentPage);
	}
	
	// 강의 상세 정보 가져오기
	function tutorLectureDetail(data) {
		var tutorId = $("#tutorId").val();
		
		console.log("tutorID : " +  tutorId);
		console.log("data : " + data);
		
		gfModalPop("#tutorLectureDetailPopUp");
		
		var param = {
				tutorId : tutorId,
				lectureId : data
		}
		
		$.ajax({
			url: '/tut/tutorLectureDetail',
			type: "POST",
			dataType: "json",
			async: true,
			data: param,
			success: function(data) {
				console.log(data);
				detailTutorLecture(data.detailTutorLecture)
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	// 강의 상세정보 보여주기
	function detailTutorLecture(data) {
		
		var sDate = data.start_date;
		var eDate = data.end_date;
		
		var startDate = new Date(sDate);
		var endDate = new Date(eDate);
		
		var formatStartDate = startDate.getFullYear() + '-' + ('0' + (startDate.getMonth() + 1)).slice(-2) + '-' + ('0' + startDate.getDate()).slice(-2);
		var formatEndDate = endDate.getFullYear() + '-' + ('0' + (endDate.getMonth() + 1)).slice(-2) + '-' + ('0' + endDate.getDate()).slice(-2);
		
		$("#lectureTitle").text(data.lec_name);
		$("#lecture_maxCount").text(data.max_pnum + "명");
		$("#lectureTutor_name").text(data.tutor_name);
		$("#lecture_room").text(data.lecrm_name);
		$("#lecture_processDay").text(data.process_day + "일");
		$("#lecture_startDay").text(formatStartDate);
		$("#lecture_endDay").text(formatEndDate);
	}
	
	//수강생 디테일 정보 가져오기
	function getLectureStudentDetail(studentId) {
		var tutorId = $("#tutorId").val();
		console.log("student ID : " + studentId)
		
		gfModalPop("#LectureStudentDetailPopUp");
		
		var param = {
				tutorId : tutorId,
				studentId : studentId
		}
		
		console.log("param : " + param.tutorId);
		console.log("param : " + param.studentId);
		
		$.ajax({
			url: '/tut/lectureStudentDetail',
			type: "POST",
			dataType: "json",
			async: true,
			data: param,
			success: function(data) {
				console.log(data.detailTutorLecture);
				detailLectureStudent(data.detailTutorLecture);
			},
			error: function(error) {
				console.log(error);
			}
		})
		
	}
	
	//수강생 디테일 정보 보여주기
	function detailLectureStudent(data) {
		console.log("data : " + data[0]);
		var studentSex;
		if(data[0].student_sex === "M") {
			studentSex = "남"
		} else {
			studentSex = "여"
		}
		
		$("#studentID").text(data[0].std_id);
		$("#studentNumber").text(data[0].student_number);
		$("#studentName").text(data[0].student_name);
		$("#studentSex").text(studentSex);
		$("#studentTel").text(data[0].student_tel);
		$("#studentEmail").text(data[0].student_mail);
		$("#studentAddr").text(data[0].student_addr);
		
		var lectureStudentTbody = document.getElementById("studentLecture");
		lectureStudentTbody.innerHTML = "";
		for(var i = 0; i < data.length; i++) {
			var lecture = data[i]
			console.log("lecture : " + lecture.lec_Id);
			console.log("lecture : " + lecture.lec_name);
			console.log("lecture : " + lecture.startDate);
			
			var tr = document.createElement("tr");
			
			tr.innerHTML = '<td>' + lecture.lec_Id + '</td>' +
									 	'<td>' + lecture.lec_name + '</td>' +
									 	'<td>' + lecture.startDate + ' ~ ' + lecture.endDate + '</td>' 
			lectureStudentTbody.appendChild(tr);
		}
	}
	
	function lectureStudentApprove(studentId, lectureId) {
		
		var param = {
				studentId : studentId,
				lectureId : lectureId
		}
		
		console.log("param : " + param.tutorId);
		console.log("param : " + param.studentId);
		
		alert('강의 수강을 승인하시겠습니까?')
		
		$.ajax({
			url: '/tut/lectureStudentApprove',
			type: "POST",
			dataType: "json",
			async: true,
			data: param,
			success: function(data) {
				console.log(data);
				if(data == true) {					
					alert("승인이 완료되었습니다.")
					location.reload();
				}

			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	function lectureStudentCancle(studentId, lectureId) {
		
		var param = {
				studentId : studentId,
				lectureId : lectureId
		}
		
		console.log("param : " + param.tutorId);
		console.log("param : " + param.studentId);
		
		alert('강의 수강을 취소하시겠습니까?')
		
		$.ajax({
			url: '/tut/lectureStudentCancle',
			type: "POST",
			dataType: "json",
			async: true,
			data: param,
			success: function(data) {
				if(data == true) {					
					alert("취소가 완료되었습니다.")
					location.reload();
				}
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	// 수강생 검색 버튼 클릭 기능
	document.addEventListener('DOMContentLoaded', function() {
		var studentSearch = document.getElementById("studentSearch");
		studentSearch.addEventListener('click', function() {		
			console.log("studentSearch event Test");
			console.log("lectureIdValue : " + $("#lectureIdValue").val());
			
			var lectureIdValue =  $("#lectureIdValue").val();
			
			getLectureStudentList(lectureIdValue);
		})
	})
*/

</script>
</head>
<style>

	.lectureLable {
		font-weight: bold;
	}
	
	#lectureValue {
		width: 150px;
		height: 31px;
	}
	
	#studentValue {
		width: 150px;
		height: 31px;
	}

	#searcharea2 {
		margin-top: 50px;
	}
	
	#tableLectureListTitle {
		height: 33px;
		padding: 0 5px;
		line-height: 33px;
		border: 1px solid #bbc2cd;
		vertical-align: middle;
		background: #dce1e6;
		text-align: center;
		font-size: 16px;
		font-weight: bold;
		
	}
	
</style>
<body>

<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentPageCourse" id="currentPageCourse" value="">
	<input type="hidden" name="delCourseno" id="delCourseno" value="">
	<input type="hidden" id="lectureCurrentPage" value="1">
	<input type="hidden" id="studentResumeCurrentPage" value="1">
	<input type="hidden" id="tutorId" value="${loginId}">

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
							<a href="#" class="btn_set home">메인으로</a> 
							<a href="#" class="btn_nav">취업 관리</a>
						 	<span class="btn_nav bold">이력서 관리</span> 
						 	<a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle" id="searcharea">
							<span>강의목록</span> 
							 <span class="fr"> 
								<label class="lectureLable" for="lectureValue">강의명</label>
								<input type="text" id="lectureValue" name="lectureValue">
				 				<a class="btnType blue" href="javascript:getTutorLectureList()" onkeydown="enterKey()" name="search">
									<span id="searchEnter">검색</span>
								</a>
							</span>
						</p>
						
						<div class="divLecture" id="divLecture">
							<div class="paging_area" id="tableLectureListTitle" >강의목록</div>
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="10%">
									<col width="30%">
									<col width="20%">
									<col width="15%">
									<col width="25%">
								</colgroup>
								<thead>
									<tr>
									    <th scope="row">강의ID</th>
										<th scope="row">강의명</th>
										<th scope="row">담당 강사</th>
										<th scope="row">수강인원</th>
										<th scope="row">개강일/종강일</th>
									</tr>
								</thead>
								<tbody id="lectureList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="lecturePagination"> </div>
						
						<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
						
						<p class="conTitle" id="searcharea2">
							<span>수강생 이력서 목록</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;" >
										<option value="all">전체</option>
										<option value="studentName">이름</option>
										<option value="studentId">아이디</option>
										<option value="studentTel">전화번호</option>
								</select> 
								<input type="text" id="studentValue" name="studentValue">
				 				<a class="btnType blue" id="studentSearch"  name="search">
									<span id="searchEnter">검색</span>
								</a>
							</span>
						</p>
						
						<!-- 학생목록 -->
						<div class="lecStudent" id="lecStudent">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">학생 이름</th>
										<th scope="col">학생 ID</th>
										<th scope="col">학생 전화번호</th>
										<th scope="col">이메일</th>
										<th scope="col">이력서</th>
									</tr>
								</thead>
								<tbody id="studentResumeList"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="studentResumePagination"> </div>
						
						<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
</form>

</body>
</html>