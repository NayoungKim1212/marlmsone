<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalGradeCnt eq 0 }">
	<tr>
		<td colspan="6">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalGradeCnt > 0 }">
	<c:forEach items="${checkgradeList}" var="list">
		<tr>
			<td>${list.lec_name}</td>
			<td><a
				href="javascript:StdList('${list.lec_id}')">${list.test_name}</a></td>
			<td>${list.lecStatus}</td>
			<td>${list.pre_pnum }</td>
			<td>${list.cnt }</td>
			<td>${list.noTest }</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt" name="totalCnt"
	value="${totalGradeCnt}" />