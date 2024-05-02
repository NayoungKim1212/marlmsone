<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate"/>
						     
<c:if test="${listCnt eq 0 }">
	<tr>
		<td colspan="3">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCnt > 0 }">
	<c:forEach items="${listData}" var="list">
		<tr>
			<td>${list.lec_name}</td>
			<td>${list.lec_type_name}</td>
			<td>${list.start_date} ~ ${list.end_date}</td>
			
			<td> <!-- 출제된 시험정보 -->
				<c:if test="${list.test_id == 0}">
					<a class="btnType blue" 
						href="javascript:fPopModal_generateTest( ${list.lec_id}, 
																'${list.lec_name}', 
																 ${list.lec_type_id}, 
																'${list.lec_type_name}');" name="modal"><span>시험문제 출제</span></a>											
				</c:if>
				<c:if test="${list.test_id > 0}">					
					<a href="javascript:fView_testDetail('${list.lec_name}', '${list.test_id}');">
							<span><strong>시험문제 보기</strong></span></a>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>