<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${totalCnt eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCnt > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${lecList}" var="list">
		<tr>
			<td><strong><a href="javascript:showChart('${list.lec_id}')">${list.lec_name}</a></strong></td>
			<td>${list.start_date} ~ ${list.end_date}</td>
			<td>${list.name}</td>
			<td>${list.pre_pnum}</td>
			<td>${list.fail_cnt} (${list.fail_rate}%)</td>
			<td>${list.tot_score}</td>
			<td>${list.avg_score}</td>
			<td>${list.max_score}</td>
			<td>${list.min_score}</td>
			
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt" name="totalCnt" value="${totalCnt}" />