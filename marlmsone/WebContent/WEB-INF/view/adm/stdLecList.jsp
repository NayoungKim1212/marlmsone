<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate" />


<c:if test="${std_lec_count == 0}">
	<tr>
		<td colspan="5">수강정보가 없습니다</td>
	</tr>
</c:if> 

<c:if test="${std_lec_count > 0}">
	<c:forEach items="${slist_lec}" var="list">
		<tr>
			<td>${list.lec_id}</td>
			<td>${list.lec_name }</td>
			<td>${list.start_date}~ ${list.end_date}</td>
			<td>
				<c:choose>
					<c:when test="${list.end_date < nowDate}">종료</c:when>
					<c:otherwise>진행중</c:otherwise>
				</c:choose>
			</td>
			<td>
				<c:choose>
					<c:when test="${list.end_date < nowDate}">
						<span class="btnType1 color1" disabled>수강 완료</span>
					</c:when>
					<c:otherwise>
						<a class="btnType3 color1" href="javascript:std_lec_del('${list.lec_id}')"><span>수강 취소</span></a>
					</c:otherwise>
				</c:choose>
			</td>		
		</tr>
	</c:forEach>
</c:if>	