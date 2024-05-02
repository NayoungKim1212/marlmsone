<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>				   
		   
<option>과정명 선택</option>
<c:forEach items="${listData}" var="list">
	<option value="${list.lec_id}"> ${list.lec_name}</option>
</c:forEach>