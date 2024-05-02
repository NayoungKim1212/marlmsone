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
	
	var status = "insert"

	$(function() {
		getLectureDetail()
		//getProjectList()
		toggleButtons(status);
	});	
	
	// 모달 창 저장, 수정 버튼 변화
	function toggleButtons(status) {
	       var btnSave = document.getElementById("btnSave");
	       var btnUpdate = document.getElementById("btnUpdate");
	       var lectureList = document.getElementById("lectureList");
	       var downFileCol = document.getElementById("disfilename"); 
	       var fileFontRed = document.getElementById("fileFontRed");
	       
	       if(status === 'insert') {
	    	   btnSave.style.display = "inline-block";
	    	   btnUpdate.style.display = "none";
	    		downFileCol.style.display = "none";
	       } else if(status === "update") {
	    	   btnSave.style.display = "none";
	    	  btnUpdate.style.display = "inline-block";
	    	  downFileCol.style.display = "inline-block";
	    	   fileFontRed.style.display = "none";
	       }
	}

	// 강의 디테일 가져오기
	function getLectureDetail() {
		var tutorId = $("#tutorId").val();
		var lecture_value = $("#searchKey").val();
		
		currentPage = currentPage || 1;
		
		console.log("lecture_value = " + lecture_value);
		console.log("tutorId = " + tutorId);
		
		var param = {
				tutorId : tutorId,
				lectureId : lecture_value
		}
		
		console.log(param);
		
		$.ajax({
			url:'/tut/projectLectureDetail',
			type:"POST",
			dataType:"json",
			async: true,
			data: param,
			success:function(data) {
				console.log(data);
				showProjectLectureDetail(data.detailTutorLecture);
				getProjectList()
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	 
	// 과제 정보 들고오기
	function getProjectList(currentPage) {
		var tutorId = $("#tutorId").val();
		var lectureValue = $("#searchKey").val()
		
		currentPage = currentPage || 1;
		
		var param = {
			tutorId : tutorId,
			lectureId : lectureValue,
			currentPage: currentPage,
			pageSize : pageSize
		}
	
		console.log(param);
		
		$.ajax({
			url:'/tut/tutorProjectList',
			type:"POST",
			dataType:"text",
			async: true,
			data: param,
			success:function(data) {
				console.log(data);
				tutorProjectListResult(data, currentPage);
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	// 과제 정보 보여주기
	function tutorProjectListResult(data, currentPage) {
		$("#projectLectureDetail").empty();
		$("#projectLectureDetail").append(data);
		
		var totalCount = $("#totalCount").val();
		
		var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'getProjectList');
		
		$("#pagination").empty().append(paginationHtml);
		
		$("#currentPage").val(currentPage);
	}
	
	// 과제정보 디테일 들고오기
	function tutorProjectDetail(data) {
		status = "update";
		toggleButtons(status);
		
		var projectDateId = data;
		
		console.log("projectDateId : " + projectDateId);
		gfModalPop("#mat_de");
		
		$.ajax({
			url:'/tut/getDetailTutorProject',
			type:"GET",
			async : true,
			data: {
				projectDateId : projectDateId
			},
			success: function(data) {
				console.log(data);
				detailTutorProjectForm(data.detailTutorProject);
			},
			error : function(err) {
				console.log(err);
			},
		})
	}
	
	// 과제정보 디테일 보여주기
	function detailTutorProjectForm(data) {
		$("#projectId").val(data.projectId);
		$("#projectTitle").val(data.projectTitle);
		$("#proejectContent").val(data.projectContent);
		$("#projectSubmitDate").val(data.startDate);
		$("#projectDeadLineDate").val(data.deadLineDate);
		$("#fileDownLoad").text(data.project_orginal_fname);
		$("#fileDownLoad").attr('href', "/tut/tutorProject/fileDownLoad/"+ data.projectId)
	}
	
	// 강의디테일 보여주기
	function showProjectLectureDetail(data) {
		console.log(data);
		
		var sDate = data.start_date;
		var eDate = data.end_date;
		
		var startDate = new Date(sDate);
		var endDate = new Date(eDate);
		
		var formatStartDate = startDate.getFullYear() + '-' + ('0' + (startDate.getMonth() + 1)).slice(-2) + '-' + ('0' + startDate.getDate()).slice(-2);
		var formatEndDate = endDate.getFullYear() + '-' + ('0' + (endDate.getMonth() + 1)).slice(-2) + '-' + ('0' + endDate.getDate()).slice(-2);
		
		$("#lectureName").text(data.lec_name);
		$("#lectureTutorName").text(data.tutor_name);
		$("#lectureStartDate").text(formatStartDate);
		$("#lectureEndDate").text(formatEndDate);
		$("#lectureRoom").text(data.lecrm_name);
		$("#lecturePreNum").text(data.pre_pnum + "명");
		$("#lectureMaxNum").text(data.max_pnum + "명");
	}
	
	// 과제 등록 모달 띄우기
	function fPopModalMat(){
		console.log('fPopModalMat test');
		 gfModalPop("#mat_de");
		//데이터 넣기 
	}
	
	// 과제 등록
	function lectureProjectSave() {
		console.log('lectureProjectSave test');
		
		var lectureValue = $("#searchKey").val();
		var projectTitle = $("#projectTitle").val();
		var proejectContent = $("#proejectContent").val();
		var projectSubmitDate = $("#projectSubmitDate").val();
		var projectDeadLineDate = $("#projectDeadLineDate").val();
		var file = $("#bbs_files_1").prop('files')[0];
		
		console.log("lectureValue : " + lectureValue);
		console.log("projectTitle : " + projectTitle);
		console.log("proejectContent : " + proejectContent);
		console.log("projectSubmitDate : " + projectSubmitDate);
		console.log("projectDeadLineDate : " + projectDeadLineDate);
		console.log(file);
		
		var formData = new FormData();
		
		formData.append("lectureValue", lectureValue);
		formData.append("projectTitle", projectTitle);
		formData.append("proejectContent", proejectContent);
		formData.append("projectSubmitDate", projectSubmitDate);
		formData.append("projectDeadLineDate", projectDeadLineDate);
		formData.append("file", file);
		
		if(! fValidateTutorProject()) {
			return;
		}
		
		$.ajax({
			url:'/tut/saveLectureProject',
			type: "POST",
			async: true,
			data: formData,
			processData: false,
			contentType: false,
			cache : false,
			success: function(data) {
				console.log(data);
				if(data == true) {
					alert("강의자료가 등록 되었습니다.");
					location.reload(true)
				} else {
					alert("다시 강의자료를 등록해주세요");
					location.reload(true);
				}
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	//과제 수정
	function tutorProjectUpdate() {
		var projectId = 	$("#projectId").val();
		console.log("projectId : " + projectId);
		
		var updateProjectTitle = $("#projectTitle").val();
		var updateProjectContent = $("#proejectContent").val();
		var updateProjectSubmitDate = $("#projectSubmitDate").val();
		var updateProjectDeadLineDate = $("#projectDeadLineDate").val();
		var updateFile = $("#bbs_files_1").prop('files')[0];
		
		console.log("updateProjectTitle : " + updateProjectTitle);
		console.log("updateProjectContent : " + updateProjectContent);
		console.log("updateProjectSubmitDate : " + updateProjectSubmitDate);
		console.log("updateProjectDeadLineDate : " + updateProjectDeadLineDate);
		console.log("updateFile : " + updateFile);
		
		var formData = new FormData();
		
		formData.append("projectId", projectId);
		formData.append("updateProjectTitle", updateProjectTitle);
		formData.append("updateProjectContent", updateProjectContent);
		formData.append("updateProjectSubmitDate", updateProjectSubmitDate);
		formData.append("updateProjectDeadLineDate", updateProjectDeadLineDate);
		
		if(updateFile === null || updateFile === undefined || updateFile === '') {
			console.log("update File 없음");
			formData.append("file", null);
		} else {
			console.log('update File 있음');
			formData.append("updateFile", updateFile);
		}
		
		/*
		var param = {
				projectId : projectId,
				updateProjectTitle : updateProjectTitle,
				updateProjectContent : updateProjectContent,
				updateProjectSubmitDate : updateProjectSubmitDate,
				updateProjectDeadLineDate : updateProjectDeadLineDate  
		}
		*/
		
		alert("과제를 수정하시겠습니까?")
		
		$.ajax({
			url: '/tut/updateTutorProject',
			type: "POST",
			async: true,
			data: formData,
			processData: false,
			contentType: false,
			cache : false,
			success: function(data) {
				console.log(data)
				if(data === true) {
					alert("수정이 완료 되었습니다.")
					location.reload();
				}
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	// 과제삭제
	function tutorProjectDelete() {
		var projectId = 	$("#projectId").val();
		alert("과제를 정말 삭제하시겠습니까?")
		
		$.ajax({
			url:'/tut/deleteTutorProject/' + projectId,
			type: "GET",
			async: true,
			success: function(data) {
				console.log(data)
				if(data === true) {
					alert("학습자료가 삭제 되었습니다.")
					location.reload();
				}
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	function projectSubmitDetail(data) {
		console.log("data : ", data);	
		gfModalPop("#submitResult");
		
		$.ajax({
			url:'/tut/showStudentProject/' + data,
			type: "GET",
			async: true,
			success: function(data) {
				console.log(data)
				showStudentProjectListResult(data);
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	function showStudentProjectListResult(data) {
		$("#studentProjectList").empty();
		$("#studentProjectList").append(data);
	}
	
	function fValidateTutorProject() {
		var chk = checkNotEmpty(
			[
			 	["projectTitle", "제목을 입력해 주세요"],
			 	["proejectContent", "내용을 입력해 주세요"],
			 	["projectSubmitDate", "제출일을 선택해 주세요"],
			 	["projectDeadLineDate", "마감일을 선택해 주세요"],
			 	[ "bbs_files_1", "파일을 등록해 주세요." ]	
			 ]		
		);
		
		if (!chk) {
			return;
		}

		return true;
	}
	
	
</script>
</head>
<style>
	.detailLearnMat {
		cursor: pointer;
	}
	
	#fileDownLoad {
		font-weight: bold;
		cursor: pointer;
	}
	
	.lectureInfoTitle {
		margin: 25px 0 15px 0;
	}
	
	.lectureInfoTitle > h2 {
		font-size: 20px;
	}
	
	.cautionTitle {
		font-size: 15px;
		margin-bottom: 10px;
		font-weight: bold;
	}
	
	.cautionRed {
		color: red;
	}
	
	.projectDate {
		font-size: 17px;
		font-weight: bold;
	}
	
</style>
<body>

<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" name="currentPageCourse" id="currentPageCourse" value="">
	<input type="hidden" name="delCourseno" id="delCourseno" value="">
	<input type="hidden" id="currentPage" value="1">

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
							<a href="#" class="btn_set home">메인으로</a> <a href="#"
								class="btn_nav">학습 관리</a> <span class="btn_nav bold">과제 관리</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle" id="searcharea">
							<span>강의 목록</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 150px;" >
								 	<c:forEach items="${lectureList}" var="lecture" >
										<option value="${lecture.lec_id}">${lecture.lec_name}</option>
									</c:forEach>
								</select> 
			 				<a class="btnType blue" href="javascript:getLectureDetail()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
							
							    <a class="btnType blue" href="javascript:fPopModalMat();" name="modal"><span>과제 올리기</span></a>
							</span>
						</p>
						<div class="lectureInfoTitle">
							<h2>수업 정보</h2>
						</div>
						<div class="divMatList" id="divMatList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="20%">
									<col width="15%">
									<col width="10%">
									<col width="10%">
									<col width="20%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">강의명</th>
										<th scope="col">강사명</th>
										<th scope="col">개강일</th>
										<th scope="col">종강일</th>
										<th scope="col">강의실</th>
										<th scope="col">현재인원</th>
										<th scope="col">정원</th>
									</tr>
								</thead>
								<tbody id="projectLectureDettail">
									<tr>
										<td id="lectureName"></td>
										<td id="lectureTutorName"></td>
										<td id="lectureStartDate"></td>
										<td id="lectureEndDate"></td>
										<td id="lectureRoom"></td>
										<td id="lecturePreNum"></td>
										<td id="lectureMaxNum"></td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="lectureInfoTitle">
							<h2 >과제 정보</h2>
						</div>
						<div class="divMatList" id="divMatList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="20%">
									<col width="50%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">과제 번호</th>
										<th scope="col">과제 이름</th>
										<th scope="col">제출일</th>
										<th scope="col">마감일</th>
										<th scope="col">제출현황</th>
									</tr>
								</thead>
								<tbody id="projectLectureDetail">	</tbody>
							</table>
						</div>
						<div class="paging_area"  id="pagination"> </div>
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="mat_de" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>과제 등록</strong>
              <input type="text" id="tutorId" value="${loginId}" hidden>
            </dt>
            <dd class="content" >
            <p class="cautionTitle">※ <span class="cautionRed">제출일</span>과 <span class="cautionRed">마감일</span>을 반드시 입력하세요</p>
              <table class="row">
              <caption>caption</caption>
            <tbody>
            <form id=uploadfrom enctype="multipart/form-data">
            <tr>
            	<th>제목<span class="font_red">*</span></th>
            	<td colspan="6">
            		<input type ="hidden"  id="projectId"   name ="projectId" >
					<input type ="text"  id="projectTitle"    name ="projectTitle"  class="inputTxt p100">
            	</td>
            </tr>
             <tr>
                <th scope="row">내용<span class="font_red">*</span> </th>
               <td id="title" colspan="6" >
	               <input type ="text"  id="proejectContent" name ="proejectContent"  class="inputTxt p100">
               </td>
            </tr>
            <tr>
               <th scope="row">제출일 <span class="font_red">*</span></th>
               <td  id="con" colspan="6">
              	 	<input type ="date" class="projectDate"  id="projectSubmitDate" name ="projectSubmitDate"  class="inputTxt p100">
               </td>
            </tr>
            <tr>
               <th scope="row">마감일<span class="font_red">*</span></th>
               <td  id="con" colspan="6">
              	 	<input type ="date" class="projectDate"  id="projectDeadLineDate"    name ="projectDeadLineDate"  class="inputTxt p100">
               </td>
            </tr>
            <tr>
               <th scope="row">파일<span id="fileFontRed" class="font_red">*</span></th>
               <td colspan="6">
                    <div class="filebox bs3-primary">
                        <input type="file" id="bbs_files_1"  name="bbs_files_1" class="upload-hidden"/>
                        <div style="margin: 5px ;" id="disfilename"  name="disfilename">
							<a id="fileDownLoad">다운로드</a>
						</div>
						<input type="text" id="learnMatId" hidden/>
                    </div>
               </td>
            </tr>
            </form>
             </tbody> 
          </table>
       			<div class="btn_areaC mt30">
					<a href="javascript:lectureProjectSave();" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="javascript:tutorProjectUpdate();" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a> 
					<a href="javascript:tutorProjectDelete();" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
               </dd>
			</dl>
			
		<!-- 
		<a href="javascript:cancleBtn();" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
		 -->
	</div>
	
	<div id="submitResult" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>제출 현황</strong>
              <input type="text" id="projectId" value="" hidden>
            </dt>
            <dd class="content" >
              <table class="col">
              <caption>caption</caption>
              <colgroup>
					<col width="20%">
					<col width= "45%">
					<col width="15%">
					<col width="20%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">학생 이름</th>
					<th scope="col">과제 제목</th>
					<th scope="col">파일</th>
					<th scope="col">제출일</th>
				</tr>
			</thead>
            <tbody id="studentProjectList">
           			<tr>
           				<td>문몰래</td>
           				<td>자바의 이해 과제입니다.</td>
           				<td>다운로드</td>
           				<td>2024-04-11</td>
           			</tr>
             </tbody> 
          </table>
          </dd>
		</dl>
			
		<a href="javascript:cancleBtn();" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>

	</div>
</form>
</body>
</html>