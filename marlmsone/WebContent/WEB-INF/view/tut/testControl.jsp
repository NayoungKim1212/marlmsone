<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>시험 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	// ajax 처리를 위해서
	// 전역 변수
	var pagesize = 10; // -- 한 페이지 당 몇개 보여줄 지
	var pageblocksize = 10; // -- 페이지 당 번호

	/********* OnLoad event */
	$(function() {
		listPage();
		
		fRegisterButtonClickEvent();
	});

	/********* 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {

		// a 태그의 이름이 btn 인 경우
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			// 현재 입력된 객체의 id 를 가져옴
			var btnId = $(this).attr('id');
			
			console.log("btnId 값 확인 : ", btnId);
			
			// id 값으로 행동을 분기
			switch (btnId) {
			case 'btnSave':
				Save();
				break;
			case 'btnDelete':
				Delete();
				break;
			case 'btnClose':
				gfCloseModal();
				break;
			}
		});

	}

	/******** 리스트 목록 */
	function listPage(cpage) {
		
		cpage = cpage || 1; // undefined 일 때 1값 나오게 설정
		
		var useyn = $("#use_yn").val();
		
		if(useyn  == "") {
			useyn = "Y";
		}		

		// key : value 의 JSON 형태로 데이터 넘기기
		var param = {
			lecList : $("#lecList").val(),	
			lec_type_id : $("#lec_type_id").val(),
			test_que : $("#test_que").val(),
			que_ans : $("#que_ans").val(),
			que_ex1 : $("#que_ex1").val(),
			que_ex2 : $("#que_ex2").val(),
			que_ex3 : $("#que_ex3").val(),
			que_ex4 : $("#que_ex4").val(),
			use_yn : useyn,
			cpage : cpage,
			pagesize : pagesize,
		};

		var listcallback = function(response) {
			console.log(response);
			$("#testPagination").show();
			$("#listTestbody").empty().append(response);
			console.log($("#listcnt").val());
			
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(),
					pagesize, pageblocksize, 'listPage');
			console.log("paginationHtml : " + paginationHtml);
			
			$("#testPagination").empty().append(paginationHtml); 
			
			$("#cpage").val(cpage);
			
			
			
		};

		// callAjax(url, method, dataType, async, param, callback)
		// async : false , sync : true -- 비동기(요청하고 다른 동작 가능) / 동기
		callAjax("/tut/testList.do", "post", "text", false, param, listcallback);
		
	}
	
	/**********시험 분류 목록 조회 하는 함수*/
	function lectureList(cpage) {
		
		cpage = cpage || 1; 
		
	
		var lec_type_id = $("#lecList").val();
		
		var param = {
				lec_type_id : lec_type_id 
		}
		
		console.log("=====lec_type_id" , lec_type_id);
		var callback = function(response){
			callback_lectureList(response, cpage);
		}
		
		callAjax("/tut/testList.do", "post", "text", param, true, callback);
	}
	
	/* 시험 분류 목록 조회 콜백함수 */
	function callback_lectureList(response, cpage){
		

		console.log("listCnt : " + $("#listCnt").val());

        $("#lec_type_name").val(data.lec_type_name);
		$("#test_que").val(data.test_que);
		$("#que_ans").val(data.que_ans);
		$("#que_ex1").val(data.que_ex1);
		$("#que_ex2").val(data.que_ex2);
		$("#que_ex3").val(data.que_ex3);
		$("#que_ex4").val(data.que_ex4);
	
		// 총 개수 추출
		var lecListCnt = $("#listCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml( cpage, 
												lecListCnt, 
												pagesize, 
												pageblocksize, 
												'lectureList' );	 
		
		$("#testPagination").empty().append( paginationHtml );
		$("#listTestbody").empty().append(response);
	}
	

	/**********모달 팝업 하는 함수*/
	function newreg() {
		init();

		// layer1 을 모달 팝업 -> 닫기
		//alert("모달모달");
		gfModalPop("#layer1");
		Close();
	}

	function init(data) {
		if (data != null) {
			$("#que_id").val(data.que_id);
			$("#lec_type_id").val(data.lec_type_id);
			$("#test_que").val(data.test_que);
			$("#que_ans").val(data.que_ans);
			$("#que_ex1").val(data.que_ex1);
			$("#que_ex2").val(data.que_ex2);
			$("#que_ex3").val(data.que_ex3);
			$("#que_ex4").val(data.que_ex4);
			$("#inactive").val(data.use_yn);
			$("#action").val("U"); // 수정일 때 U 값으로 초기화	
			
		 	$("#lec_type_id").prop("disabled", true);
			
		} else {

			
			$("#lec_type_id").val("");
			$("#test_que").val("");
			$("#que_ans").val("");
			$("#que_ex1").val("");
			$("#que_ex2").val("");
			$("#que_ex3").val("");
			$("#que_ex4").val("");
			$("#inactive").val("")
			$("#action").val("I"); // 신규 등록일 때 I 값으로 초기화

		}
	}

	/********* 모달에서 글 저장 하는 코드 */
	function Save() {
		// 값을 잘 가져오는지 확인
		//console.log($("#test_type_id").val());
		//console.log($("#test_que").val());

		console.log("Save()함수 실행 ");
		
		// 유효성체크하기
		if (!fValidate()) {
			return;
		}

		// 들어온 값을 저장하기위해 값을 저장
		var param = {
			lec_type_id : $("#lec_type_id").val(),
			test_que : $("#test_que").val(),
			que_ans : $("#que_ans").val(),
			que_ex1 : $("#que_ex1").val(),
			que_ex2 : $("#que_ex2").val(),
			que_ex3 : $("#que_ex3").val(),
			que_ex4 : $("#que_ex4").val(),
			use_yn : $("#inactive").val(),
			action : $("#action").val(),
			que_id : $("#que_id").val()
			
		}

		//console.log(" 저장 파람 확인 : ", param);
		var savecallback = function(response) {
			// json 형태로 가져오기 때문에 그대로 찍으면 object 로 나옴 -> String 으로 변환하여 출력
			console.log(JSON.stringify(response));

			// 값이 저장되었는지에 대한 return 을 처리
			alert(response.resultMsg);
			// 값 저장 성공시
			if (response.result > 0) {
				gfCloseModal();
				if ($("#action").val() == "I") {
					listPage();
				} else {					
					listPage($("#cpage").val());
				}
			} else {
				alert("저장이 실패되었습니다.");
			}

		}

		callAjax("/tut/testSave.do", "post", "json", false, param, savecallback);

	}

	/********* 모달에서 글 수정 하는 코드 */
	function Modify(que_id) {

		//alert('수정버튼클릭됨 ' + que_id);

		var param = {
			que_id : que_id
		};
		console.log(param);
		console.log($("#test_que").val());

		var mdfcallback = function(response) {
			console.log(JSON.stringify(response));
			init(response.selinfo);

			gfModalPop("#layer1");
		}

		callAjax("/tut/testModifyList.do", "post", "json", false, param,
				mdfcallback);
	}

	
	
	
	// 값이 입력되지 않으면 저장되지 않도록 하는 validation체크 -> true / false 반환
	/********** 저장 유효성검사 validation */
	function fValidate() {

		var que_ans = document.getElementById("que_ans").value;
		
		if(isNaN(que_ans)) {
			alert("정답은 숫자로 입력해주세요.");
			return false;
		}
		
		var chk = checkNotEmpty([ [ "lec_type_id", "시험분류를 선택해 주세요." ],
				[ "test_que", "문제내용을 입력해 주세요" ], [ "que_ans", "정답을 입력해 주세요" ],
				[ "que_ex1", "보기1을 입력해 주세요" ], [ "que_ex2", "보기2을 입력해 주세요" ],
				[ "que_ex3", "보기3을 입력해 주세요" ], [ "que_ex4", "보기4을 입력해 주세요" ],
				[ "inactive", "사용여부 선택해주세요" ] ]);
		
		
		if (!chk) {
			return;
		}

		return true;
	}

	/********** 체크박스  코드 */
	function selectAll() {
		
	    var checkboxes = document.getElementsByClassName('rowCheckbox');
	    for (var i = 0; i < checkboxes.length; i++) {
	        checkboxes[i].addEventListener('change', updateAllCheckbox);
	    }
	};

	function updateAllCheckbox() {
	    var checkboxes = document.getElementsByClassName('rowCheckbox');
	    var allCheckbox = document.getElementById('allRowCheck');

	    var allChecked = true;
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (!checkboxes[i].checked) {
	            allChecked = false;
	            break;
	        } 
	    }

	    allCheckbox.checked = allChecked;
	}

	window.onload = function() {
	    var allCheckbox = document.getElementById('allRowCheck');
	    allCheckbox.addEventListener('change', function() {
	        var checkboxes = document.getElementsByClassName('rowCheckbox');
	        for (var i = 0; i < checkboxes.length; i++) {
	            checkboxes[i].checked = allCheckbox.checked;
	        }
	    });

	    var checkboxes = document.getElementsByClassName('rowCheckbox');
	    for (var i = 0; i < checkboxes.length; i++) {
	        checkboxes[i].addEventListener('change', updateAllCheckbox);
	    }
	};


	
	
	/********** 비활성화 체크박스 리스트 코드 */
	function showDeactiveCk() {
		var deactiveCheckbox = document.getElementById("deactiveCk");
		var use_yn = deactiveCheckbox.checked ? "N" : "Y";
		
	    document.getElementById('allRowCheck').checked = false;
		
		 if (use_yn === "N") { //체크박스가 체크 안되어 있으면 사용여부Y인 데이터와 비활성 버튼 나옴
		        $("#use_yn").val("N");
		        $("#activebtn").empty().append("활성");
		        // $("#allRowCheck").val();
		    } else if (use_yn === "Y") { // 체크박스가 체크되고 사용여부N인 데이터와 활성 버튼 나옴
		        $("#use_yn").val("Y");
		        $("#activebtn").empty().append("비활성");
		        // $("#allRowCheck").val();
		    }
		
		listPage();
	}
	

	

	/**********비활성하는 코드 */
	function Deactivate(que_id) {
		//alert('삭제버튼클릭됨 ' + que_id);
		var selectedItems = ""; // 선택한 항목들을 저장할 배열
		var deactiveCheckbox = document.getElementById("deactiveCk");
		var checkboxes = document.getElementsByClassName('rowCheckbox');
		
	    document.getElementById('allRowCheck').checked = false;

		// 체크박스 선택 유무를 확인하여 유효성 검사를 수행
	    var isChecked = false;
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            isChecked = true;
	            break;
	        }
	    }

	    if (!isChecked) {
	        alert("문제를 선택해주세요.");
	        return;
	    }

		for (var i = 0; i < checkboxes.length; i++) {
			console.log("checkBoxed Value" + i + ":" + checkboxes[i].checked);
			if (checkboxes[i].checked) {
				selectedItems += checkboxes[i].getAttribute('data-item-id')
						+ " ";
			}
		}

		var data = {
			selectedItems : selectedItems,
			
		};
		
		callAjax("/tut/testDeactivate.do", "post", "json", false, data,
				function(response) {
					alert(response.deactResultMsg);
					console.log(response); 
					 if(response.result === "SUCCESS") {
						 listPage();
		                }
				});
		
	}
		

	
