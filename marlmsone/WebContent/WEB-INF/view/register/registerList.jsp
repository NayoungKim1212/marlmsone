<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${lec_Total eq 0 }">
	<tr>
		<td colspan="7">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${lec_Total > 0 }">
	<c:forEach items="${lec_List}" var="list">
		<tr>
			<td>${list.lec_id}</td>
			<td><a
				href="javascript:stdList('${list.lec_id}')">${list.lec_name}</a></td>
			<td>${list.t_name}</td>
			<td>${list.lecrm_name}</td>
			<td>${ list.pre_pnum }</td>
			<%-- <td>
				<fmt:formatDate pattern="yy-MM-dd" type="date" value="${ list.start_date }" />
				~
				<fmt:formatDate pattern="yy-MM-dd" type="date" value="${ list.end_date }" />
			</td> --%>
			<td>
				${list.start_date } ~ ${list.end_date }
			</td>
			<td><a class="btnType3 color1"
				href="javascript:modify('${list.lec_id}', 'U');"><span>수정</span></a>
				/
				<a class="btnType3 color1"
				href="javascript:deletelec('${list.lec_id}');"><span>삭제</span></a></td>
				
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="lec_Total" name="lec_Total"
	value="${lec_Total}" />