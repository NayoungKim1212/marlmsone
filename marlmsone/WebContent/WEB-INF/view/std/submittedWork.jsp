<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>나의 수강목록</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<script type="text/javascript">
// 페이지
var pagesize = 5;
var pageblocksize = 5;
//페이지유지
var submitPage=0;

// 보고 있는 게시물 정보 저장
var hwk_id="";	//과제아이디
var lec_id="";	// 강의아이디
var submit_id="";	//제출아이디

/** OnLoad event */ 
$(function() {
	submitList();
	
});




/* 수강 중 강의 목록 */
function submitList(cpage){
	
	cpage = cpage || 1;
	submitPage=cpage;
	//1. 보낼 내용
	var param = {
		cpage : cpage,
		pagesize : pagesize,
	loginID: $("#loginId").val()
	}
	//2. 콜백함수 만들기
	var listcallback = function(r){

		$("#hwkList").empty().append(r);
		var paginationHtml =getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize);
		$("#Pagination").empty().append(paginationHtml); 
		$("#cpage").val(cpage);
		

	}
	
	callAjax("/std/submitList.do", "post", "text", true, param, listcallback);
	
}

/**과제 제출*/

function saveForm(i){
	hwk_id=i;
	emptyS();
	gfModalPop("#saveModal")
}

// 등록 모달 비우기
function emptyS(){
	$("#submit_con").val("");
	$("#submitFile").val("");
}	

