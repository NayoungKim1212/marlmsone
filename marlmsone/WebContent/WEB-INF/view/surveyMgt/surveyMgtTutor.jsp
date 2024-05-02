<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>설문 조사</title>

<!-- jQuery 사용 -->
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>

<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

	<script type="text/javascript">
		var pagesize = 5;	// -- 한 페이지 당 몇개 보여줄 지
		var pageblocksize = 5;	// -- 페이지 당 번호
	
// 		var srvyPage=0;
		
		$(document).ready(function() {
			init();
			$("#detailSurvey").hide();
			$("#resultSrvy").hide();
			$("#resultSrvyReview").hide();
			$("#lecture_name_hide").hide();
			$("#tutor_name_hide").hide();
			console.log("=======totalCnt:: " + totalCnt);
		});
		
		function fLecList(lec_id, lec_name) {
				$("#lec_id").val(lec_id);
				$("#lec_name").val(lec_name);
				$("#tutor_name_hide").hide();
				$("#lecture_name_hide").show();
				$("#resultSrvy").hide();
				$("#resultSrvyReview").hide();
				$("#listReviewContainer").hide();
				
				$("#detailSurvey").show();
				lecListSearch();
				console.log("===========lec_id:: " + lec_id);
				console.log("===========lec_name:: " + lec_name);
		};
		
		function lecListSearch(param) {

			var param= {
				lec_id: $("#lec_id").val(),
				lec_name: $("#lec_name").val(),
				tutor_name: $("#tutor_name").val(),
			};
			
			console.log("lec_id2:: " + param.lec_id);
			
			function listCallback(response) {
				console.log("=========== " + JSON.stringify(response));
			    var detailSrvyList = response.detailSrvyList;
	 		    var detailTotalCnt = response.detailTotalCnt;
				console.log("detailSrvyList:: " + detailSrvyList);
				console.log("detailTotalCnt:: " + detailTotalCnt);
				
			    if (detailSrvyList != null && detailSrvyList.length > 0) {
			        var tbody = $("#detailSurveyBody").empty();

			        detailSrvyList.forEach(function(detailList) {
			            var row = "<tr>";
			            row += "<td>" + detailList.lec_name		+ "</td>";
			            row += "<td>" + detailList.tutor_name	+ "</td>";
			            row += "<td>" + detailList.survey_percentage	+ " %</td>";
		                if (detailList.survey_percentage >= 80) {
		                    row += "<td><a class='btnType blue' href='javascript:result(" + detailList.lec_id + ");'><span>결과 확인</span></a></td>";
		                } else {
		                    row += "<td><span style='background-color: gray; padding: 7px 20px 7px 20px; color: white;'>확인 불가능</span></td>";
		                }
			            row += "</tr>";
			            tbody.append(row);
			        });
			    } else {
			        $("#detailSurveyBody").html('<tr><td colspan="5"><div style="display: flex; margin: 20px 0px 20px 0px; justify-content: center; color: #8f8f8f;">해당되는 정보가 없습니다.</div></td></tr>');
			    }
			};
			callAjax("/adm/detailSrvyList", "post", "json", false, param, listCallback);
		};
		
		function result(lec_id) {
			$("#resultSrvy").show();
			$("#resultSrvyReview").show();
			$("#lec_id").val(lec_id);
			$("#listReviewContainer").show();
			
			$.ajax({
				url: '/adm/surveyResult',
				type: 'POST',
				async:true,
				data: {
							lec_id: lec_id
						},
				success:function(data) {
					console.log("data확인", data.resultList);
					showChart(data);
					
				},
				error:function(error) {
					console.log(error)
				}
			})
		}
		
		function init(data){
			if(data != null) {
				$("#lec_id").val(data.lec_id);
				$("#lec_name").val(data.lec_name);
				$("#tutor_name").val(data.tutor_name);
			}
		};
		
		function showChart(data) {
		    console.log("showChart 값 확인 : ", data.resultNumList);
		    console.log("주관식 값 확인 : ", data.resultList);
		    showList(data.resultList);
// 		    const ctx = document.getElementById('doughnut-chart').getContext('2d');
		    // result 함수 실행했을 때 현재 함수가 계속 반복해서 나타나니 그걸 빈값으로 바꿔준 다음 불러오게 하는 장치
		    // 잘 실행되는데 오류가 난당.. 안 쓰는 ctx 주석하니 됨
		    var resultSrvyGraph = document.getElementById("resultSrvy");
		    resultSrvyGraph.innerHTML = "";
		    
		    // 각 질문에 대해 차트 생성
		    data.resultNumList.forEach(function(data) {
		        const srvyResultData = data;
	
		        // 새로운 canvas 엘리먼트 생성
		        var canvas = document.createElement('canvas');
		        // body.getElementById 쓰면 <body> 태그 밑에 추가가 되어 항상 마지막 단에 만들어지니까 새로운 div를 생성해서 그 안에 넣어줘야 한다
		        resultSrvyGraph.appendChild(canvas); // 원하는 위치에 추가 가능
	
		        var myChart = new Chart(canvas.getContext('2d'), {
		            type: 'doughnut',
		            data: {
		                labels: ["매우 그렇다", "그렇다", "보통이다", "그렇지 않다", "매우 그렇지 않다"],
		                datasets: [{
		                    label: srvyResultData.lec_name,
		                    backgroundColor: ["#70fff3", "#b3ff70", "#fff170", "#ffb870", "#ff7070"],
		                    data: [
		                           		srvyResultData.review_num_1
		                           		, srvyResultData.review_num_2
		                           		, srvyResultData.review_num_3
		                          		, srvyResultData.review_num_4
		                           		, srvyResultData.review_num_5
		                           ],
		                    borderWidth: 1
		                }]
		            },
		            options: {
		                title: {
		                    display: true,
		                    text: (srvyResultData.que_num + 1) + "번. " + srvyResultData.que,
		                },
		                responsive: true,
		                layout: {
		                	padding: {
		                		bottom: 50
		                	}
		                },
		                
		            }
		        });
		    });
		}
		
		function showList(data) {
		    console.log("data : ", data);

		    var listReviewContainer = document.getElementById("listReviewContainer");
		    listReviewContainer.innerHTML = "";

		    data.forEach(function(item) {
		        var div = document.createElement("div");

		        div.textContent = item.review;

		        listReviewContainer.appendChild(div);
		    });
		}
		
	</script>
