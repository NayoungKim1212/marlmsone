<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${checkStdCount eq 0 }">
	<tr>
		<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${checkStdCount > 0 }">
	<c:forEach items="${checkStdList}" var="list">
		<tr>
			<td>${list.loginID}</td>                      <!-- 아이디 -->
			<td>${list.name}</a></td>         <!-- 학생명 -->
			<td>${list.test_score}</td>                     <!-- 점수-->
			<td>${list.pass }</td>              <!-- 통과/과락  -->
	       <td>${list.test_yn }</td>          <!-- 응시상태 -->
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="stListCnt" name="stListCnt"
	value="${checkStdCount}" />