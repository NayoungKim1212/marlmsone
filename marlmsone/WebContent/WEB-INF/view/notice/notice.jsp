<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>공지사항</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	

	// ajax 처리를 위해서
	// 전역 변수
	var pagesize = 10;	// -- 한 페이지 당 몇개 보여줄 지
	var pageblocksize = 5;	// -- 페이지 당 번호
	
	//게시물 작성자 정보 유지를 위한 변수
	var writer ="";
	
	//로그인한 사람의 정보
	var user_type = "";
	var loginId ="";
	
	// 보고 있는 게시물 정보
	var noticeNo=0; //게시물번호
	var filename=""; //파일이름저장. 게시물 수정 취소 시 상황을 위해
	var fileyn=""; // 파일 있는지 없는지 여부. y/n 두가지 사용. 수정 시 사용하기 위함
	
	//페이지유지
	var noticePage=0;
	
	
	
	/** OnLoad event */ 
	$(function() {
		noticeSearch();
		fRegisterButtonClickEvent();
		loginId=$("#loginId").val()
		// 관리자와 강사만 공지사항 등록 가능 (학생 등록 불가)
		if($("#user_type").val()=='A'){
			$("#newreg").hide();
		}else{
			$("#newreg").show();
		}
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$("#searchbtn").click(function(e){
			e.preventDefault();
			noticeSearch();
		});
/*		
		// a 태그의 이름이 btn 인 경우
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
			
			// 현재 입력된 객체의 id 를 가져옴
			var btnId = $(this).attr('id');
          
			// id 값으로 행동을 분기
			switch (btnId) {
				case 'btnSave' :
					Save();
					break;
				case 'btnDelete' :
					Delete();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
*/		
	}
	
	/**전체 조회( 검색 기능 추가 )*/
	function noticeSearch(cpage){
		cpage = cpage || 1;	// undefined 일 때 1값 나오게 설정
		noticePage=cpage
		var param = {
			searchtitle : $("#searchtitle").val(),
			searchstdate : $("#searchstdate").val(),
			searcheddate : $("#searcheddate").val(),
			cpage : cpage,
			pagesize : pagesize,
		};
		
		var listcallback = function(response){
			$("#listnoticebody").empty().append(response);
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'noticeSearch'); 
			
			$("#noticePagination").empty().append(paginationHtml); 
			
			// 보고있는 페이지 유지를 하기 위함
			$("#cpage").val(cpage);
		};
		callAjax("/notice/noticelist.do", "post", "text", false, param, listcallback);
	}
	
	/**공지사항 등록*/
	
	//1. 등록 모달 팝업 하는 함수
	function saveModal(){
		//1-1글 등록 취소나 x로 모달창 닫은 뒤 재 등록 시 모달 비우기를 위함
		empty(); 
		//1-2모달창 열기
		gfModalPop("#saveModal");
	}
	//2. 글 저장 하는 함수
	function noticeSave(){
		//2-1 유효성검사
		if(!fValidate()) {
			return;
		}
		//2-2 전송 데이터(파일포함. form으로 받기)
		var saveForm = document.getElementById("saveForm");
		saveForm.enctype='multipart/form-data';
			//파일 포함 폼 전송 시 FormData로 다시 한번 감싸줘야
			//console.log(saveForm); 
			//<form action method="post" id="saveForm" enctype="multipart/form-data"></form>	
		
		var fileData = new FormData(saveForm);
			console.log(fileData); //FormData{}
		//var xml = new XMLHttpRequest();
			//console.log('xmlhttp'); console.log(xml)
		//2-3 콜백함수만들기
		var saveCallback= function(r){
			console.log('콜백함수실행');
			console.log('전달 받은 데이터');console.log(r);
			if(r.result=="sucess"){
				alert(r.msg)
			}else{
				alert(r.msg)
			}
			//모달닫기
			gfCloseModal();
			//새로고침
			noticeSearch();
		}
		//파일 첨부 포함 ajax 통신
		callAjaxFileUploadSetFormData("/notice/noticeSave.do", "post", "json", false, fileData, saveCallback);
	}
	//3. 글 등록(수정) 취소
	function noticeSaveReset(){
		gfCloseModal();//모달닫기
		noticeSearch(cpage);//새로고침(재출력)
	}
	
	
	//등록 모달 내용 비우기
	function empty(){
		$("#notice_tit").val("");
		$("#notice_con").val("");
		$("#physicalpath").val("");
	}
	
	
	//수정,출력 모달 내용 비우기
	function emptyM(){
		$("#conditionTitle").val("");
		$("#conditionCon").val("");
		$("#conditionFile").val("");
	}
	
	//등록 유효성검사: 제목과 내용에 빈칸 없도록
	function fValidate() {
		var chk = checkNotEmpty(
				[
						[ "notice_tit", "제목을 입력해 주세요." ]
					,	[ "notice_con", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/**개별출력*/
	// 수정 모달창과 출력 모달창 같이쓰기-> 본인 글일 때 수정 ()으로, 본인 글이 아닐 시 출력만 

	function noticeView(notice_id){
		noticeNo=notice_id
		gfModalPop("#updateModal");
		
	//1. 전체 조회를 통해 게시글 정보 가져오기
		//1-1 전달 값
		var param = {
			notice_id : notice_id
		}
		//1-2 ajax를 위한 함수
		var getContent = function(r){
			console.log('상세페이지 정보',r) ;
			console.log('파일명> ',r.selinfo.filename)
			writer = r.selinfo.loginID;
			physicalpath=r.selinfo.physicalpath;
			filename=r.selinfo.filename;
			fileyn=r.selinfo.file_yn
			//2-1 작성자와 로그인 아이디가 동일한 경우 수정/닫기/삭제 버튼 보이기
			
			
			$("#conditionFile").html('<span id="getFile" name="getFile"></span>');
			
			if(writer== loginId){
				$("#noticeDelete").show();
				$("#noticeModify").show();
				$("#conditionTitle").html('<input type="text" class="inputTxt p100" name="getTitle" id="getTitle" />');
				$("#conditionCon").html('<textarea name="getCon" id="getCon" cols="40" rows="5"></textarea>')
				
					//2-1-1 파일이 있으면
				if(filename!= null){
					console.log('파일 있음')
					$("#getFile").html('<a href="javascript:dFile();" name="dFile" id="dFile"><span id="filename" name="filename" ></sapn></a><span style="margin-left: 10px;color:red"><a href="javascript:fileModify();" id="fileModify" name="fileModify">변경</a></span> <span style="margin-left: 7px;color:red"><a href="javascript:fileDelete();" id="fileDelete" name="fileDelete">삭제</a></span>');
					$("#filename").text(r.selinfo.filename);
				}else{
					//2-1-2 파일이 없으면
					console.log('파일없음')
					$("#getFile").html('<input type="file" class="inputTxt p100" name="getFile" id="getFile" />');
				}
			
				$("#getTitle").val(r.selinfo.notice_tit);
				$("#getCon").val(r.selinfo.notice_con);
				$("#getFile").val(r.selinfo.filename); 
			}else{
			//2-2 동일하지 않을 경우 닫기 버튼 보이기 
				$("#noticeModify").hide();
				$("#noticeDelete").hide();
				$("#conditionTitle").html('<span id="getTitle" name="getTitle"></span>');
				$("#conditionCon").html('<span id="getCon" name="getCon"></span>')
				$("#getTitle").html(r.selinfo.notice_tit);
				$("#getCon").html((r.selinfo.notice_con).replace(/\n/g, "<br>"));
				$("#getFile").html('<a href="javascript:dFile();" name="dFile" id="dFile"><span id="filename" name="filename" ></sapn></a>');
				$("#filename").html(r.selinfo.filename);
			}
		}
		//1-3. ajax 통신
		callAjax("/notice/noticeView.do", "get", "json", false, param, getContent);
		
		
	}
	
	/**파일 다운로드*/
	function dFile(){
			var params = "<input type='hidden' name='notice_id' value='"+ noticeNo +"' />";
			//<body> 해당 폼 넣었다가 삭제하기
			$("<form action='noticeDownload.do' method='post' id='fileDownload'>" + params + "</form>"
			).appendTo('body').submit().remove();
	}
	
	/**게시물 수정*/
	function noticeModify(){
		//1. 유효성 검사
		if(!fValidateModify()) {
			return;
		}
		//2. 수정 데이터 
		var modifyForm = document.getElementById("modifyForm");
		modifyForm.enctype='multipart/form-data';
		var newFileData = new FormData(modifyForm);
		newFileData.append("noticeNo",noticeNo);
		newFileData.append("file_yn",fileyn);
		
			console.log('수정 데이터들 ' ,newFileData);
			console.log('수정 데이터들 ' ,$("#getTitle").val());
			
			
			
	
			
		//3. 콜백함수만들기
		var modifyCallback= function(r){
			console.log('수정 콜백함수 실행' , r)
			if(r.result=="sucess"){
				alert(r.msg)
			}else{
				alert(r.msg)
			}
			//모달닫기
			gfCloseModal();
			//새로고침
			noticeSearch();			
			
		}
		callAjaxFileUploadSetFormData("/notice/noticeModify.do", "post", "json", false, newFileData, modifyCallback);
		
	}
	
	/**수정 시 유효성검사*/
	function fValidateModify() {
		var chk = checkNotEmpty(
				[
						[ "getTitle", "제목을 입력해 주세요." ]
					,	[ "getCon", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}	
	
	/**파일 수정*/
	function fileModify(){
		console.log('수정 누름');
		$("#conditionFile").html('<a href="javascript:fileModifyCancel();" id="fileModifyCancel" name="fileModifyCancel"><span>취소<span></a><br><input type="file" id="getFile" name="getFile">')
			
	}
	
	/**파일 수정을 취소*/
	function fileModifyCancel(){
		console.log('수정 취소 누름');
		//$("#conditionFile").html(filename);

		$("#conditionFile").html('<span id="getFile" name="getFile"></span>');
		$("#getFile").html('<a href="javascript:dFile();" name="dFile" id="dFile"><span id="filename" name="filename" ></sapn></a>');
		$("#filename").html(filename+'<a href="javascript:dFile();" name="dFile" id="dFile"><span id="filename" name="filename" ></sapn></a><span style="margin-left: 10px;color:red"><a href="javascript:fileModify();" id="fileModify" name="fileModify">변경</a></span> <span style="margin-left: 7px;color:red"><a href="javascript:fileDelete();" id="fileDelete" name="fileDelete">삭제</a></span>');
		
	}
	
	/**파일 삭제(지우기)*/
	function fileDelete(){
		console.log('파일지우기 함수 실행');
		//삭제버튼 누르면 파일 보이는거 지워짐. 파일 input 태그 나옴
		$("#getFile").html('<input type="file" class="inputTxt p100" name="" id="getFile" />');
	}
	
	/**공지사항삭제*/
		function noticeDelete(){
		var param = {
				notice_id: noticeNo
				}
		
		var deleteCallback = function(r){
			if(r.success==true){
				alert(r.msg);
				noticeSearch(noticePage);
				gfCloseModal();
			}else{
				alert(r.msg);
				noticeSearch(noticePage);
				gfCloseModal();
			}
		}
		callAjax("/notice/noticeDelete.do", "post", "json", false, param, deleteCallback)
		
	}
	
	/**모달 닫고 새로고침*/
	function close(){
		console.log('닫고 새로고침');
		// emptyM();
		gfCloseModal();
		noticeSearch(noticePage);
		
	}	
</script>

</head>
<body>

	
	<!--
		신규와 수정을 동일한 창으로 넘기기 때문에 flag 값을 주어 확인할 수 있도록 한다
		초기 값 = 빈값
		수정할 때, 게시판 번호 사용하기 위해서 hidden 
	 -->
	 <input type="hidden" id="action" name="action" value=""/>
	 <input type="hidden" id="notice_id" name="notice_id" value=""/>
	 <!-- 권한에 따른 다른 UI를 위해 -->
	 <input type="hidden" id="user_type" name="user_type" value="${sessionScope.userType}"/>
	 <input type="hidden" id="loginId" name="loginId" value="${sessionScope.loginId}"/>
	 
	 
	
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
							<a href="/WEB-INF/view/notice/notice.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">학습지원</span> <span class="btn_nav bold">공지사항
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>공지사항</span> <span class="fr">
		                     
		                     제목
		                     <input type="text" id="searchtitle" name="searchtitle">
		                     기간
		                     <input type="date" id="searchstdate" name="searchstdate"> 
		                     ~ <input type="date" id="searcheddate" name="searcheddate"> 
	
		                       <a class="btnType blue" href="" name="searchbtn" id="searchbtn"><span>검색</span></a>
		                       <a class="btnType blue" href="javascript:saveModal();" name="saveBtn" id="newreg"><span>신규등록</span></a>
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="50%">
									<col width="15%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
										<th scope="col">조회수</th>
									</tr>
								</thead>
								<tbody id="listnoticebody"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="noticePagination"> </div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 등록모달팝업 -->
	<div id="saveModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항 등록</strong>
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
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan=3><input type="text" class="inputTxt p100" name="notice_tit" id="notice_tit" /></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea name="notice_con" id="notice_con" cols="40" rows="5"></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row">파일 <span class="font_red"></span></th>
								<td colspan=3><input type="file" class="inputTxt p100" name="physicalpath" id="physicalpath"  /></td>
							</tr>
						</form>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:noticeSave();" class="btnType blue" id="noticeSave" name="noticeSave"><span>등록</span></a> 
					<a href="javascript:close();" class="btnType gray" ><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="javascript:close();" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 등록모달팝업 -->
	
	<!-- 상세조회/수정 모달팝업 -->
	<form action="" method="post" id="modifyForm" name="modifyForm">
	<div id="updateModal" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>공지사항</strong>
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
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan=3 name="conditionTitle" id="conditionTitle"><!-- js 관리 --></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3" name="conditionCon" id="conditionCon" ><!-- js관리 --></td>
							</tr>
							<tr>
								<th scope="row">파일 <span class="font_red"></span></th>
								<td colspan=3 name="conditionFile" id="conditionFile"><!-- js관리 --></td>
							</tr>
						
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:noticeModify();" class="btnType blue" id="noticeModify" name="noticeModify"><span>수정</span></a> 
					<a href="javascript:close();" class="btnType gray" ><span>닫기</span></a>
					<a href="javascript:noticeDelete();" class="btnType gray" id="noticeDelete" name="noticeDelete" ><span>삭제</span></a>
				</div>
			</dd>
		</dl>
		<!-- <a href="javascript:close();" class="closePop3"><span class="hidden">닫기</span></a>  -->
	</div>
    </form>
	<!--// 상세조회/수정 모달팝업 -->	
	

</body>
</html>