<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${std_Total eq 0 }">
	<tr>
		<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${std_Total > 0 }">
	<c:forEach items="${stdList}" var="list">
		<tr>
			<td>${list.std_num}</td>
			<td>${list.name}</td>
			<td>${list.lec_name}</td>
				
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="std_Total" name="std_Total"
	value="${std_Total}" />