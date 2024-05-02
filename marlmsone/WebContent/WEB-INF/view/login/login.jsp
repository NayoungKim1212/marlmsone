<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>HappyJob LMS :: Login</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>

<link rel="stylesheet" type="text/css"
	href="${CTX_PATH}/css/admin/login.css" />

<!-- 우편번호 조회 -->

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
	src="${CTX_PATH}/js/popFindZipCode.js"></script>
	<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>

<script type="text/javascript" src="${CTX_PATH}/js/login_pub.js"></script>
<script type="text/javascript">

var check;

/* OnLoad Event */
$(document).ready(function() {
	$("#confirm").hide();
	$("#loginRegister").hide();
	$("#loginEmail").hide();
	$("#loginPwd").hide();

	var cookie_user_id = getCookie('EMP_ID');
	if (cookie_user_id != "") {
		$("#EMP_ID").val(cookie_user_id);
		$("#cb_saveId").attr("checked", true);
	}

	$("#EMP_ID").focus();
	
	init();
	
});


function fcancleModal(){
	gfCloseModal();
}

/* 회원가입 모달창 실행 */
function fRegister() {
	var div_cd;
	$("#action").val("I");
	// 모달 팝업
	gfModalPop("#layer1");
	instaffRegister();
}


function init() {
	check = new Vue({
		el: '#layer1',
		data : {
			langitems: [],
			langitems1: [],
			langitems2: [],
			langitems3: [],	
			langitemss: [],
			langitemarea1: [],
			langitemarea2: [],
			langitemarea3: [],
			listlistCod: '',
			weblistCod:'',
			dblistCod:'',
			wslistCod:'',
			sklcdlistCod:'',
			areacdlistCod:'',
			skillgrpcd:'',
			skilldtlcd:''
			
		}
	})
 }

 /*체크리스트 콜백함수*/
 function checklistResult(data){ 	
	
	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
 	$.ajax({
		url : '/checklist.do',
		type : 'post',
		data : data,
		dataType : 'json',
		async : true,
		success : function(data) {
			check.check = [];
			check.langitems = data.listlistCod;
			check.langitems1 = data.weblistCod;
			check.langitems2 = data.dblistCod;
			check.langitems3 = data.wslistCod;
			check.langitemss = data.sklcdlistCod;
			check.langitemarea1 = data.areacdlistCod;
			check.langitemarea2 = data.areacdlistCod;
			check.langitemarea3 = data.areacdlistCod;
			}
		});
}

$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
})

var chk_arr = [];
$("input[v-model=chkbox]:checked").each(function(){
	var chk = $(this).val();
	chk_arr.push(chk);
})

/*일반 회원가입 폼 초기화*/
function instaffRegister(){
	$("#user_type").val("A");
	commonRegister();
	
	$("#register_instaff").addClass("blue");
	$("#register_outstaff").removeClass("blue");
	
	//체크리스트출력
	checklistResult(); 
}

/*강사 회원가입 폼 초기화*/
function outstaffRegister(){

	$("#user_type").val("E");
	
	commonRegister();
	
	$("#register_outstaff").addClass("blue");
	$("#register_instaff").removeClass("blue");
}

 /* 공통 초기화 */
 function commonRegister(){
	$("#registerId").val("");		// 아이디
	$("#registerPwd").val("");		// 비밀번호
	$("#registerPwdOk").val("");	// 비밀번호 확인
	$("#registerName").val("");	// 비밀번호 확인
 	$("#gender").val("");			// 성별
	$("#registerEmail").val("");	// 이메일
	$("#detailaddr").val("");		// 우편코드
	$("#loginaddr").val("");		// 주소
	$("#loginaddr1").val("");		// 상세주소
	$("#tel").val("");				// 전화번호
	$("#ckIdcheckreg").val("0");	// 중복ID check 값 		- 0:존재 / 1:미존재
	$("#ckEmailcheckreg").val("0");	// 중복Email check 값	- 0:존재 / 1:미존재
	$("#birthday1").val("");		// 주민번호 앞자리
	$("#birthday2").val("");		// 주민번호 뒷자리
 }



/* 아이디/비밀번호 찾기 모달창 실행 */
function findIdPwd() {

	// 모달 팝업 - 아래 창 없이
	gfModalPop("#layer2");
	$("#findForm").hide();
	$("#findId").addClass("grey").removeClass("blue");
	$("#findPwd").addClass("grey").removeClass("blue");
}


