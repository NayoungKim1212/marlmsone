<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학습자료</title>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">

	// 페이징 설정
	var pageSize = 10;
	var pageBlock = 5;

	$(document).ready(function(e) {
		console.log("stdlearning");
		fRegisterButtonClickEvent();
		learnMatList();
	})
	
		function fRegisterButtonClickEvent() {

		$("#searchEnter").click(function(e) {
			// ?
			e.preventDefault();

			learnMatList();
		});
		
		// a 태그의 이름이 btn 인 경우
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			// 현재 입력된 객체의 id 를 가져옴
			var btnId = $(this).attr('id');

			// id 값으로 행동을 분기
			switch (btnId) {
			case 'btnClose':
				gfCloseModal();
				cancleBtn()
				break;
			}
		});
	}
	
	function learnMatList(currentPage) {
		
		currentPage = currentPage || 1;
		
		var param = {
				pageSize : pageSize,
				currentPage : currentPage,
				searchInfo : $("#searchInfo").val(),
				searchKey : $("#searchKey").val()
			}
		console.log("param : ", param);
		
		$.ajax({
			url : '/std/stdLearnMatList.do',
			type : "POST",
			data : param,
			async : true,
			dataType : "text",
			success : function(data) {
				console.log(data);
				getlearnMatList(data, currentPage);
			},
			error : function(error) {
				console.log(error)
			}
		})
	}
	
	function getlearnMatList(data, currentPage){
		console.log("data : " , data);
		
		$("#listStdMat").empty().append(data);
		console.log("listStdMat : ", data);
		
		var totCnt = $("#totalCount").val();
		console.log("totCnt : " , totCnt);
		
		var paginationHtml = getPaginationHtml(currentPage, totCnt, pageSize,
				pageBlock, 'learnMatList');

		console.log(currentPage);
		console.log(totCnt);
		console.log(pageSize);
		console.log(pageBlock);

		console.log("paginationHtml : " + paginationHtml);

		$("#pagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage);
	}
	
	// 학습자료 등록 모달 띄우기
	function fPopModalMat(){
		console.log("fPopModalMat");
		
		 gfModalPop("#layer1");
		//데이터 넣기 
	}
	
	function stdLectureDetail(data) {
		console.log("learnMaterialsDetail : ", data);
		
		$.ajax({
			url : '/std/stdLearnMatDetail.do',
			type : "POST",
			data : {
				learn_data_id : data,
				
			},
			async : true,
			dataType : "json",
			success : function(data) {
				console.log("모달 데이터 : ", data);			
				 gfModalPop("#layer1");
				 init(data.std_detail);

			},
			error : function(error) {
				console.log(error)
			}
		})	
		gfModalPop("#layer1");
	}
	
	function init(data) {
		console.log("init 데이터 확인 : ", data);
		
		$("#learn_tit").val(data.learn_tit)
		$("#w_date").val(data.w_date)
		$("#learn_con").val(data.learn_con)
		$("#learn_fname").text(data.learn_fname)
		$("#learn_data_id").text(data.learn_data_id);
		if(data.learn_fname != null) {
			$("#learn_fname").attr("href", "javascript:downloadStd('" + data.learn_url + "', '" + data.learn_fname + "', " + data.learn_data_id + ")");
			$("#learn_fname").text(data.learn_fname);
		}else {
			$("#learn_fname").text("첨부파일 없음");
		}
	}
	
	function downloadStd(url, fname, learn_data_id){
		 alert("다운로드 하시겠습니까?")
	     $("#learn_data_id").val(learn_data_id);
	    
		var params = "<input type='hidden' name='learn_data_id' value='"+ learn_data_id +"' />";
           params += "<input type='hidden' name='file_path' value='"+ url +"' />";
           params += "<input type='hidden' name='file_name' value='"+ fname +"' />";
           $("<form action='fileDownload.do' method='post' id='fileDownload'>" + params + "</form>").appendTo('body').submit().remove();
           console.log(params);
	}
	

</script>
</head>
<body>

<form id="myForm" action=""  method="">
	<input type="hidden" name="action" id="action" value="">
	<input type="hidden" id="currentPage" value="1">
	<input type="hidden"  id="learn_data_id"  name="learn_data_id"  value="" />

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
								<select id="searchKey" name="searchKey" style="width: 80px;">
										<option value="all" id="all" selected="selected">전체</option>
										<option value="title" id="title">제목</option>
										<option value="lec_name" id="lec_name">강의명</option>
								</select> <input type="text" id="searchInfo" name="searchInfo"
									class="form-control" placeholder="" style="height: 28px;">
									<!-- // searchbar --> <!-- button --> <a class="btnType blue"
									href="" name="searchEnter" id="searchEnter"><span>검색</span></a>						 
						</p>
						
						<div class="divMatList" id="divMatList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
								    <col width="15%">
								    <col width="20%">
									<col width="40%">
									<col width="25%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">NO</th>
									    <th scope="col">강의명</th>
										<th scope="col">제목</th>
										<th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody id="listStdMat"></tbody>
							</table>
						</div>
	
						<div class="paging_area"  id="pagination"> </div>
					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
         <dl>
            <dt>
               <strong>학습자료</strong>
            </dt>
            <dd class="content" >
                  <table class="row">
              <caption>caption</caption>
            <tbody>
            <tr> 
                <th scope="row">제목</th>
               <td>
               <input type ="text"  id="learn_tit"   name ="learn_tit" class="inputTxt p100" readonly>
               </td>
               <th scope="row">등록일자 </th>
               <td>
               <input type ="text" id="w_date" name ="w_date" class="inputTxt p100" readonly>
               
               </td>
            </tr>
            <tr>
               <th scope="row">내용</th>
               <td  id="con" colspan="6">
                  <textarea class="inputTxt p100" id="learn_con"  name ="learn_con" style="width:100%; border:0; resize:none;" readonly></textarea>
               </td>
            </tr>
            <tr>
               <th scope="row">첨부파일</th>
               <td colspan="6">
               <a href="#" id="learn_fname"  name="learn_fname" readonly></a><br/>                                      
               </td>
            </tr>
             </tbody> 
          </table>
       			<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
               </dd>
			</dl>

		<a href="javascript:cancleBtn();" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>	
	</div>
</form>
</body>
</html>