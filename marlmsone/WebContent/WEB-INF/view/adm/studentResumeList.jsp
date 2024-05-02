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
	<c:forEach items="${studentResumeList}" var="studentResume">
		<tr  id="studentResume" class="studentResume"> 
			<td>${studentResume.studentName}</td>
			<td>
				${studentResume.studentId}
			<td>
				${studentResume.studentTel}
			</td>
			<td>
				${studentResume.studentMail}
			</td>
			<td>
				<c:if test="${not empty studentResume.resumeFileName}">
					<a href="/adm/resumeDownload/${studentResume.lectureId}/${studentResume.studentId}">다운로드</a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="studentResumeTotalCount" name="studentResumeTotalCount" value ="${totalCount}"/>
<input type="hidden" id="studentId" name="studentId" value ="${studentResume.studentId}"/>