<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate"/>
						     
<c:if test="${listCnt eq 0 }">
	<tr>
		<td colspan="7">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCnt > 0 }">
	<c:forEach items="${listData}" var="list">
		<tr>
			<td>${list.lec_id}</td>
			<td><a href="javascript:fPopModal_myLecDetail('${list.lec_id}');">${list.lec_name}</a></td>
			<td>${list.tut_name}</td>
			<td>${list.lecrm_name}</td>
			<td>${list.start_date} ~ ${list.end_date}
				<c:if test="${list.apv_yn eq 'Y' and nowDate <= list.end_date}"> (진행중)</c:if>
				<c:if test="${list.apv_yn eq 'Y' and nowDate > list.end_date}"> (종료)</c:if>
			</td>
			<td>
				<c:if test="${list.apv_yn eq 'Y'}">승인</c:if>
				<c:if test="${list.apv_yn eq 'N'}">미승인</c:if>
			</td>
			<td>
				<c:choose>			
					<c:when test="${list.srvy_yn eq 'Y'}">완료</c:when>
					<c:when test="${list.srvy_yn eq 'N' and nowDate > list.end_date}">
						<a href="javascript:fSurvey('${list.lec_id}', '${list.lec_name}', '${list.tut_name}');">
							<span><strong>설문조사</strong></span></a>					
					</c:when>
					<c:otherwise>응시기간 아님</c:otherwise>	
				</c:choose>
			</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>