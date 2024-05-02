<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강 인원 통계</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>

 <script type="text/javascript">

	// 페이징 설정
	var pageSize = 15;
	var pageBlockSize = 5;
	
	/* OnLoad Event */
	$(document).ready(function(){
		// 강의 목록 조회
		sLectureList();
		
		// 버튼 이벤트 등록
		fRegisterButtonClickEvent();

		// 달력 설정
		$("#Datepicker").datepicker({});
		$("#to_date").change(function() {
			if ($("#to_date").val() <$("#from_date").val()){
				alert("최소기간 보다 작을수 없습니다.")
				$("#to_date").val('');
			} 
		});
		
	})
	
	/** 버튼 이벤트 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'btnClose':
				gfCloseModal();
				break;
			case 'btn_lec_reg':
				std_lec_reg();
				break;	
			}
		});
	}
	
	function dateSelect(docForm,selectIndex) {
		console.log("1");
		watch = new Date(docForm.year.options[docForm.year.selectedIndex].text, docForm.month.options[docForm.month.selectedIndex].value,1);
		console.log("2");
		hourDiffer = watch - 86400000;
		console.log("3");
		calendar = new Date(hourDiffer);
		console.log("4");
		var daysInMonth = calendar.getDate();
		console.log("5");
		
			for (var i = 0; i < docForm.day.length; i++) {
				docForm.day.options[0] = null;
			}
			for (var i = 0; i < daysInMonth; i++) {
				docForm.day.options[i] = new Option(i+1);
		}
		document.form1.day.options[0].selected = true;
	}
	
	/* 강의 목록 조회 */
	function sLectureList(currentPage){
		currentPage = currentPage || 1;
		searchWord = $("#searchWord").val();
		searchKey = $("#searchKey").val();
		from_date =$("#from_date").val();
		to_date =$("#to_date").val();
		
		if(from_date != '' && to_date == ''){
			alert("끝 날짜를 선택해주세요.");
			return;
		} else if(from_date == '' && to_date != ''){
			alert("시작 날짜를 선택해주세요.");
			return;
		}
		
		var param = {
				searchKey : searchKey,
				searchWord : searchWord,
				currentPage : currentPage,
				pageSize : pageSize,
				from_date : from_date,
				to_date : to_date
		}

		var resultCallback = function(data) {
			sLectureListResult(data, currentPage, param);
		};

		callAjax("/adm/selectCourse.do", "post", "text", true, param, resultCallback);
	}
	
	/* 강의 목록 조회 콜백 함수 */
	function sLectureListResult(data, currentPage, param){
		console.log("목록 data 확인", data);
		// 기존 목록 삭제
		$('#crsSizeList').empty();

		// 신규 목록 생성
		$('#crsSizeList').append(data);

		// 총 개수 추출
		var totalCnt = $("#totalCnt").val();
		
		// 페이지 네비게이션 생성
		var paginationHtml = getPaginationHtml(currentPage, totalCnt, pageSize, pageBlockSize, 'sLectureList');
		$("#Pagination").empty().append(paginationHtml);

		// 현재 페이지 설정
		$("#currentPage").val(currentPage);
		
		var key = param.searchWord;
		var startDate = param.from_date;
		var endDate = param.to_date;
		
		console.log("key : ", key);
		console.log("startDate : ", startDate);
		console.log("endDate : ", endDate);
		
	}
	
	/* 차트 관련 정보 조회 */
	function showChart(lec_id){
		
		$("#lec_id").val(lec_id);
		console.log("lec_id : ", lec_id);
		
		gfModalPop("#layer3");
		
		$.ajax({
			url : "/adm/showChart.do",
			type : "post",
			dataType : "json",
			async : true,
			data : {
				lec_id : lec_id
			},
			success : function(data) {
				lec_chart(data);
			},
			error : function(xhr, status, err) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("err : " + err);
	      			
			},
			complete: function(data) {
				$.unblockUI();
			}
		});
	}
	
	var myChart;
	
	/* 차트 보여주기 */
	function lec_chart(data){

		if (myChart) {
		    myChart.destroy();
		}
		
		
		console.log("차트 데이터 확인 : ", data);
		
		const courseData = data.courseSizeModel[0];
		const ctx = document.getElementById('myChart').getContext('2d');

		
		myChart = new Chart(ctx, {
		    type: 'bar',
		    data: {
		      labels: ['수강 정원', '수강 인원', '과락 인원'],
		      datasets: [{
		        label: courseData.lec_name,
		        data: [courseData.max_pnum, courseData.pre_pnum, courseData.fail_cnt],
		        borderWidth: 1
		      }]
		    },
		    options: {
		      scales: {
		        y: {
		          beginAtZero: true
		        }
		      }
		    }
		  });
		
	}
	
	

</script>
</head>
<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> 
		<input type="hidden" id="lec_id" value=""> 

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
								<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
								<a href="" class="btn_nav bold">통계</a> 
								<span class="btn_nav bold">수강 인원</span> 
								<a href="/adm/courseSize.do" class="btn_set refresh">새로고침</a>
							</p>

							<!--학생 목록  -->
							<p class="conTitle">
								<span>수강 인원</span> <span class="fr"> 
								<select id="searchKey" name="searchKey" style="width: 80px;">
										<option value="all" id="all" selected="selected">전체</option>
										<option value="lec_name" id="lec_name">강의명</option>
										<option value="tutor_name" id="tutor_name">강사명</option>
								</select>
								<input type="text" id="searchWord" name="searchWord" style="height: 28px;"> 
								
								<a class="btnType blue" href="javascript:sLectureList()" name="search">
									<span id="searchEnter">검색</span>
								</a>
								</span>
							</p>
							
							<span class="fr">
							<p class="Location">
								<Strong>수업일 조회 </Strong>
								<input type="date" id="from_date">~<input type="date" id="to_date">
								<a class="btnType blue" href="javascript:sLectureList()" name="search">
									<span id="searchEnter">조회</span>
								</a> 	
							</p>
							</span>
							
							<!--강의 리스트  -->
							<div class="" id="">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="10%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
										<col width="8%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">과정명</th>
											<th scope="col">기간</th>
											<th scope="col">강사명</th>
											<th scope="col">수강인원</th>
											<th scope="col">과락인원</th>
											<th scope="col">총점수</th>
											<th scope="col">평균</th>
											<th scope="col">최대 점수</th>
											<th scope="col">최소 점수</th>
										</tr>
									</thead>
									<tbody id="crsSizeList"></tbody>
								</table>
							</div>

							<div class="paging_area" id="Pagination"></div>
						</div> <!--// content -->

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
			
			<!-- 차트 모달 -->
			<div id="layer3" class="layerPop layerType2" style="width: 600px;">
			<dl>
				<dt>
					<strong>수강 인원</strong>
				</dt>
				<dd class="content">
					<!-- s : 여기에 내용입력 -->
					<table class="row">
						<caption>caption</caption>
						<colgroup>
							<col width="33%">
							<col width="33%">
							<col width="33%">
						</colgroup>
						<tbody>
							<canvas id="myChart"></canvas>
						</tbody>
					</table>

					<!-- e : 여기에 내용입력 -->

					<div class="btn_areaC mt30">
						<a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
					</div>
				</dd>
			</dl>
			<a href="" class="closePop"><span class="hidden">닫기</span></a>
		</div>
		</div>
		</form>
	
	</body>

</html>