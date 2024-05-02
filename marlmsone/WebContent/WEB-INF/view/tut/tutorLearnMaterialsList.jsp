<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						     
<c:if test="${totalCount eq 0 }">
	<tr>
		<td colspan="3">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${totalCount > 0 }">
	<c:forEach items="${learningMatList}" var="learnMat">
		<tr  id="detailLearnMat" class="detailLearnMat"> 
			<td>${learnMat.learn_data_id}</td>
			<input type="text" id="learnDataId" value="${learnMat.learn_data_id}" hidden>
			<td>
				<a href="javascript:learningMaterialsDetail(${learnMat.learn_data_id});">${learnMat.learnTitle}</a></td>
			<td>
				<fmt:formatDate value="${learnMat.writeDate}" pattern="yyyy-MM-dd" />
			</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value ="${totalCount}"/>