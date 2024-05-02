<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate"/>
						     
<c:if test="${listCnt eq 0 }">
	<tr>
		<td colspan="6">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCnt > 0 }">
	<c:forEach items="${listData}" var="list">
		<tr>
			<td>${list.lec_name}</td>
			<td>${list.test_name}</td>
			<td>${list.tut_name}</td>
			<td>${list.test_start} ~ ${list.test_end}</td>
			<td> <!-- 시험결과 -->
				<c:choose>
                    <c:when test="${list.pass eq 'P'}">합격</c:when>
					<c:when test="${list.pass eq 'F'}">불합격</c:when>
					<c:otherwise>미응시</c:otherwise>
                </c:choose>
			</td>
			<td>
				<c:choose>			
					<c:when test="${list.test_yn eq 'Y'}">
						<a href="javascript:fView_testResult(${list.lec_id}, ${list.test_id});">
							<span><strong>결과확인</strong></span></a>				
					</c:when>
					<c:when test="${list.test_yn eq 'N' and list.test_end >= nowDate}">
						<a href="javascript:fApply_test( ${list.lec_id}, 
						                                '${list.lec_name}', 
						                                 ${list.test_id}, 
						                                '${list.test_name}',
						                                '${list.tut_name}');">
							<span><strong>시험응시</strong></span></a>				
					</c:when>
					<c:otherwise><strong>기간종료</strong></c:otherwise>
				</c:choose>
			</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>