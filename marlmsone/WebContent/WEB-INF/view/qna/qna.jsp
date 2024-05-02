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

	/*페이징 처리를 위한 (전역)변수*/
	var pagesize = 5;	// -- 한 페이지 당 몇개 보여줄 지
	var pageblocksize =5;	// -- 페이지 당 번호
	
	var pagesize2 =10;
	var pageblocksize2=5;
	
	/*수정,삭제 후 페이지 유지를 위한 변수*/
	var qnaPage=0;
	var commentPage=0;
	/*글 수정을 위해 글번호 받아두기 위해 */
	var qnaNo=0;
	
	/*댓글 수정,삭제를 위해*/
	//var rv_id=0;
	var mrv_con=""; //수정 시 기존 내용을 가져오기 위해 변수 선언
	
	//hidden에 담긴 값 사용하기
	//$("#user_type").val()
	
	/** OnLoad event */ 
	$(function() {	
		qnaList();

		if($("#user_type").val()=='A'){
			$("#newreg").show();
		} else {
			$("#newreg").hide();
		}
	});
	
	
	/**게시글 출력 함수(+검색 기능)*/
	function qnaList(cpage) {
		cpage = cpage || 1; //cpage가 null일 때 'OR' 연산자를 사용한 표현
		
		qnaPage=cpage;
		
		var param = {
				searchtitle : $("#searchtitle").val(),
				cpage:cpage,
				pagesize:pagesize	
		};
		
		var listcallback = function(res) {
			console.log('출력페이지')
			$("#qnaList").empty().append(res); //<tbody> 아래 내용 지우고 받아온 내용 더하기
			
			//$("#listcnt").val() : qnaList.jsp에서 <input> hidden으로 해서 listcnt 가져왔음
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'qnaList'); 
			$("#qnaPagination").empty().append(paginationHtml); 
			
		}
									//text : html로 불러옴
		callAjax("/qnaList.do", "post", "text", false, param, listcallback);
		
	}

	
	/**글쓰기 팝업 */
	function wirteBtn(){
		 init();
		gfModalPop("#layer1")//모달창 띄우기(jquery.model.js 함수 사용)		
	}
	
	/**글 등록 함수*/
	function qnaSave(){
		var qna_title = $("#qna_title").val();
		var qna_con = $("#qna_con").val().replace(/\n/g, "<br>");
		
		//유효성검사
		if(!fValidate()) {
			return;
		}
		//저장 내용
		 var param = {
				qna_title: qna_title,
				qna_con:qna_con,
		} 
		
		// 콜백할 함수
		var saveCallback = function(r){
			//백단에서 msg도 map에 담아 보냈음
			alert(r.msg);
			
			if(r.result == "S") {
				qnaList();
				gfCloseModal();
			}
			
		}
								//json: 전달 받을 데이터 타입.
		callAjax("/qnaSave.do", "post", "json", false, param, saveCallback);
		
		
	}	
	
	/**form 비우기*/
	function init(data){
		if(data!=null){
			//$("#qna_id").val(data.qna_id);
			$("#qna_title").val(data.qna_title);
			$("#qna_con").val(data.qna_con);
			//$("#action").val("U");	// 수정일 때 U 값으로 초기화
			//$("#btnDelete").show();	// 신규 등록일 때 삭제 버튼을 드러내기
		} else {
			//$("#notice_id").val("");
			$("#qna_title").val("");
			$("#qna_con").val("");
			//$("#action").val("I");	// 신규 등록일 때 I 값으로 초기화
			//$("#btnDelete").hide();	// 신규 등록일 때 삭제 버튼을 숨기기
		}
	}
	
	/**유효성 검사: 빈 값 없도록*/
	function fValidate() {
					// common.js 함수 호출
		var chk = checkNotEmpty(
				[
						[ "qna_title", "제목을 입력해 주세요." ]
					,	[ "qna_con", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}
	
	/**상세조회*/
	function qnaView(qna_id){

		qnaNo = qna_id;
		//댓글
		//commentList(qnaNo);
		var param = {
				qna_id :qna_id
		}
		
		var viewCallback = function(r){
			// console.log(r);
			 $("#viewPop").empty().append(r);
			 gfModalPop("#viewPop") //팝업열기
		}
		callAjax("/qnaView.do", "get", "text", false, param, viewCallback);
	}
		
	/**수정 모달창 열고 기존 내용 가져오기*/
	function qnaModifyPop(){
		//1. 새로운 모달창 띄우기 (등록/취소 버튼)
		gfModalPop("#modifyPop")
		//2.기존 내용 가져오기
			//2-1. 가져올 게시글 번호 전달
		var param= {
			qna_id : qnaNo
		}
			//2-2. ajax 통신을 위한 함수
		var getContent = function(r){
			//console.log('수정을 위해 기존 내용 가져올 함수 실행'); console.log(r);
			$("#modify_title").val(r.vo.qna_title);
			$("#modify_con").val(r.vo.qna_con);
		}
			//2-2. ajax로 값 가져오기		
		callAjax("/qnaOldView.do", "get", "json", false, param, getContent);
	}
	
	/**수정(업데이트)*/
	function qnaModify(){

		//1. 유효성: 빈칸일 때 알림창
		if(!fValidateModify()){return;}
		
		//2. 전달 데이터 (+줄바꿈처리로직)
		var newTitle = $("#modify_title").val();
		var newCon = $("#modify_con").val().replace(/\n/g, "<br>");		
			
		var modifyData ={
				qna_id: qnaNo
				,qna_title: newTitle
				,qna_con: newCon
		}
			
		//3. 등록 누를 시 업데이트 [성공(실패)시 메시지]
		var modifyCallback = function(r){
			if(r.success==true){
				alert(r.msg);
				qnaList(qnaPage)
				gfCloseModal()
			}else{
				alert(r.msg);
				qnaList(qnaPage)
				gfCloseModal();
			
			}
		}
		
		callAjax("/qnaModify.do", "post", "json", false, modifyData, modifyCallback);
	}

	
	/*수정 시 빈칸 유효성 검사를 위한 함수*/
	function fValidateModify() {
		var chk = checkNotEmpty(
				[
						[ "modify_title", "제목을 입력해 주세요." ]
					,	[ "modify_con", "내용을 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}	
	
	/*삭제*/
	function qnaDelete(){
		var param = {
				qna_id: qnaNo
				}
		
		var deleteCallback = function(r){
			if(r.success==true){
				alert(r.msg);
				qnaList(qnaPage);
				gfCloseModal();
			}else{
				alert(r.msg);
				qnaList(qnaPage);
				gfCloseModal();
			}
		}
		callAjax("/qnaDelete.do", "post", "json", false, param, deleteCallback)
		
	}

	//모달창 닫기
	function viewClose(){
		//페이지 유지
		qnaList(qnaPage);
		//모달닫기
		gfCloseModal();
	}

	
	function qnaList(cpage) {
		cpage = cpage || 1; //cpage가 null일 때 'OR' 연산자를 사용한 표현
		
		qnaPage=cpage;
		
		var param = {
				searchtitle : $("#searchtitle").val(),
				cpage:cpage,
				pagesize:pagesize	
		};
		
		var listcallback = function(res) {
			$("#qnaList").empty().append(res); //<tbody> 아래 내용 지우고 받아온 내용 더하기
			
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'qnaList'); 
			$("#qnaPagination").empty().append(paginationHtml); 
			
		}
									//text : html로 불러옴
		callAjax("/qnaList.do", "post", "text", false, param, listcallback);
		
	}
	
	/**댓글 전체 조회*/
	function commentList(qnaNo){
		var param={
				qna_id:qnaNo
		}
		var commentListCallback= function(r){
			//console.log('댓글 출력 ajax 함수 실행',r);
			$("#commentList").empty().append(r);
			var paginationHtml2 = getPaginationHtml(commentPage,$("commentcnt").val(),pagesize2,pageblocksize2);
			$("#commentPagenation").empty().append(paginationHtml2);
	
	        
		}
		callAjax("/commentList.do", "post", "text", false, param, commentListCallback);
	}
	
	/**댓글 등록*/
	function commentSave(){
		var rv_con = $("#rv_con").val();
		if(!cValidateSave()){return;}
		var param ={
				qna_id:qnaNo,
				rv_con:rv_con
		}
		var commentSaveCallback =function(r){
			//console.log('댓글저장콜백함수실행',r);
			alert(r.msg);
			if(r.result == "S") {
				qnaView(qnaNo);
			}
			
		}
		callAjax("/commentSave.do", "post", "json", false, param, commentSaveCallback);
		
	}
	
	
	//댓글 등록 유효성 검사
	function cValidateSave() {
		var chk = checkNotEmpty(
				[
						[ "rv_con", "댓글을 입력해주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}	
	
	/**댓글수정(업데이트)*/
	function commentModify(rv_id){
		
		//0. 기존 내용 가져오기
		//commentOldView(rv_id);
		
		//1. 유효성: 빈칸일 때 알림창
		if(!cValidateModify()){return;}
		
		console.log('유효성 검사 통과');
		
		//2. 전달 데이터 
		var rvN_con = $("#rvN_con").val();	
		console.log('수정데이터',rvN_con);
		console.log('댓글번호 : ',rv_id);
		var param ={
				rv_id:rv_id,
				rv_con: rvN_con
		}
		console.log('콜백함수 실행 시 보낼 데이터 > ',param)
			
		//3. 수정 누를 시 업데이트 [성공(실패)시 메시지]
		var commentModifyCallback = function(r){
			if(r.success==true){
				alert(r.msg);
				qnaView(qnaNo);
			}else{
				alert(r.msg);
				qnaView(qnaNo);
			
			}
		}
		
		callAjax("/commentModify.do", "post", "json", false, param, commentModifyCallback);
	}

	/*수정 시 기존 내용 가져오기*/
	function commentOldView(rv_id){
		
		param={rv_id:rv_id}
		var commentOldViewCallback = function(r){
			console.log('기존 내용 가져오는 롤백 함수 실행',r);
			
			//console.log('기존내용',r.vo.rv_con)
			$('#conditionContent').empty().append('<input type="text" style="width:500px; height: 20px; font-size:12px; margin-right: 4px;" id="rvN_con" name="rvN_con">');
			$("#rvN_con").val(r.vo.rv_con);
			//삭제/수정 중 수정 버튼 클릭 시 등록을 수정으로 변경
			$('#condition').empty().append("<a href='javascript:commentModify("+ rv_id+");' id='commentModify' name='commentModify'>수정</a>");
			
		}
		callAjax("/commentOldView.do", "post", "json", false, param, commentOldViewCallback);
	}
	
	/*수정 시 빈칸 유효성 검사를 위한 함수*/
	function cValidateModify() {
		var chk = checkNotEmpty(
				[
						[ "rvN_con", "댓글을 입력해주세요." ]
				]
		);

		if (!chk) {
			return;
		}

		return true;
	}	
	
	/* 삭제 */
	function commentDelete(rv_id){
		var param = {
				rv_id: rv_id
				}
		
		var commentDeleteCallback = function(r){
			if(r.success==true){
				alert(r.msg);
				qnaList(qnaPage);
				gfCloseModal();
			}else{
				alert(r.msg);
				qnaList(qnaPage);
				gfCloseModal();
			}
		}
		callAjax("/commentDelete.do", "post", "json", false, param, commentDeleteCallback);
		
	}
	
	
	
</script>


</head>
<body>
<form id="qnaForm" action="/qna.do"  method="get">
	
	<!--
		신규와 수정을 동일한 창으로 넘기기 때문에 flag 값을 주어 확인할 수 있도록 한다
		초기 값 = 빈값
		수정할 때, 게시판 번호 사용하기 위해서 hidden 
		user_type: 타입에 따른 기능 처리를 위해 ${sessionScope.userType}
	 -->
	 <input type="hidden" id="action" name="action" value=""/>
	 <input type="hidden" id="qna_id" name="qna_id" value=""/>
	 <input type="hidden" id="user_type" name="user_type" value="${sessionScope.userType}"/>
	 <input type="hidden" id="rv_id" name="rv_id" value=""/>
	
	
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
							<a href="../notice/aNotice.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">커뮤니티</span> <span class="btn_nav bold">Q&A
								</span> <a href="/qna.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>Q&A게시판 </span> <span class="fr">
		                     
		                                                  제목 <input type="text" id="searchtitle" name="searchtitle" />
		                       <a class="btnType blue" href="javascript:qnaList();" name="searchbtn" id="searchbtn"><span>검색</span></a>
		                       <a type="hidden" class="btnType blue" href="javascript:wirteBtn();" name="newreg" id="newreg"><span>글쓰기</span></a>
	
		                     </span>
                  		</p>
						
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="7%">
									<col width="62%">
									<col width="10%">
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
								<tbody id="qnaList"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="qnaPagination"> </div>
						
						
						
			
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>

	<!-- 게시글 등록 모달팝업 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong> Q&A 등록</strong>
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
						<form action="/qnaSave.do" name ="qnaSaveForm" method="post">
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan=3><input type="text" class="inputTxt p100" name="qna_title" id="qna_title" /></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea name="qna_con" id="qna_con" cols="40" rows="5"></textarea>
								</td>
							</tr>
						</form>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:qnaSave();" class="btnType blue" id="btnSave" name="btnSave"><span>등록</span></a>
					<a href="javascript:viewClose();" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden" >닫기</span></a>
	</div>

	<!--// 모달팝업 -->
	
	<!-- 상세조회 모달팝업 -->
	<div id="viewPop" class="layerPop layerType2" style="width: 600px;">

	</div>

	<!--// 상세조회모달팝업 -->

	<!-- 수정 모달팝업 -->
	<div id="modifyPop" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong> Q&A 수정</strong>
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
						<!-- <form action="/qnaModify.do" name ="qnaModifyForm" method="post"> -->
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan=3><input type="text" class="inputTxt p100" name="modify_title" id="modify_title" value=""/></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3">
									<textarea name="modify_con" id="modify_con" value="" cols="40" rows="5" wrap="hard"></textarea>
								</td>
							</tr>
						<!-- </form> -->
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:qnaModify();" class="btnType blue" id="btnUpdate" name="btnUpdate"><span>등록</span></a>
					<a href="javascript:viewClose();" class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
<!-- 		<a href="" class="closePop"><span class="hidden">닫기</span></a> -->
	</div>	
	
	
	
</form>

</body>
</html>