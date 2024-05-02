<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

		<dl>
			<dt>
				<strong> Q&A</strong>
			</dt>
			<dd class="content">
				<div style="text-align: right;" >
				
				<c:if test="${data.check eq false}">
					<a  href="javascript:qnaModifyPop();" class="" id="btnGetModify" name="btnGetModify"><span>수정</span></a>
					<a href="javascript:qnaDelete();" class="" id="btnDelete" name="btnDelete"><span>삭제</span></a>
                </c:if>
				</div>
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
							<tr>
								<th scope="row">제목 <span class="font_red">*</span></th>
								<td colspan=3 ><span id="viewTitle" >${data.qna_title} </span></td>
							</tr>
							<tr>
								<th scope="row">내용 <span class="font_red">*</span></th>
								<td colspan="3" ><span id="viewCon" >${data.qna_con}</span></td>
							</tr>
					</tbody>
				</table>
				<div style="margin-bottom: 30px;"></div>
				<!-- e : 여기에 내용입력 -->

				<!-- 댓글 구역 -->
				댓글
				<!-- 댓글 입력 구역 -->
					<div>
						<span id="conditionContent" name="conditionContent"><input type="text" style="width:500px; height: 20px; font-size:12px; margin-right: 4px;" id="rv_con" name="rv_con"></span>
						<span id="condition" name="condition"><a href="javascript:commentSave();" id="commentSave" name="commentSave">등록</a></span>
					</div>
					<div style="height: 20px;"></div>

				<!-- /댓글 입력 구역 -->				

				<!-- 댓글 출력 구역 -->
				<div id="commentsBox">
					<table>	

						<thead></thead>
						<tbody id="commentList"></tbody>
					</table>
					<div class="paging_area2" id="Pagination2"></div>
				</div>
				<!-- /댓글 출력 구역 -->
			
			<table class="row">
		       <caption>caption</caption>
		       <colgroup>		
		           <col width="50px">
		           <col width="*">	
			       <col width="120px">
		       </colgroup>

		       <tbody>
		
		       <c:set var="nRow" value="1" />			
		       <c:forEach items="${commentData}" var="commentList">
		
			       <tr>
		       	    <td rowspan=2  style="text-align: center;" >${nRow}</td>	
			       	<td><strong>${commentList.loginID}</strong></td>	
		       		<td>
		       		  <c:if test="${commentList.loginID eq sessionScope.loginId}">

                            <a href="javascript:commentOldView('${commentList.rv_id}');" id="commentOldView" name="commentOldView"  >수정</a>
                            <a href="javascript:commentDelete('${commentList.rv_id}');" id="commentDelete" name="commentDelete" >삭제</a>

                         </c:if>
                       </td>	
			       </tr>
			       <tr>	
			       	<td>${commentList.rv_con}</td>
			       	<td>${commentList.regdate}</td>
			       </tr>
			       <c:set var="nRow" value="${nRow + 1}" />
		       </c:forEach>
		
		       </tbody>
		       </table>
			
			</dd>
		</dl>
		
		
		 <a href="javascript:viewClose();" class="closePop" ><span class="hidden"  style="display:none">닫기</span></a> 


