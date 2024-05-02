<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>마이페이지 : 정보 수정</title>
<!-- 우편코드 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8" src="${CTX_PATH}/js/popFindZipCode.js"></script>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
<style type="text/css">
	div #necessary th{	text-align: center;	font-weight: bold; background-color: #d3d3d3; }
	div #necessary td {background-color: #FFFFFF;}
	div #necessary .btn {background-color: #d3d3d3;}
	div #necessary td input{	border: none; height: 35px; width:100%;}
	div #additionalPart th {	text-align: center;	font-weight: bold; background-color: #d3d3d3; }
	div #additionalPart td {	text-align: left; border:none;}
</style>
<script type="text/javascript">	

	/** OnLoad event */ 
	$(function() {
		fRegisterButtonClickEvent();
		// 학생일 경우에만 추가입력사항 확인
		if($("#userType").val()== "A"){
			$("#additionalPart").show();
		} else {
			$("#additionalPart").hide();
		}
		
	});
	
	// 필터링
	/*패스워드 정규식*/
	function formatPassword() {
		var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	 	var password = $("#newPsd").val();
		if(!passwordRules.test($("#newPsd").val())){
			swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
				$("#registerPwd").focus();
		  });
		}else {
			changePwd();
		}
	}
	
	/** 휴대폰 번호 필터링 */
    function formatPhoneNumber() {
        var searchWord_std = document.getElementById("tel");
        
        // 숫자로만 이루어진 문자열인지 확인
        var phoneNumber = searchWord_std.value.replace(/[^0-9]/g, "");

        // 처음 3자리가 허용된 번호인지 확인
        if (phoneNumber.length==3){
        var prefix = phoneNumber.substring(0, 3);
    	    if (["010", "019", "011", "016", "017"].indexOf(prefix) === -1) {
    	    	alert("정확한 전화번호를 입력해주세요.");
    	    	$("#tel").val("").focus();
    	        return;  // 허용되지 않은 번호이면 함수를 종료
    	    }
        }
        
        // 휴대폰 번호 형식에 맞게 하이픈 추가
        if (phoneNumber.length >= 3 && phoneNumber.length <= 7) {
          phoneNumber = phoneNumber.replace(/(\d{3})(\d{1,4})/, "$1-$2");
        } else if (phoneNumber.length >= 8) {
          phoneNumber = phoneNumber.replace(/(\d{3})(\d{3,4})(\d{0,4})/, "$1-$2-$3");
        }
        
        // 13자리까지만 입력받기 (한국기준)
        if (phoneNumber.length > 13) {
            phoneNumber = phoneNumber.substring(0, 13);
        }
        
        // 입력된 내용을 변경된 번호로 업데이트
        searchWord_std.value = phoneNumber;
    }
	
	/** 이메일 필터링 */
	function validateEmail() {
       var emailInput = $("#mail").val();
       var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

       if (!regex.test(emailInput)) {
    	   alert("올바른 형식의 이메일을 입력하세요.");
			$("#mail").val().focus();
       } 
    }
	
	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		// input 이름이 btn 인 경우
		$('input[name=btn]').click(function(e) {
			e.preventDefault();
			
			// 현재 입력된 객체의 id 를 가져옴
			var btnId = $(this).attr('id');
          
			// id 값으로 행동을 분기
			switch (btnId) {
				case 'savebtn' :
					Save();
					break;
				case 'changePwd' :
					Pwd();
					break;
				case 'changeZipcode' :
					addr();
					break;
				case 'btnClose' :
					gfCloseModal();
					break;
			}
		});
			
		
	}
		
	/** 필수 정보 입력 validation */
	function fValidate() {
		var chk = checkNotEmpty(
				[
						[ "pwdCheck", "사용중인 비밀번호를 입력해주세요" ]
					,	[ "tel", "연락처를 입력하세요" ]
				]
		);

		if (!chk) {
			return;
		}
		return true;
	}
	
	// 정보 validation 확인 및 저장하는 함수
	function Save(){
		// flase 값이 들어오면 -> return
		if(!fValidate()){
			return;
		}
		
		// 이메일 확인
		validateEmail();

		// 입력한 비밀번호와 일치하는지 확인
		myPwdCheck()
		upload();
	}
	
	
	
	// 파일 업로드
	function upload(){
		
		// 파일처리 시작
		var frm = document.getElementById("myForm");
		frm.enctype = 'multipart/form-data';
		var fileData = new FormData(frm);
		
		var callback = function(response){
			alert(response.resultmsg);
			
			if(response.result==="S"){
				// 새로고침하기
				location.href = location.href;
			}
		}
		
		callAjaxFileUploadSetFormData("/personal/personalSave.do", "post", "json", false, fileData, callback);
		
	}
	
	// 파일 다운로드
	function download(){
		$("<form action='personalDownload.do' method='post' id='fileDownload'></form>"
		).appendTo('body').submit().remove();
	}
	
	// 비밀번호 변경창 띄우는 메소드
	function Pwd(){
		gfModalPop("#layer1");
	}
	
	// 비밀번호 변경창 체크 및 저장
	function changePwd(){
		
		var newPsd = $("#newPsd").val();
		var newPsdCheck = $("#newPsdCheck").val();
		var originPwd = $("#originPwd").val();
		
		// 값을 입력하지 않았을 때 check
		if(newPsd===null || isEmpty(newPsd))
			return $("#newPsd").focus();
		
		if(newPsd===null || isEmpty(newPsd))
			return $("#originPwd").focus();
		
		if(newPsd===null || isEmpty(newPsd))
			return $("#originPwd").focus();
		
		// 값 validation
		if(newPsd !== newPsdCheck){
			alert("새로운 비밀번호가 일치하지 않습니다.");
			$("#newPsdCheck").focus();
			return;
		}
		
		// AJAX 로 변경
		var param = {
				newPsd : $("#newPsd").val(),        
				originPwd : $("#originPwd").val(),
		}
		
		var callback = function(response){
			var message = response.resultmsg;
			
			if(message==="FAIL1"){
				alert("비밀번호 변경에 실패하였습니다.\n지속적인 문제 발생 시 관리자에게 문의바랍니다.");
				return gfCloseModal();
			} else if(message==="FAIL2") {
				alert("이전에 비밀번호와 동일하게 설정할 수 없습니다.");
				return $("#newPsd").focus();
			} else if(message==="FAIL3") {
				alert("비밀번호가 일치하지 않습니다.");
				return $("#originPwd").focus();
			}
			alert("비밀번호가 변경되었습니다.");
			return gfCloseModal();
		}
		
		callAjax("/personal/personalPwdChange.do", "post", "json", false, param, callback);
		
	}
	
	function Quit(){
		
		var data = $("#pwdCheck").val();
		if(data===null || data===""){
			alert("비밀번호를 입력해주세요!");
			return $("#pwdCheck").focus();
		}
		
		myPwdCheck().then(function(isMatch) {
	        if(!isMatch){
	            alert("비밀번호가 일치하지 않습니다.");
	            $("#pwdCheck").focus();
	            return;
	        }

	        if(confirm("정말 탈퇴하시겠습니까?\n되돌릴 수 없습니다.")){
	            var callback = function(response){
	                if(response.resultmsg==="SUCCESS"){
	                    alert("성공적으로 탈퇴하였습니다.");
	                    gfCloseModal();
	                    fLogOut();
	                } else {
	                    alert("탈퇴 실패하였습니다.\n문제가 계속 발생되면 관리자에게 문의바랍니다.");
	                }
	            }

	            callAjax("/personal/personalQuit.do", "post", "json", false, "", callback);	
	        }
	    });
		
	}
	
	function addr (){
		popFindZipCode();
	}
	
	function myPwdCheck(){
	    return new Promise(function(resolve, reject) {
	        var param = {
	            password : $("#pwdCheck").val()
	        }

	        var callback = function(response){
	            if(response.resultmsg==="SUCCESS"){
	                console.log("비번 일치 조회 성공");
	                resolve(true);
	            } else {
	                resolve(false);
	            }
	        }
	        callAjax("/personal/checkPwd.do", "post", "json", false, param, callback);	
	    });
	}
	
