<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						     
	<c:if test="${totalCnt eq 0 }">
		<tr>
			<td colspan="4">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${totalCnt > 0 }">
		<c:forEach items="${lecList}" var="list">
			<tr>
				<td>${list.lec_type_name}</td>
				<td><a href="javascript:fPopModal('${list.lec_id}')">${list.lec_name}</a></td>
				<td>${list.start_date} ~ ${list.end_date}</td>
				<td>${list.pre_pnum} / ${list.max_pnum }</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<input type="hidden" id="totalCnt" name="totalCnt" value ="${totalCnt}"/>