/* 회원가입 정보 입력유무 validation */
function RegisterVal(){
	  
	var rgid = $('#registerId').val();
	var rgpwd = $('#registerPwd').val();
	var rgpwdok = $('#registerPwdOk').val();
	var rgname = $('#registerName').val();
	var rgemail = $('#registerEmail').val();
	var dtadr = $('#detailaddr').val();
	var lgadr = $('#loginaddr').val();
	var tel = $('#tel').val();
	var gender_cd = $('#gender_cd').val();
	
	if(rgid.length < 1){
		swal("아이디를 입력하세요.").then(function() {
			$('#registerId').focus();
		  });
		return false;
	}
	
	if(rgpwd.length < 1){
		swal("비밀번호를 입력하세요.").then(function() {
			$('#registerPwd').focus();
		  });
		return false;
	}
	
	if(rgpwdok.length < 1){
		swal("비밀번호 확인을 입력하세요.").then(function() {
			$('#registerPwdOk').focus();
		  });
		return false;
	}
	
	if(rgpwd != rgpwdok){
		swal("비밀번호가 맞지 않습니다.").then(function() {
			$('#registerPwd').focus();
		  });
		return false;
	}
	
	if(rgname.length < 1){
		swal("이름을 입력하세요.").then(function() {
			$('#registerName').focus();
		  });
		return false;
	}
	
	if(rgemail.length < 1){
		swal("이메일을 입력하세요.").then(function() {
			$('#registerEmail').focus();
		  });
		return false;
	}
	
	if(dtadr.length < 1){
		swal("우편번호를 입력하세요.").then(function() {
			$('#detailaddr').focus();
		  });
		return false;
	}
	
	if(lgadr.length < 1){
		swal("주소를 입력하세요.").then(function() {
			$('#loginaddr').focus();
		  });
		return false;
	}
	
	if(tel.length < 1){
		swal("전화번호를 입력하세요.").then(function() {
			$('#tel').focus();
		  });
		return false;
	}
	
	if(gender_cd === null || gender_cd === ""){
		swal("성별을 선택해주세요.").then(function(){
			$('#gender_cd').focus();
		});
		return false;
	}
	return true;
	
}
/*loginID 중복체크*/
function loginIdCheck(){
	
	var data = {"loginID" : $("#registerId").val()};
	
	var idRules =  /^[a-z0-9]{6,20}$/g ;
	var id = $("#registerId").val();

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : true,
		success : function(data) {
			if($("#registerId").val()==""){
				console.log("입력 아이디 없음");
				swal("아이디를 입력해주세요.").then(function(){
					$("#registerId").focus();
				});
				$("#ckIdcheckreg").val("0");
			}
			 else if (data==1){
				console.log("아이디 있음");
				swal("중복된 아이디가 존재합니다.").then(function(){
					$("#registerId").focus();
				});
				console.log(data);
				$("#ckIdcheckreg").val("0");
			} else if(!idRules.test($("#registerId").val())){
				swal('아이디는 숫자,영문자 조합으로 6~20자리를 사용해야 합니다.').then(function(){
					$("#registerId").focus();
				});
				$("#ckIdcheckreg").val("0");
				return false;
			} else if(data == 0){
				console.log("아이디 없음");
				swal("사용할 수 있는 아이디 입니다.");
				$("#ckIdcheckreg").val("1");
			}
		}
	});
}

/*회원가입 버튼 아이디 중복 체크*/
function loginIdCheckComplete(){
	
	var data = {"loginID" : $("#registerId").val()}
	
	var idRules =  /^[a-z0-9]{6,20}$/g ;
	var id = $("#registerId").val();

	/*callAjax시 로그인 여부 확인 하므로 ajax 함수 직접 작성*/
	$.ajax({
		url : '/check_loginID.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : false,
		success : function(data) {
			if (data == 1){
				$("#ckIdcheckreg").val("0");
				console.log("아이디 있음");
				return false;
			} else if(!idRules.test($("#registerId").val())){
				$("#ckIdcheckreg").val("1");
				return false;
			}
		}
	});
}


/*-------  이메일 입력방식 선택  ------*/

/*이메일 중복 체크*/

