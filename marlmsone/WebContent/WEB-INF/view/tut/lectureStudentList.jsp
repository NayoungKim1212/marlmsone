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
	<c:forEach items="${lectureStudentList}" var="lectureStudent">
		<tr  id="lectureStudent" class="lectureStudent"> 
			<td>${lectureStudent.student_number}</td>
			<td>
				<a href="javascript:getLectureStudentDetail('${lectureStudent.std_id}');">${lectureStudent.student_name} (${lectureStudent.std_id})</a></td>
			<td>
				${lectureStudent.student_tel}
			</td>
			<td>
				${lectureStudent.join_date}
			</td>
			<td>
				${lectureStudent.approve_yn}
			</td>
			<td>
				<c:if test="${lectureStudent.approve_yn == 'N'}">
					<a href="javascript:lectureStudentApprove('${lectureStudent.std_id}', '${lectureStudent.lec_Id}');"	class="btnType blue"  id="btnApprove" name="btn"><span>승인</span></a>
				</c:if>
				<c:if test="${lectureStudent.approve_yn == 'Y'}">
					<a href="javascript:lectureStudentCancle('${lectureStudent.std_id}', '${lectureStudent.lec_Id}');"	class="btnType gray"  id="btnClose" name="btn"><span>취소</span></a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</c:if>
<input type="hidden" id="studentTotalCount" name="studentTotalCount" value ="${totalCount}"/>
<input type="hidden" id="lectureIdValue" name="lectureIdValue" value ="${lectureValue}"/>