<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						     
<c:if test="${totalCount eq 0 }">
	<tr>
		<td colspan="5">과제가 존재하지 않습니다.</td>
	</tr>
</c:if>
<c:if test="${totalCount > 0 }">
	<c:forEach items="${studentProjectList}" var="project">
		<tr  id="studentProjectList" class="studentProjectList"> 
			<td>${project.student_name}</td>
			<input type="text" id="projectId" value="${project.submit_id}" hidden>
			<td>
				${project.submit_con}
			</td>
			<td><a href="/tut/studentProject/fileDownLoad/${project.submit_id }">다운로드</a></td>
			<td>${project.submit_date}</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value ="${totalCount}"/>