</head>
<body>
	<form id="myForm"  method="">
		<input type="hidden" id="lec_id" name="lec_id" value=""/>
		<input type="hidden" id="tutor_name" name="tutor_name" value=""/>
		<input type="hidden" id="lec_name" name="lec_name" value=""/>
		<input type="hidden" id="loginId" name="loginId" value=""/>
		<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>
		<input type="hidden" id="detailNmTotalCnt" name="detailNmTotalCnt" value ="${detailNmTotalCnt}"/>
		<input type="hidden" id="cpage" name="cpage" value ="1"/>
		
		<!-- 모달 배경 -->
		<div id="mask"></div>
		<div id=wrap_area>
			<h2 class="hidden">header 영역</h2>
			<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
			
			<h2 class="hidden">컨텐츠 영역</h2>
			<div id="container">
				<ul>
					<li class="lnb">
						<!-- lnb 영역 -->
						<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include>
						<!--// lnb (메뉴) 영역 -->
					</li>
					<li class="contents">
						<!-- contents -->
						<h3 class="hidden">contents 영역</h3> <!-- content -->
						<div class="content">
	
							<p class="Location">
								<a href="../notice/aNotice.do" class="btn_set home">메인으로</a> <span
									class="btn_nav bold">학습관리</span> <span class="btn_nav bold">설문조사 관리
									</span> <a href="../tut/t_surveyControl.do" class="btn_set refresh">새로고침</a>
							</p>
	
							<p class="conTitle">
								<span>설문조사 관리</span>
	                  		</p>
							
							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="30%">
										<col width="30%">
										<col width="20%">
										<col width="20%">
									</colgroup>
		
									<thead>
										<tr>
											<th scope="col">강의명</th>
											<th scope="col">강사</th>
											<th scope="col">강의 시작일</th>
											<th scope="col">강의 종료일</th>
										</tr>
									</thead>
	
	
									<tbody id="lecListbody">
									<c:choose>
											<c:when test="${totalCnt == null || totalCnt ==0 }">
												<tr>
													<td colspan="4">
														<div style="display: flex; margin: 20px 0px 20px 0px; justify-content: center; color: #8f8f8f;">해당되는 정보가 없습니다.</div>
													</td>
												</tr>
											</c:when>
											<c:otherwise>
													<c:forEach items="${list}" var="list">
														<tr>											
															<td id="lecName">
																<a href="javascript:fLecList('${list.lec_id}', '${list.lec_name}')">
																	${list.lec_name }
																</a>
															</td>
															<td id="tutorName">${list.tutor_name }</td>
															<td><fmt:formatDate value="${list.start_date }" pattern="yy-MM-dd" type="date" /></td>
															<td><fmt:formatDate value="${list.end_date }" pattern="yy-MM-dd"  type="date" /></td>
														</tr>
													</c:forEach>
												</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							
							<div class="paging">
							    <c:if test="${totalCnt ne null && totalCnt ne 0}">
							        <c:if test="${lpr.showPrev}">
							            <a class="page" href="<c:url value="${lpr.lsc.getQueryString(lpr.beginPage-1)}"/>">&lt;</a>
							        </c:if>
							        <c:forEach var="i" begin="${lpr.beginPage}" end="${lpr.endPage}">
							            <c:choose>
							                <c:when test="${lpr.lsc.page eq i}">
							                    <a class="page selpage" href="<c:url value="${lpr.lsc.getQueryString(i)}"/>">${i}</a>
							                </c:when>
							                <c:otherwise>
							                    <a class="page" href="<c:url value="${lpr.lsc.getQueryString(i)}"/>">${i}</a>
							                </c:otherwise>
							            </c:choose>
							        </c:forEach>
							        <c:if test="${lpr.showNext}">
							            <a class="page" href="<c:url value="${lpr.lsc.getQueryString(lpr.endPage+1)}"/>">&gt;</a>
							        </c:if>
							    </c:if>
							</div>
							
							
							<div id="detailSurvey">
								<p class="conTitle" style="margin-top: 100px;">
				                     <span>설문조사 상세</span> 
				                     <span id="lecture_name_hide" style="font-size: 27px; font-weight: bold;"> - 강의명</span>
				                     <span id="tutor_name_hide" style="font-size: 27px; font-weight: bold;"> - 강사명</span>
				                     <span class="fr"></span>
		                  		</p>
								
								
								<%-- 설문조사 상세 테이블 --%>
								<div class="detailSrvy divComGrpCodList">
									<table class="col">
										<caption>caption</caption>
										<colgroup>
										<col width="30%">
										<col width="30%">
										<col width="20%">
										<col width="20%">
										</colgroup>
			
										<thead>
											<tr>
												<th scope="col">강의명</th>
												<th scope="col">강사</th>
												<th scope="col">설문조사 참여 현황</th>
												<th scope="col">설문조사 결과</th>
	
											</tr>
										</thead>
										
										<tbody id="detailSurveyBody">