function emailCheck(){
	var data = {"user_email" : $("#registerEmail").val()};

	$.ajax({
		url : '/check_email.do',
		type : 'post',
		data : data,
		dataType : 'text',
		async : false,
		success : function(data) {
			console.log("emailcheck data 값 : ", data);
			if(data > 0){
				$("#ckEmailcheckreg").val(0);
			} else {
				$("#ckEmailcheckreg").val(1);
			}
		}
	});
}

/* 회원가입  완료*/
function CompleteRegister() {
	
	var param = $("#RegisterForm").serialize();
	/*패스워드 정규식*/
	var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
 	var password = $("#registerPwd").val();
 	/*이메일 정규식*/
	var emailRules = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	var email = $("#registerEmail").val();
	
	/* validation 체크 */
	if(!RegisterVal()){
		return;
	}
	
	console.log("vaildation 체크까지 완료");
		
	loginIdCheckComplete();	// 아이디 중복 체크 
	emailCheck(); // 이메일 중복 체크 -- 기능 제대로 안돌아감
	console.log("이메일 중복 체크까지 완료");

	if(!regnumCheck()){
		return $("#birthday2").focus();
	}; // 주민등록번호 체크
	console.log("주민등록번호 체크까지 완료");
	
	
	if (RegisterForm.ckIdcheckreg.value === "0"){
		swal("아이디 중복확인을 진행해주세요.").then(function() {
			$("#registerId").focus();
			console.log("아이디 중복 확인 진행");
		  });
	} else if(!passwordRules.test($("#registerPwd").val())){
		swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
			$("#registerPwd").focus();
			console.log("비번 확인 진행");
		  });
	} else if(!emailRules.test($("#registerEmail").val())){
		swal("이메일 형식을 확인해주세요.").then(function() {
			$("#registerEmail").focus();
			console.log("이메일 형식 확인 진행");
		  });
	} else if($("#ckEmailcheckreg").val() ==="0"){
		swal("중복된 이메일이 존재합니다. 다시 입력해주세요.").then(function() {
			$("#registerEmail").focus();
			console.log("중복 이메일 확인 진행");
		  });
	} else{
		console.log("resultCallback 시작합니다.");
		
		// 모든 결과를 통과하면
		var resultCallback = function(data) {
			fSaveRegister(data); // 회원가입 성공
		}
	
		callAjax("/register.do", "post", "json", true, param, resultCallback);
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

// 주민번호 유효성
function regnumCheck(){
	var genderCd = $("#gender_cd").val();
	var birthday1 = $("#birthday1").val();
	var birthday2 = $("#birthday2").val();

	var genderNumber = birthday2.charAt(0); 
	if ((genderNumber === "1" || genderNumber === "3") && genderCd !== "M") {
	    alert("성별이 일치하지 않습니다.");
	    return false;
	} else if ((genderNumber === "2" || genderNumber === "4") && genderCd !== "F") {
	    alert("성별이 일치하지 않습니다.");
	    return false;
	}
	
	var prefix = parseInt(birthday1.substring(0, 2), 10);
	var year = (prefix < 22 ? 2000 : 1900) + prefix;  // 22 이전은 2000년대, 그렇지 않으면 1900년대
	var month = parseInt(birthday1.substring(2, 4), 10) - 1;  // JavaScript의 월은 0부터 시작합니다.
	var day = parseInt(birthday1.substring(4, 6), 10);

	var date = new Date(year, month, day);
	if (date.getFullYear() !== year || date.getMonth() !== month || date.getDate() !== day) {
	    alert("생년월일이 유효하지 않습니다.");
	    return false;
	}

	// 두 번째 부분 (일련번호) 검사
	return true;
}

/* 회원 가입 저장 콜백함수 */
function fSaveRegister(data) {

	if (data.result == "SUCCESS") {
		alert(data.resultMsg);
		gfCloseModal();
	} else {
		alert(data.resultMsg);
		return false;
	}
}


// 우편번호 api
function execDaumPostcode(q) {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수

			//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			}

			// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
			if (data.userSelectedType === 'R') {
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraAddr += (extraAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById('detailaddr').value = data.zonecode;
			document.getElementById("loginaddr").value = addr;
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("loginaddr1").focus();
		}
	}).open({
		q : q
	});
}

//////////////////////////////////// 로그인 ////////////////////////////////////////////

