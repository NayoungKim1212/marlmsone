<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${listcnt eq 0 }">
	<tr>
		<td colspan="10">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${listcnt > 0 }">
	<c:set var="nRow" value="1" />
	<c:forEach items="${listdata}" var="list">
		<tr>
					
			  		<td><input type="checkbox" name="rowCheckbox" class="rowCheckbox" data-item-id="${list.que_id}"></td>
			  		<td>${list.lec_type_name}</td>
                    <td>${list.test_que}</td>
                    <td>${list.que_ans}</td>
                    <td>${list.que_ex1}</td>
                    <td>${list.que_ex2}</td>
                    <td>${list.que_ex3}</td>
                    <td>${list.que_ex4}</td>
                    

			<td><a class="btnType3 color1"
				href="javascript:Modify('${list.que_id}');"><span>수정</span></a></td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="listcnt" name="listcnt" value="${listcnt}" />