</script>

</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="userType" name="userType" value="${sessionScope.userType}" />
	
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
								class="btn_nav bold">MY PAGE</span> <span class="btn_nav bold"> 정보 수정
								</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
		                     <span>필수 입력사항 </span>
                  		</p>
							
							
						<%-- 필수입력사항 table --%>
						<div class="divComGrpCodList" id="necessary">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="30%">
									<col width="10%">
									<col width="10%">
									<col width="30%">
									<col width="10%">
								</colgroup>
								<tbody>
									<tr>
										<th scope="col">아이디</th>
										<td scope="col" colspan="2">
											<input type="text" id="loginId" name="loginId" value="${userInfo.loginId}" 
											class="form-control" readonly="readonly" class="readonly"/>
										</td>
										<th scope="col">이름</th>
										<td scope="col" colspan="2">
											<input type="text" id="name" name="name" value="${userInfo.name}" 
											class="form-control" readonly="readonly" class="readonly"/>
										</td>
										
									</tr>
									<tr>
										<th scope="col">비밀번호 확인<span class="font_red"> *</span></th>
										<td scope="col">
											<input type="password" id="pwdCheck" name="pwdCheck" value="" 
											class="form-control"/>
										</td>
										<td scope="col" class="btn">
											<input type="button" id="changePwd" name="btn" class="form-control btn" 
											value="비밀번호 변경"/>
										</td>
										<th scope="col">우편번호</th>
										<td scope="col">
											<input type="text" id="zipcode" name="zipcode"  value="${userInfo.zipcode}"
											class="form-control"
											readonly="readonly" class="readonly"/>
										</td>
										<td scope="col" class="btn">
											<input type="button" id="changeZipcode" class="form-control btn" 
											name="btn" value="우편번호 찾기"/>
										</td>
									</tr>
									<tr>
										<th scope="col" >이메일</th>
										<td scope="col" colspan="2">
											<input type="text" id="mail" name="mail" value="${userInfo.mail}" 
											class="form-control" />
										</td>
										<th scope="col">주소</th>
										<td scope="col" colspan="2">
											<input type="text" id="addr" name="addr" value="${userInfo.addr}" 
											class="form-control" readonly="readonly" class="readonly"/>
										</td>
									</tr>
									<tr>
										<th scope="col">연락처<span class="font_red"> *</span></th>
										<td scope="col" colspan="2">
											<input type="text" id="tel" name="tel" value="${userInfo.tel}" 
											class="form-control" oninput="javascript:formatPhoneNumber()"
											placeholder="숫자만 입력"/>
										</td>
										<th scope="col">상세주소</th>
										<td scope="col" colspan="2">
											<input type="text" id="addr_dtl" name="addr_dtl" value="${userInfo.addr_dtl}" 
											class="form-control" placeholder="동, 층, 호수를 입력해주세요"/>
										</td>
									</tr>
									<tr>

									</tr>
								</tbody>
								
							</table>
						</div>
						
						<div id="additionalPart">
							<p class="conTitle" style="margin-top: 50px;">
			                     <span>추가 입력사항 </span>
	                  		</p>
								
								
							<%-- 추가입력사항 table --%>
							<div class="divComGrpCodList" id="additional">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="90%">
									</colgroup>
		
									<tr>
										<th scope="col">이력서(다운로드)</th>
										<td scope="col">
											<input type="file" id="resume" name="resume" value="${userInfo.resume_fname}"/>
											<a href="javascript:download()">${userInfo.resume_fname}</a>
										</td>
									</tr>
								</table>
							</div>
						
						</div>
						
						<%-- 저장 버튼 --%>
						<div style="text-align: center; margin-top: 50px;">
							<a class="btnType blue" href="javascript:Save();" id="savebtn" name="btn"><span>저장</span></a>
							<a class="btnType grey" href="javascript:Quit();"><span>탈퇴하기</span></a>
						</div>
			
					</div> <!--// content -->


					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 모달팝업 // 비밀번호 변경  -->
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>비밀번호 변경</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="150px">
						<col width="*">
						<col width="150px">
						<col width="*">
					</colgroup>

					<tbody>
						<tr>
							<th colspan="4" style="text-align: center; background-color:#f9f9f9; color: red; height:80px ; font-size: 10pt;">
								<p>
									*이전에 사용한 적 없는 비밀번호가 안전합니다.<br>
									새로운 비밀번호로 변경해주세요.
								</p>
							</th>
						</tr>
						<tr>
							<th>새로운 비밀번호<span class="font_red"> *</span></th>
							<td colspan="3">
								<input type="password" id="newPsd"  name="newPsd"
								style="border: none; height: 35px; width:100%;"/>
							</td>
						</tr>
						<tr>
							<th>새로운 비밀번호 확인<span class="font_red"> *</span></th>
							<td colspan="3">
								<input type="password" id="newPsdCheck"  name="newPsdCheck"
								style="border: none; height: 35px; width:100%;"/>
							</td>
						</tr>
						<tr>
							<th>현재 비밀번호 확인<span class="font_red"> *</span></th>
							<td colspan="3">
								<input type="password" id="originPwd"  name="originPwd"
								style="border: none; height: 35px; width:100%;"/>
							</td>
						</tr>
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href="javascript:formatPassword();" class="btnType blue" id="btnChangeSave" name="btn"><span>저장</span></a> 
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