/* 로그인 validation */
function fValidateLogin() {

	var chk = checkNotEmpty([ [ "EMP_ID", "아이디를 입력해 주세요." ],
			[ "EMP_PWD", "비밀번호를 입력해 주세요." ] ]);

	if (!chk) {
		return;
	}

	return true;
}

/* 로그인 */
function fLoginProc() {
	if ($("#cb_saveId").is(":checked")) { // 저장 체크시
		saveCookie('EMP_ID', $("#EMP_ID").val(), 7);
	} else { // 체크 해제시는 공백
		saveCookie('EMP_ID', "", 7);
	}

	// vaildation 체크
	if (!fValidateLogin()) {
		return;
	}

	var resultCallback = function(data) {
		//alert("login : " + JSON.stringify(data));
		fLoginProcResult(data);
	};

	callAjax("/loginProc.do", "post", "json", true, $("#myForm")
			.serialize(), resultCallback);
}

/* 로그인 결과 */
function fLoginProcResult(data) {

	console.log("login : " + JSON.stringify(data));
	
	var lhost = data.serverName;

	if (data.result == "SUCCESS") {
		location.href = "${CTX_PATH}/dashboard/dashboard.do";
	} else {

		$("<div style='text-align:center;'>" + data.resultMsg + "</div>")
				.dialog({
					modal : true,
					resizable : false,
					buttons : [ {
						text : "확인",
						click : function() {
							$(this).dialog("close");
							$("#EMP_ID").val("");
							$("#EMP_PWD").val("");
							$("#EMP_ID").focus();
						}
					} ]
				});
		$(".ui-dialog-titlebar").hide();
	}
}

//////////////////////////////////// 아이디비번 찾기 ////////////////////////////////////////////



/* 아이디 찾기 버튼 클릭 이벤트 */
function fSelectId() {
	$("#findForm").show();
	$("#beforeFindIdForm").show();
	$("#afterFindIdForm").empty().hide();
	$("#findPwdForm").hide();
	// 선택 버튼
	$("#findId").addClass("blue").removeClass("grey");
	$("#findPwd").addClass("grey").removeClass("blue");
	// 초기화
	$("#regiName").val("");
	$("#emailName").val("");
	$("#ckIdcheck").val("");
}

/* 비밀번호 찾기 버튼 클릭 이벤트 */
function fSelectPwd() {
	$("#findForm").show();
	$("#beforeFindIdForm").hide();
	$("#afterFindIdForm").empty().hide();
	$("#findPwdForm").show();
	// 추가
	$("beforeChangeForm").show();
	$("#afterChangeForm").hide();
	
	// 선택 버튼
	$("#findPwd").addClass("blue").removeClass("grey");
	$("#findId").addClass("grey").removeClass("blue");
	// 초기화
	$("#regiId").val("");
	$("#emailPwd").val("");
	$("#ckIdcheck").val("");
}

/** 아이디 찾기 */
function fMyId(){
	var name = $("#regiName").val();
	var mail = $("#emailName").val();
	// 유효성
	if(name===null || name ===""){
		alert("이름을 입력하세요.");
		$("#regiName").focus();
		return;
	}

	if(mail===null || mail ===""){
		alert("이메일을 입력하세요.");
		$("#emailName").focus();
		return;
	}
	
	// 이메일 유효성 check
	var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if (!regex.test(mail)) {
	 	alert("올바른 형식의 이메일을 입력하세요.");
		$("#emailName").val().focus();
	} 

	// AJAX 로 변경
	var param = {
			name : name,
			mail : mail
	}
	
	$.ajax({
		url : "/selectFindInfoId.do",
		type : "post",
		dataType : "json",
		async : false,
		data : param,
		beforeSend: function(xhr) {
			xhr.setRequestHeader("AJAX", "true");
			$.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
		},
		success : function(response){
					console.log(response.resultMsg);
					if(response.result=="SUCCESS"){
						$("#beforeFindIdForm").hide();
						var result = "<tr><th> 찾으시는 ID 는 : " + response.id + " 입니다. </th></tr>";
						$("#afterFindIdForm").append(result).show();
					} else {
						alert("일치하는 정보가 존재하지 않습니다.");
						$("#regiName").focus();
					}
		},
		complete: function(data) {
			$.unblockUI();
		}
	});
	
}

