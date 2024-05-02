<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						     
<c:if test="${totalCount eq 0 }">
	<tr>
		<td colspan="4">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${totalCount > 0 }">
	<c:forEach items="${learningMatList}" var="list">
		<tr  id="detailLecture" class="detailLecture"> 
			<td>${list.learn_data_id}</td>
			<td>${list.lec_name}</td>
			<td>
				<a href="javascript:stdLectureDetail(${list.learn_data_id});">${list.learn_tit}</a></td>
			<td>
			 ${list.w_date} 
			</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value ="${totalCount}"/>