<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate"/>

${listCnt}						     
<c:if test="${listCnt eq 0 }">
	<tr>
		<td colspan="4">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCnt > 0 }">

	<tr>
		<th scope="row">강의명</th>
		<td>${lec_name}</td>
		<th scope="row">시험명</th>
		<td>${test_name}</td>		
	</tr>	
	<tr>
	<tr>
		<th colspan="4">시험문제</th>
	</tr>
	<c:forEach items="${listData}" var="list">
		<tr>
			<td colspan="4">
				<span>${list.test_num}번. ${list.test_que}</span>
				<input type="hidden" id="test_num${list.test_num}" name="test_num${list.test_num}" value="${list.test_num}"/>
				<input type="hidden" id="answer${list.test_num}" name="answer${list.test_num}" value="${list.que_ans}"/>
		</td>
		</tr>
		<tr style="line-height: 23px;">
			<!-- 문제 보기 영역 -->
			<td colspan="4">
				1. ${list.que_ex1}<br>
				2. ${list.que_ex2}<br>
				3. ${list.que_ex3}<br>
				4. ${list.que_ex4}<br>
				<span class="font_red">정답 : ${list.que_ans}번</span>				
			</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="lec_id" name="lec_id" value ="${lec_id}"/>
<input type="hidden" id="test_id" name="test_id" value ="${test_id}"/>
<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>