</script>

</head>
<body>
	<form id="myForm" action="" method="">

		<!--
		신규와 수정을 동일한 창으로 넘기기 때문에 flag 값을 주어 확인할 수 있도록 한다
		초기 값 = 빈값
		수정할 때, 게시판 번호 사용하기 위해서 hidden 
	 -->
		<input type="hidden" id="action" name="action" value="" /> 
		<input type="hidden" id="que_id" name="que_id" value="" />
		<input type="hidden" id="use_yn" name="use_yn" value="" />
    

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
								<a href="../notice/notice.do" class="btn_set home">메인으로</a> <span
									class="btn_nav bold">학습 관리</span> <span class="btn_nav bold">시험
									관리 </span> <a href="/tut/testControl.do" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>시험 문제 관리</span> <span class="fr"> <label
									for="deactiveCk"> <input type="checkbox"
										name="deactiveCk" id="deactiveCk" onchange="showDeactiveCk(event)"> 비활성화 문제&nbsp;&nbsp;
								</label> 
								<select id="lecList" style="width: 200px"; onchange="listPage()">	
									<option value="">시험분류 선택</option>
										<c:forEach items="${lecList}" var="list" >
											<option value="${list.lec_type_id}">${list.lec_type_name}</option>
										</c:forEach> 
									</select>						
								&nbsp; <a class="btnType blue" href="javascript:newreg();"
									name="newreg" id="newreg"><span>문제등록</span></a>
								</span>
							</p>

							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="8%">
										<col width="8%">
										<col width="20%">
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="8%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">전체선택&nbsp;<input type="checkbox"
												name="allRowCheck" id="allRowCheck" onclick='selectAll()'></th>
											<th scope="col">시험분류</th>
											<th scope="col">문제</th>
											<th scope="col">정답</th>
											<th scope="col">보기1</th>
											<th scope="col">보기2</th>
											<th scope="col">보기3</th>
											<th scope="col">보기4</th>
											<th scope="col"><div class="btn_areaC">
													<a class="btnType3 color1"
														href="javascript:Deactivate('que_id');"><span id="activebtn" >비활성</span></a></th>

										</tr>
									</thead>
									<tbody id="listTestbody"></tbody>
								</table>
							</div>

							<div class="paging_area" id="testPagination"></div>




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
					<strong>시험문제 등록</strong>
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
								<th scope="row">시험분류<span class="font_red">*</span></th>
								<td colspan="7"><select name="sort" id="lec_type_id"
									style="width: 100%;" >
										<c:forEach items="${lecList}" var="list">
											<option value="${list.lec_type_id}">${list.lec_type_name}</option>
										</c:forEach> 
								</select></td>
							</tr>
							<tr>
								<th scope="row">문제 <span class="font_red">*</span></th>
								<td colspan="7"><textarea name="test_que" id="test_que"
										class="inputTxt p100" cols="40" rows="1"></textarea></td>
							</tr>
							<tr>
								<th scope="row">정답 <span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p50"
									name="que_ans" id="que_ans" /></td>
							</tr>

							<tr>
								<th scope="row">보기1 <span class="font_red">*</span></th>
								<td colspan="7"><textarea name="que_ex1" id="que_ex1"
										class="inputTxt p100" cols="40" rows="1"></textarea></td>
							</tr>
							<tr>
								<th scope="row">보기2<span class="font_red">*</span></th>
								<td colspan="7"><textarea name="que_ex2" id="que_ex2"
										class="inputTxt p100" cols="40" rows="1"></textarea></td>
							</tr>
							<tr>
								<th scope="row">보기3 <span class="font_red">*</span></th>
								<td colspan="7"><textarea name="que_ex3" id="que_ex3"
										class="inputTxt p100" cols="40" rows="1"></textarea></td>
							</tr>
							<tr>
								<th scope="row">보기4 <span class="font_red">*</span></th>
								<td colspan="7"><textarea name="que_ex4" id="que_ex4"
										class="inputTxt p100" cols="40" rows="1"></textarea></td>
							</tr>
							<tr>
								<th scope="row">사용여부<span class="font_red">*</span></th>
								<td colspan="7"><select name="inactive" id="inactive"
									style="width: 100%;">
										<option value="Y">활성화</option>
										<option value="N">비활성화</option>
								</select></td>
							</tr>
						</tbody>


					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType blue" id="btnSave" name="btn"><span>저장</span></a>
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>취소</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>

		<!--// 모달팝업 -->
	</form>
</body>
</html>