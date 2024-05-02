<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate" />

	<c:if test="${lec_count == 0}">
		<tr>
			<td colspan="4">수강정보가 없습니다</td>
		</tr>
	</c:if>

	<c:if test="${lec_count > 0}">
		<c:forEach items="${std_info}" var="list">
			<tr>
				<td>${list.lec_id}</td>
				<td>${list.lec_name }</td>
				<td>${list.start_date}~${list.end_date}</td>
				<td><c:if test="${nowDate < list.end_date}"> 수강중</c:if> <c:if
						test="${list.end_date < nowDate }">수강완료</c:if></td>
			</tr>
		</c:forEach>
	</c:if>