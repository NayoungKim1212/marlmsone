<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>				   
		   
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="nowDate"/>

<option value="" id="option1" selected="selected">전체 과정</option>
<c:forEach items="${listData}" var="list">
	<option value="${list.lec_id}"> 
	<c:if test="${nowDate <= list.end_date}">(진행중) </c:if>
	<c:if test="${nowDate > list.end_date}">(종료) </c:if>
	${list.lec_name}
	</option>
</c:forEach>