<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${totalCnt_std eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCnt_std > 0 }">
	<c:forEach items="${list_std}" var="list">
		<tr>
			<td>${list.std_num}</td>
			<td>
				<c:if test="${list.lec_name eq null}">미수강</c:if>
				<c:if test="${list.lec_name ne null}">${list.lec_name}</c:if>
			</td>
			<td><strong><a href="javascript:fstd_info('${list.loginID}')">${list.name} (${list.loginID })</a></strong></td>
			<td>${list.tel}</td>
			<td>${list.join_date}</td>
			<td>
				<a class="btnType3 color1" href="javascript:ban_user('${list.loginID}')"><span>탈퇴</span></a>
			</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt_std" name="totalCnt_std" value="${totalCnt_std}" />