// 과제 저장 유효성 검사
	function fValidateS() {
		var chk = checkNotEmpty(
				[
						[ "submit_con", "내용을 입력해 주세요." ]
					,	[ "submitFile", "파일을 업로드해주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
function submitSave(){
	//1. 유효성 검사
	if(!fValidateS()){return;}
	//2. 전송 데이터 구성
 	var saveForm= document.getElementById("saveForm");	
 	saveForm.enctype='multipart/form-data';
	var fileData = new FormData(saveForm);
	fileData.append("hwk_id",hwk_id);
	//3. 콜백 함수
	var saveCallback=function(r){
		console.log('콜백함수 실행' , r)
		if(r.result=="sucess"){
			alert(r.msg)
		}else{
			alert(r.msg)
		}
		gfCloseModal();
		submitList(submitPage);
		
	}
	callAjaxFileUploadSetFormData("/std/submitSave.do", "post", "json", false, fileData, saveCallback);
}

/** 수정*/
function modifyForm(i){
	hwk_id=i;
	console.log('hwk_id: ',hwk_id)
	//1. 모달열기
	gfModalPop("#updateModal")
	//2. 기존 내용 가져오기
		//2-1. 보낼값
	var param={
		hwk_id:hwk_id
	}
	console.log('param: '+param)
		//2-2. 콜백함수 만들기
	var getFileCallback = function getFile(r){
		console.log('기존파일함수실행',r)
		submit_id=r.selinfo.submit_id
		$("#mySubmit").html('<a href="javascript:dFile();" name="dFile" id="dFile"><span id="filename" name="filename" ></sapn></a>');
		$("#filename").html(r.selinfo.submit_fname);
		$("#modify_con").html(r.selinfo.submit_con);
		
	}
	callAjax("/std/getFile.do", "get", "json", false, param, getFileCallback);
	
}

/** 과제제출 파일 다운로드*/
function dFile(){
	
	
}

// 수정 모달 비우기
function emptyM(){
	$("#modify_con").val("");
	$("#modifyFile").val("");
}	

// 과제 수정 유효성 검사
	function fValidateM() {
		var chk = checkNotEmpty(
				[
						[ "modify_con", "내용을 입력해 주세요." ]
					,	[ "modifyFile", "파일을 업로드해주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
function submitModify(){
	//console.log('제출함수 실행')
	//1. 유효성 검사
	if(!fValidateM()){return;}
	//2. 전송 데이터 구성
 	var modifyForm= document.getElementById("modifyForm");	
 	modifyForm.enctype='multipart/form-data';
	var fileData = new FormData(modifyForm);
	fileData.append("hwk_id",hwk_id);
	fileData.append("submit_id",submit_id);
	//3. 콜백 함수
	var modifyCallback=function(r){
		console.log('수정콜백함수 실행' , r)
		if(r.result=="sucess"){
			alert(r.msg)
		}else{
			alert(r.msg)
		}
		gfCloseModal();
		submitList(submitPage);
		
	}
	callAjaxFileUploadSetFormData("/std/submitModify.do", "post", "json", false, fileData, modifyCallback);
}


/**파일 (과제제출파일)다운로드*/
function dFile(){
		var params = "<input type='hidden' name='hwk_id' value='"+ hwk_id +"' />";
		//<body> 해당 폼 넣었다가 삭제하기
		$("<form action='/std/submitDownload.do' method='post' id='fileDownload'>" + params + "</form>"
		).appendTo('body').submit().remove();
}



/**모달 닫고 새로고침*/
function close(){
	// emptyM();
	gfCloseModal();
	submitList(submitPage);
	
}





</script>
</head>
<body>

<input type="hidden"  id="hwk_id" name="hwk_id" value=""><!-- 과제번호 -->


<form id="myForm" action=""  method="">
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
								<a href="" class="btn_set home">메인으로</a> <a href=""
									class="btn_nav">학습 관리</a> <span class="btn_nav bold">과제 제출</span><a href="" class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>과제 제출</span>
								
								
								<!-- 임시 과제 제출 버튼 -->
								
								
								
								
								
							</p>
							<div class="div_hwkList" id="div_hwkList">
								<table class="col">
									<caption>caption</caption>
										<colgroup>
											<col width="20%">
										    <col width="30%">
											<col width="20%">
											<col width="10%">
											<col width="10%">
											<col width="10%">
										</colgroup>
									<thead>
										<tr>
										    <th scope="col">강의명</th>
										    <th scope="col">과제명</th>
										    <th scope="col">제출기한</th>
											<th scope="col">다운로드</th>
											<th scope="col">제출</th>
											<th scope="col">제출여부</th>
																		
										</tr>
									</thead>
									<tbody id="hwkList">
									</tbody>
								</table>
								<div class="paging_area" id="Pagination"></div>
							</div>
	
						</div> <!--// content -->
							<h3 class="hidden">풋터 영역</h3>
							<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>		
			</div>
		</div>
	</form>
	
	
	<!-- 등록모달팝업 -->
	<div id="saveModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>과제제출</strong>
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
						<form action="" method="post" id="saveForm">
							<tr>
								<th scope="row">내용 <span class="font_red"></span></th>
								<td colspan=3><textarea name="submit_con" id="submit_con" cols="40" rows="5"></textarea></td>
							</tr>
							<tr>
								<th scope="row">파일 <span class="font_red"></span></th>
								<td colspan=3><input type="file" class="inputTxt p100" name="submitFile" id="submitFile"  /></td>
							</tr>
						</form>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:submitSave();" class="btnType blue" id="subSave" name="subSave"><span>등록</span></a> 
					<a href="javascript:close();" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="javascript:close();" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 등록모달팝업 -->
	
	<!-- 수정 모달팝업 -->
	<form action="" method="post" id="modifyForm" name="modifyForm">
	<div id="updateModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>과제수정</strong>
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
								<th scope="row">제출파일 </th>
								<td colspan=3 name="mySubmit" id="mySubmit"><!-- js 관리 --></td>
							</tr>
							<tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan=3><textarea name="modify_con" id="modify_con" cols="40" rows="5"></textarea></td>
							</tr>
							</tr>
							<tr>
								<th scope="row">파일 <span class="font_red">*</span></th>
								<td colspan="3" name="" id="" ><input type="file" name="modifyFile" id="modifyFile"></td>
							</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:submitModify();" class="btnType blue" id="subModify" name="subModify"><span>수정</span></a> 
					<a href="javascript:close();" class="btnType gray" ><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<!-- <a href="javascript:close();" class="closePop3"><span class="hidden">닫기</span></a>  -->
	</div>
    </form>
	<!--// 상세조회/수정 모달팝업 -->	
	</body>
</html>