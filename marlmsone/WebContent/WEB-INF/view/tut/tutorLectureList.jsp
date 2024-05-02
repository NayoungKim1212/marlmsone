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
	<c:forEach items="${lectureList}" var="lecture">
		<tr  id="detailLecture" class="detailLecture"> 
			<td>${lecture.lec_id}</td>
			<td>
				<a href="javascript:tutorLectureDetail(${lecture.lec_id});">${lecture.lec_name}</a></td>
			<td>
				<fmt:formatDate value="${lecture.start_date}" pattern="yyyy-MM-dd" />
				~
				<fmt:formatDate value="${lecture.end_date}" pattern="yyyy-MM-dd" />
			</td>
			<td>
				<a class="btnType blue" href="javascript:getLectureStudentList(${lecture.lec_id})">
					<span id="searchEnter">조회</span>
				</a>
			</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value ="${totalCount}"/>