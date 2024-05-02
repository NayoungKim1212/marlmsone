<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
			<c:if test="${listcnt eq 0 }">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			
			<c:if test="${listcnt > 0 }">
				
				<c:forEach items="${listdata}" var="list">
					<tr>
						<td>${list.lec_name}</td>
						<td>${list.hwk_name}</td>
						<td>${list.dead}</td>
						<td><a href="/tut/tutorProject/fileDownLoad/${list.hwk_id}">다운</a></td>
						<%-- <td><a href="javascript:download('${list.hwk_id}')">다운</a></td> --%>
						
						<c:if test="${list.yn=='n'}">
						<td><a href="javascript:saveForm('${list.hwk_id}')">제출</a></td>
						<td>미제출</td>
						</c:if>
						
						<c:if test="${list.yn=='y'}">
						<td><a href="javascript:modifyForm('${list.hwk_id}')">수정</a></td>
						<td>제출완료</td>
						</c:if>
					</tr>
					
				</c:forEach>
			</c:if>
			
			<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>			

