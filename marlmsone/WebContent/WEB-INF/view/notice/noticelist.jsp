<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						     
							<c:if test="${listcnt eq 0 }">
								<tr>
									<td colspan="5">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${listcnt > 0 }">
								<c:set var="nRow" value="1" />
								<c:forEach items="${listdata}" var="list">
									<tr>
										<td>${nRow}</td>
										<td><a href="javascript:noticeView('${list.notice_id}')">${list.notice_tit}</a></td>
										<td>${list.name}</td>
										<td>${list.regdate}</td>
										<td>${list.hit}</td>
									</tr>
									<c:set var="nRow" value="${nRow + 1}" />
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>