/** 비밀번호 찾기 */
function fMyPw(){
	var id = $("#regiId").val();
	var mail = $("#emailPwd").val();
	// 유효성
	if(id===null || id ===""){
		alert("아이디를 입력하세요.");
		$("#regiId").focus();
		return;
	}

	if(mail===null || mail ===""){
		alert("이메일을 입력하세요.");
		$("#emailPwd").focus();
		return;
	}
	
	// 이메일 유효성 check
	var regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	if (!regex.test(mail)) {
	 	alert("올바른 형식의 이메일을 입력하세요.");
		$("#emailPwd").val().focus();
	} 

	// AJAX 로 변경
	var param = {
			id : id,
			mail : mail
	}
	
	$("#ckIdcheck").val(id);
	
	$.ajax({
		url : "/selectFindInfoPw.do",
		type : "post",
		dataType : "json",
		async : false,
		data : param,
		beforeSend: function(xhr) {
			xhr.setRequestHeader("AJAX", "true");
			$.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
		},
		success : function(response){
					console.log(response.resultMsg);
					if(response.result=="SUCCESS"){
						$("#beforeChangeForm").empty().hide();
						$("#afterChangeForm").show();
					} else {
						alert("일치하는 정보가 존재하지 않습니다.");
						$("#regiId").focus();
					}
		},
		complete: function(data) {
			$.unblockUI();
		}
	});
	
}

/** 비밀번호 변경 시켜주기 */
function changeMyPw(){
	var id = $("#ckIdcheck").val();
	var pw = $("#reRegiPwd").val();

	// 유효성
	if($("#reRegiPwdCheck").val()!==pw){
		alert("비밀번호가 일치하지 않습니다.");
		$("#reRegiPwdCheck").focus();
		return;
	}

	/*패스워드 정규식*/
	var passwordRules = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
	if(!passwordRules.test(pw)){
		swal('비밀 번호는 숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.').then(function() {
			$("#reRegiPwd").focus();
		  });
		return;
	}
	
	// AJAX 로 변경
	var param = {
			id : id,
			pw : pw
	}
	
	$.ajax({
		url : "/updateFindPw.do",
		type : "post",
		dataType : "json",
		async : false,
		data : param,
		beforeSend: function(xhr) {
			xhr.setRequestHeader("AJAX", "true");
			$.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
		},
		success : function(response){
					console.log(response.resultMsg);
					if(response.result=="SUCCESS"){
						alert("비밀번호가 변경되었습니다.\n변경된 비밀번호로 로그인해주세요.");
						$("#ckIdcheck").val("");
						gfCloseModal();
					} else {
						alert("비밀번호 변경이 실패하였습니다.\n지속적으로 오류가 발생한다면 관리자에게 문의해주세요.");
						fSelectPwd();
					}
		},
		complete: function(data) {
			$.unblockUI();
		}
	});
	
}

</script>
</head>
<body>
	<form id="myForm" action="" method="post">
	<div id="background_board" >
		<div class="login_form shadow" align="center">
		<div class="login-form-right-side">
                <div class="top-logo-wrap">
                <img src="${CTX_PATH}/images/admin/login/logo_img.png">
                </div>
                <h3>안되는 것이 실패가 아니라 포기하는 것이 실패다</h3>
                <p>
                		미래는 그 누구도 알 수 없습니다.<br> 
                		어제를 돌아보면 비로소 내일이 보입니다.<br> 
                		지금껏 내가 이룬 것들이 내일과 이어진다는 믿음을 갖고<br> 
                		전진해야 합니다.<br>
               </p>
               <p>- 사과 장수, 스티브 잡스</p>
            </div>
		<div class= "login-form-left-side">
			<fieldset>
				<legend>로그인</legend>
				<p class="id">
					<label for="user_id">아이디</label> <input type="text" id="EMP_ID"
						name="lgn_Id" placeholder="아이디"
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}"
						style="ime-mode: inactive;" />
				</p>
				<p class="pw">
					<label for="user_pwd">비밀번호</label> <input type="password"
						id="EMP_PWD" name="pwd" placeholder="비밀번호"
						onfocus="this.placeholder=''; return true"
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}" />
				</p>
				<p class="member_info" style="font-size: 15px">
					<input type="checkbox" id="cb_saveId" name=""
						onkeypress="if(event.keyCode==13) {fLoginProc(); return false;}">
					<span class="id_save">ID저장</span> <br>
				</p>
				<a class="btn_login" href="javascript:fLoginProc();" id="btn_login"><strong>Login</strong></a>
				<br>
				<a href="javascript:fRegister();" id="RegisterBtn"
					name="modal"><strong>[회원가입]</strong></a> 
					<a href="javascript:findIdPwd();"><strong>[아이디/비밀번호 찾기]</strong></a>
			</fieldset>
			</div>
			
		</div>
	</div>
