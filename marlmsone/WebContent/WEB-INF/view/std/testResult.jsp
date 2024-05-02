<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate"/>
						     
<c:if test="${listCnt eq 0 }">
	<tr>
		<td colspan="4">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCnt > 0 }">
	<tr>
		<th scope="row">시험명</th>
		<td colspan="3">${data.test_name}</td>
	</tr>
	<tr>
		<th scope="row">강의명</th>
		<td>${data.lec_name}</td>
		<th scope="row">강사명</th>
		<td>${data.tut_name}</td>
	</tr>
		<tr>
		<th scope="row">시험응시일</th>
		<td>${data.test_date}</td>
		<th scope="row">시험결과</th>
		<td>${data.test_score}&nbsp;
			<c:choose>
            	<c:when test="${data.pass eq 'P'}">(합격)</c:when>
				<c:when test="${data.pass eq 'F'}">(불합격)</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th colspan="4">시험응시 결과</th>
	</tr>
	<c:forEach items="${dataList}" var="list">
		<tr>
			<td colspan="4" >
				<span>${list.test_num}번. ${list.test_que}</span>
			</td>
		</tr>
		<tr style="line-height: 23px;">
			<!-- 문제 보기 영역(학생의 답안에 체크표시) -->
			<td colspan="4">							
				<input type="radio" name="submit_answer${list.test_num}" value="1"
					<c:if test="${list.submit_answer eq '1'}">checked="checked"</c:if>
					<c:if test="${list.submit_answer ne '1'}">disabled="disabled"</c:if>
				>&nbsp; ${list.que_ex1} <br>

				<input type="radio" name="submit_answer${list.test_num}" value="2"
					<c:if test="${list.submit_answer eq '2'}">checked="checked"</c:if>
					<c:if test="${list.submit_answer ne '2'}">disabled="disabled"</c:if>
				>&nbsp; ${list.que_ex2} <br>

				<input type="radio" name="submit_answer${list.test_num}" value="3"
					<c:if test="${list.submit_answer eq '3'}">checked="checked"</c:if>
					<c:if test="${list.submit_answer ne '3'}">disabled="disabled"</c:if>
				>&nbsp; ${list.que_ex3} <br>

				<input type="radio" name="submit_answer${list.test_num}" value="4"
					<c:if test="${list.submit_answer eq '4'}">checked="checked"</c:if>
					<c:if test="${list.submit_answer ne '4'}">disabled="disabled"</c:if>
				>&nbsp; ${list.que_ex4} <br>
				

				<span class="font_red">
					<c:if test="${list.answer ne list.submit_answer}">정답 : ${list.answer}번</c:if>
				</span>				
			</td>   
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="lec_id" name="lec_id" value ="${lec_id}"/>
<input type="hidden" id="test_id" name="test_id" value ="${test_id}"/>
<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>