<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						   
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" pattern="yyyy.MM.dd" var="nowDate"/>
						     
<c:if test="${listCnt eq 0 }">
	<tr>
		<td colspan="4">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listCnt > 0 }">
	<tr>
		<th scope="row">강의명</th>
		<td>${lec_name}</td>
		<th scope="row">강사명</th>
		<td>${tut_name}</td>
	</tr>
	<tr>
		<th colspan="4">설문항목</th>
	</tr>
	<c:forEach items="${listData}" var="list">
		<tr>
			<td colspan="4">
				<span>${list.que_num+1}. ${list.que}</span>
				<input type="hidden" id="que_num${list.que_num}" name="que_num${list.que_num}" value="${list.que_num}"/>				
		</td>
		</tr>
		<tr style="line-height: 23px;">
			<!-- 문제 보기 영역 -->
			<td colspan="4">
				<c:choose>
					<c:when test="${list.que_one == null && 
							        list.que_two == null &&
							        list.que_three == null &&
   							        list.que_four == null &&
							        list.que_five == null}">
			        	<textarea id="review" rows="4" cols="50"></textarea>
			        </c:when>
					<c:otherwise>
						<c:if test="${not empty list.que_one}">
							<input type="radio" name="survey_answer${list.que_num}" value="1">
								${list.que_one} <br>
						</c:if>
						<c:if test="${not empty list.que_two}">
							<input type="radio" name="survey_answer${list.que_num}" value="2"> 
								${list.que_two} <br>
						</c:if>
						<c:if test="${not empty list.que_three}">
							<input type="radio" name="survey_answer${list.que_num}" value="3"> 
								${list.que_three} <br>
						</c:if>
						<c:if test="${not empty list.que_four}">
							<input type="radio" name="survey_answer${list.que_num}" value="4"> 
								${list.que_four} <br>
						</c:if>
						<c:if test="${not empty list.que_five}">
							<input type="radio" name="survey_answer${list.que_num}" value="5"> 
								${list.que_five} <br>
						</c:if>
					</c:otherwise>
				</c:choose>
			</td>   
		</tr>
	</c:forEach>
</c:if>

<input type="hidden" id="survey_review" name="survey_review" value=""/>

<input type="hidden" id="lec_id" name="lec_id" value ="${lec_id}"/>
<input type="hidden" id="lec_name" name="lec_name" value ="${lec_name}"/>
<input type="hidden" id="tut_name" name="tut_name" value ="${tut_name}"/>
<input type="hidden" id="listCnt" name="listCnt" value ="${listCnt}"/>