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
	<c:forEach items="${lectureList}" var="lecture">
		<tr  id="lectureLists" class="lectureLists"> 
			<td>${lecture.lec_id}</td>
			<td>
				<a href="javascript:getLectureStudentResume('${lecture.lec_id}');">${lecture.lec_name} </a></td>
			<td>
				${lecture.tutor_name}
			</td>
			<td>
				${lecture.pre_pnum}
			</td>
			<td>
				<fmt:formatDate value="${lecture.start_date}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${lecture.end_date}" pattern="yyyy-MM-dd" />
			</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="lectureTotalCount" name="lectureTotalCount" value ="${totalCount}"/>
<input type="hidden" id="lectureIdValue" name="lectureIdValue" value ="${lecture.lec_id}"/>