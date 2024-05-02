<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>시설 관리 : 장비 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">	

	/** 페이징 사이즈 조절 */
	var pagesize = 10;			// -- 한 페이지 당 몇개 보여줄 지
	var pageblocksize = 10;		// -- 페이지 당 번호

	/** OnLoad event */ 
	$(function() {
		nameSearch();
		fRegisterButtonClickEvent();
		
		// 강의실 list 모달에 등록
		
	});
	

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		
		$("#searchbtn").click(function(e){
			e.preventDefault();	// submit시에 창이 넘어가는 것을 방지
			nameSearch();
		});
		
		// a 태그의 이름이 btn 인 경우
		$('a[name=btn]').click(function(e) {
			e.preventDefault();
			
			// 현재 입력된 객체의 id 를 가져옴
			var btnId = $(this).attr('id');
          
			// id 값으로 행동을 분기
			switch (btnId) {
				case 'btnSaveEqu' :
					SaveEqu();
					break;
				case 'btnDeleteEqu' :
					DeleteEqu();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
		
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	// 등록 모달 팝업 하는 함수
	function newReg(){
		// 초기화
		init();
		gfModalPop("#layer1");
	}
	
	// 값 초기화 함수
	function init(data){
		
		if(data!=null){
			$("#lecrm_id").val(data.lecrm_id);//
			$("#lecrm_name").val(data.lecrm_name);
			$("#equ_id").val(data.equ_id);
			$("#equ_name").val(data.equ_name);
			$("#equ_num").val(data.equ_num);
			$("#equ_note").val(data.equ_note);
			$("#action").val("U");	// 수정 = U
			$("#btnDelete").show();	// 삭제버튼 O
		} else {
			$("#lecrm_id, #lecrm_name, #equ_id, #equ_name, #equ_num, #equ_note").val("");
			$("#action").val("I");	// 신규 = I
			$("#btnDelete").hide();	// 삭제버튼 X
		}
	}
	
	// 강의실 or 장비 명 검색 함수
	function nameSearch(cpage){
		// 현재 페이지
		cpage = cpage || 1;	// undefined 일 때 1값 나오게 설정
		
		// JSON - key : value
		var param = {
			searchOption : $("#searchOption").val(),
			searchName : $("#searchName").val(),
			cpage : cpage,
			pagesize : pagesize,
		};
		//alert("searchOption , searchName 선택 값 확인 : " + param.searchOption + ", " + param.searchName); 
		
		var listCallback = function(response){
			//console.log(response);
			$("#listEquBody").empty().append(response);
			
			// common.js 의 페이징 getPaginationHtml() 함수 사용
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'nameSearch'); 
			console.log("paginationHtml : " + paginationHtml);	
			
			$("#equPagination").empty().append(paginationHtml); 
			
			// 보고있는 페이지 유지를 하기 위함
			$("#cpage").val(cpage);
			
		};
		
		// callAjax(url, method, dataType, async, param, callback)
			// async : false , sync : true -- 비동기(요청하고 다른 동작 가능) / 동기
		callAjax("/adm/equManagementList.do", "post", "text", false, param, listCallback);
	}
	
	
		
	// 모달에서 글 저장 하는 함수
	function SaveEqu(){
		// flase 값이 들어오면 -> return
		if(!fValidate()){
			return;
		}
		
		// 들어온 값을 저장하기위해 값을 저장
		var param = {
				lecrm_id : $("#lecrm_id").val()
				, equ_name : $("#equ_name").val()
				, equ_num : $("#equ_num").val()
				, equ_note : $("#equ_note").val()
				, action : $("#action").val() 
				, equ_id : $("#equ_id").val()
		}
		
		//console.log(param.lecrm_id);
		
		var savecallback = function(response){
			console.log(JSON.stringify(response));	
		
			// 값이 저장되었는지에 대한 return 을 처리
			alert(response.resultmsg);
			// 값 저장 성공시
			if(response.result == "S") {
				gfCloseModal();
				if($("#action").val() == "I") {
					nameSearch();
				} else {
					nameSearch($("#cpage").val());
				}
			}
			
		}
		
		callAjax("/adm/equSave.do", "post", "json", false, param, savecallback);
		
	}
	
	
	// 장비 수정 - 상세
	function equDtl(equ_id){
		var param = {
				equ_id : equ_id
		}
		
		var delcallback = function(response){
			console.log(JSON.stringify(response));

			init(response.selinfo);	
			gfModalPop("#layer1");
		}
		
		callAjax("/adm/equManagementDtl.do", "post", "json", false, param, delcallback);
	}
	

	// 강의실 삭제
	function DeleteEqu(lecrm_id){
		$("#action").val("D");
		SaveEqu();
	}
	
	/** 장비 등록/수정 저장 validation */
	function fValidate() {
		var chk = checkNotEmpty(
				[
						[ "lecrm_name", "강의실 명을 입력해 주세요." ]
					,	[ "equ_name", "장비 명을 입력해 주세요" ]
					,	[ "equ_num", "장비 수를 입력해 주세요" ]
				]
		);

		if (!chk) {
			return;
		}
		return true;
	}
	
	// 필터링
	/** 숫자 필터링 */
    function formatNumber(id) {
        var searchWord_std = document.getElementById(id);
        // 숫자로만 이루어진 문자열인지 확인
        var number = searchWord_std.value.replace(/[^0-9]/g, "");
        console.log(number);
        
        // 입력된 내용을 변경된 번호로 업데이트
        searchWord_std.value = number;
    }
	
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	
	<!--
		lecrm_id	-> 강의실 정보 수정/삭제시 PK 값으로 인덱싱하기 위해서 hidden 으로 저장
		action		-> I : insert , U : update, D : delete 
	 -->
	 <input type="hidden" id="equ_id" name="equ_id" value=""/>
	 <input type="hidden" id="action" name="action" value=""/>
	 <input type="hidden" id="cpage" name="cpage" value=""/>
	
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
								class="btn_nav bold">시설 관리</span> <span class="btn_nav bold"> 장비 관리
								</span> <a href="" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>장비 관리</span> <span class="fr">

		                     <select id="searchOption" name="searchOption">
		                     	<option value="room">강의실 명</option>	
		                     	<option value="equ">장비 명</option>	
		                     </select>
		                     <input type="text" id="searchName" name="searchName" class="form-control" placeholder="" style="height: 28px;" / >
	
		                       <a class="btnType blue" href="" name="searchbtn" id="searchbtn"><span>검색</span></a>
		                       <a class="btnType blue" href="javascript:newReg();" name="newReg" id="newReg"><span>장비 신규등록</span></a>
		                     </span>
                  		</p>
							
							
						<%-- 강의실 장비정보 table --%>
						<div class="divEquList divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="20%">
									<col width="15%">
									<col width="10%">
									<col width="40%">
									<col width="15%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의실 명</th>
										<th scope="col">장비 명</th>
										<th scope="col">장비 수</th>
										<th scope="col">비고</th>
										<th scope="col"></th>
									</tr>
								</thead>
								
								<tbody id="listEquBody"></tbody>
								
							</table>
						</div>
						<div class="paging_area"  id="equPagination"> </div>
			
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 // 장비 수정 -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>장비 등록</strong>
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
							<th scope="row">장비 명<span class="font_red">*</span></th>
							<td colspan=3><input type="text" class="inputTxt p100" name="equ_name" id="equ_name" /></td>
						</tr>
						<tr>
							<th scope="row">장비 수<span class="font_red">*</span></th>
							<td>
								<input type="text" class="inputTxt p100" name="equ_num" id="equ_num"  
								oninput="javascript:formatNumber('equ_num');"
								placeholder="숫자 입력"/>
							</td>
							<th scope="row">강의실<span class="font_red">*</span></th>
							<td >
								<%-- nameSearch() 시 가져올 강의실 이름 정보 --%>
								
								<select id="lecrm_id" name="lecrm_id">
									<c:if test="${roomCnt eq 0}">
										<option>강의실 없음</option>
									</c:if>
									
									<c:if test="${roomCnt > 0 }">
										<c:forEach items="${roomlist}" var="list">
											<option value="${list.lecrm_id}">${list.lecrm_name}</option>
										</c:forEach>
									</c:if>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">비고</th>
							<td colspan=3><input type="text" class="inputTxt p100" name="equ_note" id="equ_note" /></td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="" class="btnType blue" id="btnSaveEqu" name="btn"><span>저장</span></a> 
					<a href="" class="btnType blue" id="btnDeleteEqu" name="btn"><span>삭제</span></a> 
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	<!--// 모달팝업 -->
</form>
</body>
</html>