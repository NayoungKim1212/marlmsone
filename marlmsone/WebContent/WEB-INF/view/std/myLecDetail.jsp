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
	<tr>
		<th scope="row">강의명</th>
		<td>${listData[0].lec_name}</td>
		<th scope="row">강의분류</th>
		<td>${listData[0].lec_type_name}</td>		
	</tr>
	<tr>
		<th scope="row">강사명</th>
		<td>${listData[0].tut_name}</td>
		<th scope="row">강의실</th>
		<td>${listData[0].lecrm_name}</td>
	</tr>
	<tr>
		<th scope="row">강의기간</th>
		<td colspan="3">${listData[0].start_date} ~ ${listData[0].end_date}</td>
	</tr>
	<tr>
		<th scope="row">수업목표</th>
		<td colspan="3">${listData[0].lec_goal}</td>
	</tr>

	<c:forEach items="${listData}" var="list">
		<c:if test="${list.week != null}">
			<tr>
				<th scope="row" rowspan="2">${list.week}</th>
				<th>학습목표</th>		
				<td colspan="2">${list.learn_goal}</td>
			</tr>
			<tr>
				<th>학습내용</th>
				<td colspan="2">${list.learn_con}</td>
			</tr>
		</c:if>
	</c:forEach>
</c:if>


<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>						     