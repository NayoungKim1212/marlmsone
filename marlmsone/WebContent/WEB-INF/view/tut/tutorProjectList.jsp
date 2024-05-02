<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						     
<c:if test="${totalCount eq 0 }">
	<tr>
		<td colspan="5">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${totalCount > 0 }">
	<c:forEach items="${tutorProjectList}" var="project">
		<tr  id="detailTutorProject" class="detailTutorProject"> 
			<td>${project.projectId}</td>
			<input type="text" id="projectId" value="${project.projectId}" hidden>
			<td>
				<a href="javascript:tutorProjectDetail(${project.projectId});">${project.projectContent}</a></td>
			<td>${project.startDate}</td>
			<td>${project.deadLineDate}</td>
			<td><a href="javascript:projectSubmitDetail(${project.projectId});">자세히 보기</a></td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value ="${totalCount}"/>