</form>
<!-- 모달팝업 -->


	<div id="layer1" class="layerPosition layerPop layerType2" style="width: 500px;">
      <form id="RegisterForm" action="" method="post">
	      <input type="hidden" name="action" id="action" value="">
	      <input type="hidden" name="ckIdcheckreg" id="ckIdcheckreg" value="0"/>
	      <input type="hidden" name="ckEmailcheckreg" id="ckEmailcheckreg" value="0"/>	
		<dl>
			<dt>
					<br>
					<br>
					<strong style="font-size:150%; padding-left: 5%;">회원가입</strong>
					<br>
			</dt>
			<dd class="content">
				<div class="btn_area">
					<br>
					<a href="javascript:instaffRegister();" class="btnType blue" id="register_instaff"><span>일반회원</span></a>
					<a href="javascript:outstaffRegister();" class="btnType " id="register_outstaff"><span>강사회원</span></a>
					<br>
				</div>
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="100px">
						<col width="*">
					</colgroup>
						<tbody>
							<tr class="hidden">
						 		<td><input type="text" name="user_type" id="user_type" /></td> 
							</tr>

							<tr>
								<th scope="row">아이디<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100"
									name="loginID" placeholder="숫자, 영문자 조합으로 6~20자리 "
									id="registerId" /></td>
								<td><input type="button" value="중복확인"
									onclick="loginIdCheck()" style="width: 130px; height: 28px;" /></td>
							</tr>
							<tr>
								<th scope="row">비밀번호 <span class="font_red">*</span></th>
								<td colspan="3">
									<input type="password"
									placeholder="숫자, 영문자, 특수문자 조합으로 8~15자리 " class="inputTxt p100"
									name="password" id="registerPwd" />
								</td>
							</tr>

							<tr>
								<th scope="row" style="padding: 0 0">비밀번호 확인<span
									class="font_red">*</span></th>
								<td colspan="3">
									<input type="password"
									class="inputTxt p100" name="password1" id="registerPwdOk" />
								</td>
							</tr>
							
							<tr>
								<th scope="row" id="registerName_th">이름 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="name"
									id="registerName" /></td>
							
								<th scope="row" id="rggender_th">성별 <span class="font_red">*</span></th>
								<td id="rggender_td">
								<select name="gender_cd" id="gender_cd" style="width: 128px; height: 28px;">
										<option value="" selected="selected">선택</option>
										<option value="M">남자</option>
										<option value="F">여자</option>
								</select></td>
							</tr>
							<tr>
								<th scope="row">주민등록번호<span class="font_red"> *</span></th>
								<td colspan="3">
									<input type="text" class="inputTxt p48"
										name="birthday1" id="birthday1" style="font-size: 15px" 
										maxlength="6"/> - 
									<input type="password" class="inputTxt p48"
										name="birthday2" id="birthday2" style="font-size: 15px" 
										maxlength="7"/>
								</td>
							</tr>
							<tr>
								<th scope="row">전화번호<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" id="tel" name="tel" placeholder="숫자만 입력"
									class="inputTxt p100" oninput="javascript:formatPhoneNumber()" />
								</td>
							</tr>
							<tr>
								<th scope="row">이메일<span class="font_red">*</span></th>
								<td colspan="3">
									<input type="text" class="inputTxt p100" name="user_email" id="registerEmail" />
								</td> 
							</tr>

							
							<tr>
								<th scope="row">우편번호<span class="font_red">*</span></th>
								<td colspan="2"><input type="text" class="inputTxt p100"
									name="user_zipcode" id="detailaddr" /></td>

								<td><input type="button" value="우편번호 찾기"
									onclick="execDaumPostcode()"
									style="width: 130px; height: 28px;" /></td>
							</tr>
							<tr>
								<th scope="row">주소<span class="font_red">*</span></th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="user_address" id="loginaddr" /></td>
							</tr>
							<tr>
								<th scope="row">상세주소</th>
								<td colspan="3"><input type="text" class="inputTxt p100"
									name="user_dt_address" id="loginaddr1" /></td>
							</tr>

			
				</table>
					
				<div class="btn_areaC mt30" style="margin-bottom: 50px;">
					<a href="javascript:CompleteRegister();" class="btnType blue"
						id="RegisterCom" name="btn"> <span>회원가입 완료</span></a> <a 
						href="javascript:fcancleModal()" class="btnType gray" id="btnCloseLsmCod" name="btn"><span>취소</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</form>	
	</div>