<%-- 											<c:choose> --%>
<%-- 													<c:when test="${detailTotalCnt == null || detailTotalCnt ==0 }"> --%>
<!-- 														<tr> -->
<!-- 															<td colspan="5"> -->
<!-- 																<div style="display: flex; margin: 20px 0px 20px 0px; justify-content: center; color: #8f8f8f;">해당되는 정보가 없습니다.</div> -->
<!-- 															</td> -->
<!-- 														</tr> -->
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<%-- 															<c:forEach items="${detailSrvyList}" var="detailList"> --%>
<!-- 																<tr>											 -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																</tr>										 -->
<%-- 															</c:forEach> --%>
<%-- 														</c:otherwise> --%>
<%-- 												</c:choose> --%>
										</tbody>
										
									</table>
								</div>
								<div class="paging_area"  id="srvyPagination"> </div>
					
							</div>
							
								<div id="resultSrvy" style="margin-top: 40px;">
									<!-- 이 안에도 같이 비워져서 오류가 남 -->
									<div>
										<canvas id="doughnut-chart"></canvas>
									</div>
								</div>
								<p class="conTitle" id="resultSrvyReview">
									<span style="font-size: 16px; margin-top: 20px">학습 시 불편했던 사항 또는 개선할 사항</span>
								</p>
								<div id="listReviewContainer" style="padding: 15px 0px 50px 50px;"></div>

							

							
				
						</div> <!--// content -->
	
						<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
	</form>
</body>
</html>