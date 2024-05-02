<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
						     
  

<c:if test="${listCnt eq 0 }">
	<tr>
		<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCnt > 0 }">
	<c:forEach items="${listData}" var="list">
		<tr>			
			<td><a href="javascript:fPopModal_adv('${list.adv_id}', '${list.lec_id}');">${list.adv_id}</a></td>
			<td>${list.lec_name} (${list.lec_id})</td>
			<td><a href="javascript:fPopModal_adv('${list.adv_id}', '${list.lec_id}');">${list.std_name} ( ${list.std_id} )</a></td>
			<td>${list.adv_date}</td>
			<td>${list.tut_name} (${list.tut_id})</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>