<!-- 아이디 비밀번호 찾기 모달 -->
<form id="sendForm" action="" method="post">
	<input type="hidden" name="ckIdcheck" id="ckIdcheck" value=""/>
	<div id="layer2" class="layerPop layerType2" style="width: 500px;">
		<dl>
			<dt>
				<strong>아이디/비밀번호 찾기</strong>
			</dt>
			<dd style="padding-bottom: 0;">
				<div class="btn_areaC mt30">
					<a href="javascript:fSelectId();" class="btnType gray" id="findId">
						<span>아이디 찾기</span>
					</a> 
					<a href="javascript:fSelectPwd();" class="btnType gray"	id="findPwd">
						<span>비밀번호 찾기</span>
					</a>
				</div>
			</dd>

			<dd class="content">
			<div id="findForm">
			<!-- 아이디 찾기 폼 -->
			<table class="row">
				<caption>caption</caption>
				<colgroup>
					<col width="100px">
					<col width="*">
				</colgroup>
				<tbody id="beforeFindIdForm">
					<tr>
						<th scope="row">
							이름
						</th>
						<td>
							<input type="text" id="regiName" name="regiName"  class="inputTxt p100"
							placeholder="가입하신 이름을 입력하세요"/>
						</td>
					</tr>
					<tr>
						<th scope="row">
							이메일
						</th>
						<td>
							<input type="text" id="emailName" class="inputTxt p100"
							placeholder="가입하신 이메일을 입력하세요" size="30"
							style="height: 30px;" /> 
						</td>
					</tr>
					<tr>
						<td scope="row" colspan="2" 
							style="border: none; text-align: center; background-color: #F3F3F3;">
							<a href="javascript:fMyId();"	class="btnType blue" id="findIdSubmit">
							<span>확인</span></a>
						</td>
					</tr>
				</tbody>
				<tbody id="afterFindIdForm">
				</tbody>
			</table>
					<!-- 비밀번호 찾기 폼 -->
					<table class="row" id="findPwdForm">
						<tbody id="beforeChangeForm">
							<tr>
								<th scope="row">
									아이디
								</th>
								<td>
									<input type="text" id="regiId" name="regiId"  class="inputTxt p100"
									placeholder="가입하신 아이디를 입력하세요"/>
								</td>
							</tr>
							<tr>
								<th scope="row">
									이메일
								</th>
								<td>
									<input type="text" id="emailPwd" class="inputTxt p100"
									placeholder="가입하신 이메일을 입력하세요" size="30"
									style="height: 30px;" /> 
								</td>
							</tr>
							<tr>
								<td scope="row" colspan="2" style="border: none; text-align: center; background-color: #F3F3F3; ">
									<a href="javascript:fMyPw();" class="btnType blue" id="findIdSubmit"
									style="margin: 20;">
									<span>확인</span></a>
								</td>
							</tr>
						</tbody>
						<tbody id="afterChangeForm">
							<tr>
								<th scope="row">변경할 비밀번호</th>
								<td>
									<input type="password" id="reRegiPwd" name="reRegiPwd"  class="inputTxt p100"
									placeholder="숫자,영문자,특수문자 조합으로 8~15자리"/>
								</td>
							</tr>
							<tr>
								<th scope="row">비밀번호 확인</th>
								<td>
									<input type="password" id="reRegiPwdCheck" name="reRegiPwdCheck" class="inputTxt p100"
									style="height: 30px;" /> 
								</td>
							</tr>
							<tr>
								<td scope="row" colspan="2" style="border: none; text-align: center; background-color: #F3F3F3">
									<a href="javascript:changeMyPw();"class="btnType blue" id="changePwdSubmit">
									<span>변경</span></a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>
</form>
</body>
</html>