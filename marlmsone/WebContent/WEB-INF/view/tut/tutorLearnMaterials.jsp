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
	var pageSize = 10;
	var pageBlock = 5;

	var status = "insert"
	
	$(function() {
			getLearnMatList()
			toggleButtons(status);
	});	
	
	// 모달 창 저장, 수정 버튼 변화
	function toggleButtons(status) {
	       var btnSave = document.getElementById("btnSave");
	       var btnUpdate = document.getElementById("btnUpdate");
	       var lectureList = document.getElementById("lectureList");
	       var downFileCol = document.getElementById("disfilename"); 
	       
	       if(status === 'insert') {
	    	   btnSave.style.display = "inline-block"
	    	   btnUpdate.style.display = "none"
	    		downFileCol.style.display = "none";
	       } else if(status === "update") {
	    	   btnSave.style.display = "none"
	    	  btnUpdate.style.display = "inline-block"
	    	  lectureList.style.display = "none";
	    	   downFileCol.style.display = "inline-block";
	       }
	}
	
	// 학습자료 리스트
	function getLearnMatList(currentPage) {
		var tutorId = $("#tutorId").val();
		var lecture_value = $("#searchKey").val();
		
		currentPage = currentPage || 1;
		
		console.log("currentPage = " + currentPage);
		console.log("lecture_value = " + lecture_value);
		
		var param = {
				tutorId : tutorId,
				lectureValue : lecture_value,
				currentPage: currentPage,
				pageSize : pageSize,
		}
		
		console.log(param);
		
		$.ajax({
			url:'/tut/tutorLearnMatList',
			type:"POST",
			dataType:"text",
			async: true,
			data: param,
			success:function(data) {
				console.log(data);
				learnMatListResult(data, currentPage);
			},
			error: function(error) {
				console.log(error);
			}
		})
	}
	
	// 학습자료 리스트 화면에 보이기
	function learnMatListResult(data, currentPage) {
		console.log("data = " + data);
		
		$("#listMat").empty();
		$("#listMat").append(data)
		
		var totalCount = $("#totalCount").val();
		console.log("totalCount : " + totalCount);
		
		var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'getLearnMatList');
		console.log("paginationHtml : " + paginationHtml);
		
		$("#pagination").empty().append(paginationHtml);
		
		$("#currentPage").val(currentPage);
	}
	
	
	
	// 학습자료 등록 모달 띄우기
	function fPopModalMat(){
		console.log('fPopModalMat test');
		
		//lecture_list();
		
		 gfModalPop("#mat_de");
		//데이터 넣기 
	}
	
	//학습자료 저장
	function learningMaterialsSave() {
		console.log('test')
		console.log('fsave test')
		
		var lecture_value = $("#lecture_value").val();
		var title = $("#learn_tit").val();
		var content = $('#learn_con').val();
		var file = $("#bbs_files_1").prop('files')[0];
		
		console.log("lecture_value : " + lecture_value);
		console.log("title : " + title);
		console.log("content : " + content);
		console.log(file);
		
		if(! fValidateLearnMat()) {
			return;
		}
	
		var formData = new FormData();
			
		formData.append('lecture_value', lecture_value)
		formData.append('title', title)
		formData.append('content', content)
		formData.append('file', file);
			
		$.ajax({
			url:'/tut/saveLearningMaterials.do',
			type:"POST",
			async : true,
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
					location.reload(true)
				}
			},
			error : function(err) {
				console.log(err);
			},
		})
	}
	
	function fValidateLearnMat() {
		
		var chk = checkNotEmpty(
				[
						[ "learn_tit",  "제목을 입력해 주세요." ]
					,	[ "learn_con", "내용을 입력해 주세요" ]
					,	[ "bbs_files_1", "파일을 등록해 주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}

	//학습자료 상세 정보 불러오기
	function learningMaterialsDetail(data) {
		console.log("learningMaterialsDetail tset");
		
		status = "update"
		toggleButtons(status);
		
		var learnDataId = data;
		
		console.log("learnDataId : " + data);
		gfModalPop("#mat_de");
		
		$.ajax({
			url:'/tut/getDetailLearnMat.do',
			type:"GET",
			async : true,
			data: {
				learnDataId : learnDataId
			},
			success: function(data) {
				console.log(data.detailLearnMat);
				detailLearnMatForm(data.detailLearnMat)
			},
			error : function(err) {
				console.log(err);
			},
		})
	}
	
	// 학습자료 수정 창 초기폼
	function detailLearnMatForm(data) {

		var isoDate = data.writeDate;
		var date = new Date(isoDate);
		
		var formattedDate = date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
		
		$("#learnMatId").val(data.learn_data_id);
		$("#learn_tit").val(data.learnTitle);
		$("#w_date").val(formattedDate);
		$("#learn_con").val(data.learnContent);
		$("#fileDownLoad").text(data.materials_orginal_fname);
		$("#fileDownLoad").attr('href', "/tut/fileDownload/" + data.materials_fname);
	}
	
	//학습자료 수정
	function learningMaterialsUpdate() {
		var learnMatId = $("#learnMatId").val();
		console.log(learnMatId);
		
		var updateLearnTitle =  $("#learn_tit").val();
		var updateLearnContent = $("#learn_con").val();
		var file = $("#bbs_files_1").prop('files')[0];
	
		console.log("updateLearnTitle : "  + updateLearnTitle);
		console.log("updateLearnContent : "  + updateLearnContent);
		console.log(file);
	
		var formData = new FormData();
		
		formData.append("learnMatId", learnMatId);
		formData.append("updateLearnTitle", updateLearnTitle);
		formData.append("updateLearnContent", updateLearnContent);
		
		if(file === null || file === undefined || file === '') {
			console.log("update File 없음");
			formData.append("file", null);
		} else {
			console.log('update File 있음');
			formData.append("updateFile", file);
		}

		var param = {
				learnMatId : learnMatId,
				updateLearnTitle : updateLearnTitle,
				updateLearnContent : updateLearnContent,
		}
		
	
		$.ajax({
			url: '/tut/updateLearnMat.do',
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
	
	// 학습자료 삭제
	function learningMaterailsDelete() {
		var learnMatId = $("#learnMatId").val();
		
		$.ajax({
			url:'/tut/deleteLearnMat.do/' + learnMatId,
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
	
	// 학습자료 등록 validation check
	function tutorLearnValidateCheck(title, content, file) {
		
		console.log("file value : " +  file);
		
		var totalStatus = false;
		var titleStatus  = false;
		var contentStatus  = false;
		var fileStatus = false;
		
		if(title.trim() === "") {
			alert("제목을 입력해주세요.")
		} else {
			titleStatus = true;
		}
		
		if(content.trim() === "") {
			alert('내용을 입력해주세요')
		} else {
			contentStatus = true;
		} 
		
		if(file === undefined || file === null || file === "") {
			alert("첨부파일을 등록해주세요")
		} else {
			fileStatus = true
		}
		
		if(titleStatus === true && contentStatus === true && fileStatus === true) {
			return true
		} else {
			return false;
		}
		return false;
	}
	
	// 강의목록 리스트 Select Box
		/*
	function lecture_list() {
		
		var tutorId = $("#tutorId").val();
		
		console.log(tutorId);
		var param = {
				tutorId : tutorId
		}
		
		$.ajax({
			url:'/tut/lectureList.do',
			type:"POST",
			dataType : "json",
			async : true,
			data: param,
			success: function(data) {
				console.log(data.lectureList);
				loadingLectureList(data.lectureList);
				loadingSearchKeyList(data.lectureList);
			},
			error : function(err) {
				console.log(err);
			},
		})
	}
	
	function loadingSearchKeyList(lectureData) {
		var selectElement = document.getElementById('searchKey');
		selectElement.HTML = "";
		
		for(var i = 0; i < lectureData.length; i++) {
			var lecture = lectureData[i];
			if(lecture.lec_name != null) {
				addOption(selectElement, lecture.lec_id, lecture.lec_name);
			}
		}
	}
	
	function loadingLectureList(lectureData) {
		console.log("lectureList : " + lectureData);
		var selectElement = document.getElementById('lecture_value');
		selectElement.HTML = "";
		
		for(var i = 0; i < lectureData.length; i++) {
			var lecture = lectureData[i];
			if(lecture.lec_name != null) {
				addOption(selectElement, lecture.lec_id, lecture.lec_name);
			}
		}
	}
	
	function addOption(selectElement, value, text) {
		var option = document.createElement("option");
		option.value = value;
		option.text = text;
		console.log(option.value);
		selectElement.appendChild(option);
	}
	*/

	
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
								class="btn_nav">학습 관리</a> <span class="btn_nav bold">학습 자료</span> <a href="#" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle" id="searcharea">
							<span>학습 자료</span> 
							 <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 150px;" >
								 	<c:forEach items="${lectureList}" var="lecture" >
										<option value="${lecture.lec_id}">${lecture.lec_name}</option>
									</c:forEach>
								</select> 
			 				<a class="btnType blue" href="javascript:getLearnMatList()"
									onkeydown="enterKey()" name="search"><span id="searchEnter">검색</span></a>							 
							
							    <a class="btnType blue" href="javascript:fPopModalMat();" name="modal"><span>학습 자료 등록</span></a>
							</span>
						</p>
						
						<div class="divMatList" id="divMatList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="15%">
									<col width="50%">
									<col width="35%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">NO</th>
										<th scope="col">제목</th>
										<th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody id="listMat"></tbody>
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
               <strong>학습자료</strong>
              <input type="text" id="tutorId" value="${loginId}" hidden>
              
            </dt>
            <dd class="content" >
                  <table class="row">
              <caption>caption</caption>
            <tbody>
            <form id=uploadfrom enctype="multipart/form-data" >
            <tr id="lectureList">
            	<th>강의목록<span class="font_red">*</span></th>
            	<td>
            		<select id="lecture_value">
						<c:forEach items="${lectureList}" var="lecture" >
							<option value="${lecture.lec_id}">${lecture.lec_name}</option>
						</c:forEach>
            		</select>
            	</td>
            </tr>
             <tr>
                <th scope="row">제목<span class="font_red">*</span> </th>
               <td id="title" colspan="3" >
	               <input type ="hidden"  id="learn_data_id"   name ="learn_data_id" >
	               <input type ="hidden"  id="lec_id " name ="lec_id " value= "lec_id" >
	               <input type ="text"  id="learn_tit"    name ="learn_tit"  class="inputTxt p100">
               </td>
              
               <th id = "wDate_1"scope="row">등록일자 </th>
               <td id = "wDate_2" colspan="3" > <input type ="text"  id="w_date"   name ="w_date" class="inputTxt p100" readonly></td>
            </tr>
            <tr>
               <th scope="row">자료내용 <span class="font_red">*</span></th>
               <td  id="con" colspan="6">
                  <textarea class="inputTxt p100" id="learn_con"  name ="learn_con" style="width:100%; border:0; resize:none;"></textarea>
               </td>
            </tr>
            <tr>
               <th scope="row">첨부파일<span class="font_red">*</span></th>
               <td colspan="6">
                    <div class="filebox bs3-primary">
                            <input type="file" id="bbs_files_1"  name="bbs_files_1" class="upload-hidden"><br/>
                            
							<div style="margin: 5px ;" id="disfilename"  name="disfilename">
								<a id="fileDownLoad">다운로드</a>
							</div>
								<input type="text" id="learnMatId" hidden/>
                              <input type="hidden" id="downloadFile"> 
                              <input type="hidden" id="downloadFileName">                                        
                        </div>
               </td>
            </tr>
            </form>
             </tbody> 
          </table>
       			<div class="btn_areaC mt30">
					<a href="javascript:learningMaterialsSave();" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a> 
					<a href="javascript:learningMaterialsUpdate();" class="btnType blue" id="btnUpdate" name="btn"><span>수정</span></a> 
					<a href="javascript:learningMaterailsDelete();" class="btnType blue" id="btnDelete" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
               </dd>
			</dl>
			
		<!-- 
		<a href="javascript:cancleBtn();" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
		 -->
	</div>
</form>
</body>
</html>