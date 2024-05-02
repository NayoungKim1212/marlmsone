<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${totalCnt_lec eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCnt_lec > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${list_lec}" var="list">
		<tr>
			<td>${list.lec_id}</td>
			<td><strong><a href="javascript:flist_std(1, '${list.lec_id}')">${list.lec_name}</a></strong></td>
			<td>${list.start_date}~${list.end_date}</td>
		</tr>
	<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt_lec" name="totalCnt_lec" value="${totalCnt_lec}" />