<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${lecTotal eq 0 }">
	<tr>
		<td colspan="7">강의가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${lecTotal > 0 }">
	<c:forEach items="${lecList}" var="list">
		<tr>
			<td><a
				href="javascript:lec_List('${list.lec_id}')">${list.lec_name}</a></td>
			<td>${list.lec_sort}</td>
			<td>${list.name}</td>
			<td>
				<fmt:formatDate pattern="yy-MM-dd" type="date" value="${ list.start_date }" />
				</td>
			<td>
				<fmt:formatDate pattern="yy-MM-dd" type="date" value="${ list.end_date }" />
			</td>
			<td>
				${list.pre_pnum }
			</td>
			<td>
				${list.max_pnum }
			</td>
				
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="lecTotal" name="lecTotal"
	value="${lecTotal}" />