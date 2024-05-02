<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${listcnt eq 0}">
		<tr>
			<td colspan="5">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	
	<c:if test="${listcnt > 0 }">
		<c:forEach items="${listdata}" var="list">
			<tr>
				<td>
					${list.lecrm_name}
				</td>
				<td>${list.equ_name}</td>
				<td>${list.equ_num}</td>
				<td>${list.equ_note}</td>
				
				<td>
					<a class="btnType3 color1" href="javascript:equDtl('${list.equ_id}');"><span>수정</span></a>
				</td>
			</tr>
		</c:forEach>
	</c:if>
	
	
	<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>