<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>성적관리</title>

<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type ="text/javascript">
	var pagesize = 5; 
	var pageblocksize = 5; 
	
 		/*onload 부분  */
 		$(function() {
 			
 			searchBtn();
 			gradeListPage(); 
 			$("#std").hide();
 		})
 		
 		
 	// 검색 버튼 등록 
 	function searchBtn() {

 		$("#searchEnter").click(function(e){
 			e.preventDefault();
 			gradeListPage();			
 		});	
 		}

 		
 	//시험목록 리스트 불러오기 
 	function gradeListPage(cpage) {
 			
 			cpage = cpage || 1; 
 			
 			console.log("cpage : " + cpage + " searchInfo : " + $("#searchInfo").val() + " searchKey : " + $("#searchKey").val());

 			
 			var param = {
 					cpage: cpage,
 					pagesize : pagesize,
 					pageblocksize : pageblocksize,
 					searchInfo : $("#searchInfo").val(),
 					searchKey : $("#searchKey").val()
 			}
 			
 			console.log("리스트 불러오는 param======" ,param);
 			
 			
 			var listCallback = function(response) {
 				console.log(response);
 				$("#gradePagination").show(); 
 				$("#listGradeBody").empty().append(response);
 			
 				
 			var paginationHtml = getPaginationHtml(cpage, $("#totalCnt").val(),
 										pagesize, pageblocksize, 'gradeListPage');
 			console.log("paginationHtml : " + paginationHtml);
 			
 			$("#gradePagination").empty().append(paginationHtml);
 			$("#cpage").val(cpage);

 			};
 			
 			
 			callAjax("/tut/checkGradesList.do", "post", "text", false, param, listCallback );
 		}
 		
 		
 		//강의명 별 시험 응시자 리스트 
 		function StdList(lec_id){
 			$("#lec_id").val(lec_id);
 			stdListPage();
 			
 		}
 	
 		function stdListPage(cpage){
 			$("#std").show(); 
 			
 			cpage = cpage || 1; 
 			
 			var param = {
 					lec_id : $("#lec_id").val(),
 					cpage: cpage,
 					pagesize : pagesize,
 					pageblocksize : pageblocksize,
 				};
 			
 			console.log("param : ", param);
 		
 			var listCallback = function(response) {
 				console.log(response);
 				$("#stdPagination").show(); 
 				$("#listStd").empty().append(response);
 			
 				
 			var paginationHtml = getPaginationHtml(cpage, $("#stListCnt").val(),
 										pagesize, pageblocksize, 'stdListPage');
 			console.log("paginationHtml : " + paginationHtml);
 			
 			$("#stdPagination").empty().append(paginationHtml);
 			$("#cpage").val(cpage);

 			};
 			
 			
 			callAjax("/tut/checkStdList.do", "post", "text", false, param, listCallback );
 		}

 

</script>
</head>
<body>
	<form id="myForm" action="" method="">
	
		<input type="hidden" id="lec_id" name="lec_id" value="" /> 
		<input type="hidden" id="cpage" name="cpage" value="1" />
	
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
								<a href="../register/registerListControl.do"
									class="btn_set home">메인으로</a> <span class="btn_nav bold">학습관리</span>
								<span class="btn_nav bold">성적조회 </span> <a
									href="../tut/checkGrades.do"
									class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>시험목록</span> <span class="fr"> 
								<!-- searchbar --> 
								<select id="searchKey" name="searchKey" style="width: 80px;">
										<option value="all" id="all" selected="selected">전체</option>
										<option value="lec_name" id="lec_name">강의명</option>
										<option value="test_name" id="test_name">시험명</option>
								</select> 
								<input type="text" id="searchInfo" name="searchInfo"
									class="form-control" placeholder="강의명이나 시험명 검색" style="height: 28px;">
									<!-- // searchbar --> <!-- button --> <a class="btnType blue"
									href="javascript:searchBtn();" name="searchEnter" id="searchEnter"><span>검색</span></a>
							

								</span>
							</p>

							<div class="div_lec_list">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
								
									</colgroup>

									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">시험명</th>
											<th scope="col">상태</th>
											<th scope="col">대상</th>
											<th scope="col">응시자 수</th>
											<th scope="col">미응시자 수</th>
										</tr>
									</thead>
									<tbody id="listGradeBody"></tbody>
								</table>
							</div>
							<div class="paging_area" id="gradePagination"
								style="margin-bottom: 50px;"></div>

							<div id="std">
								<p class="conTitle">
									<span>응시자 목록</span> <span class="fr">

										<div class="div_std_list">
											<table class="col">
												<caption>caption</caption>
												<colgroup>
													<col width="20%">
													<col width="20%">
													<col width="20%">
												</colgroup>

												<thead>
													<tr>
														<th scope="col">아이디</th>
														<th scope="col">학생명</th>
														<th scope="col">점수</th>
														<th scope="col">통과/과락</th>
														<th scope="col">응시상태</th>
													</tr>
												</thead>
												<tbody id="listStd"></tbody>
											</table>
										</div>
										
										<div class="paging_area" id="stdPagination"></div>

									</span>
								</p>
							</div>
							<!--// content -->

							<h3 class="hidden">풋터 영역</h3>
							<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>
	

</body>
</html>