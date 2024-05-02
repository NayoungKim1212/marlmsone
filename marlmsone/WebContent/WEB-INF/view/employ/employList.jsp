<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${emp_Total eq 0 }">
	<tr>
		<td colspan="8">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${emp_Total > 0 }">
	<c:forEach items="${empInfo}" var="list">
		<tr>
			<td>${list.std_num}</td>
			<td><a
				href="javascript:fstd_info('${list.std_id}')">${list.name}</a></td>
			<td>${list.tel}</td>
			<td>${list.employ_day}</td>
			<td>${ list.resign_day }</td>
			<%-- <td>
				<fmt:formatDate pattern="yy-MM-dd" type="date" value="${ list.start_date }" />
				~
				<fmt:formatDate pattern="yy-MM-dd" type="date" value="${ list.end_date }" />
			</td> --%>
			<td>
				${list.comp_name }
			</td>
		
				<td><c:if test="${list.employ_day < list.resign_day}"> 퇴사</c:if> <c:if
					test="${list.employ_day > list.resign_day }">재직중</c:if>			

			<td><a class="btnType3 color1"
				href="javascript:modify('${list.std_id}', 'U');"><span>수정</span></a>
				/
				<a class="btnType3 color1"
				href="javascript:delete_emp('${list.std_id}');"><span>삭제</span></a></td>
				
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="emp_Total" name="emp_Total"
	value="${emp_Total}" />