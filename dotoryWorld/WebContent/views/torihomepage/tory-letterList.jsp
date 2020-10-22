<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<%-- 방명록 글 목록 --%>
<table id="toryLetterListTable">
	<c:forEach var="list" items="${requestScope.letterVO.letterList }">
		<thead>
			<tr>
				<th>No.${list.homeNo }</th>
				<th><a href = "${pageContext.request.contextPath}/front?command=toryHome&id=${list.homewriterId }">${list.homewriterId }</a></a></th>
				<th>${list.homeDate }</th>
				<c:choose>
					<c:when test="${mvo.id == list.homewriterId || mvo.id == list.memberVO.id || mvo.grade == '다람쥐'}">
						<th>			
							<form action="${pageContext.request.contextPath}/front" id="toryLetterList">
								<input type="hidden" name="command" value="toryLetterDelete">
								<input type="hidden" name="letterWriter" value="${list.homewriterId }">
								<input type="hidden" name="id" value="${list.memberVO.id }">
								<input type="hidden" name="ltterNo" value="${list.homeNo }">
								<input type="submit" value="삭제">
							</form>
						</th>
					</c:when>
					<c:otherwise>
						<th></th>
					</c:otherwise>
				</c:choose>
			</tr>
		</thead>
		<tbody>
			<tr>
				<c:choose>
					<c:when test="${list.memberVO.profilePhoto==null }">
						<td>
							<img src="${pageContext.request.contextPath}/resources/img/profile/profileDefualt.png">
						</td>
					</c:when>
					<c:otherwise>
						<td><img src="${pageContext.request.contextPath}/resources/img/profile/${list.memberVO.profilePhoto }"></td>
					</c:otherwise>
				</c:choose>
				<td colspan="3">
					${list.homeContent }
				</td>
			</tr>
			<tr><td><br></td></tr>
		</tbody>
	</c:forEach>
</table>

<%-- 방명록 글 남기기 --%>
<form action="${pageContext.request.contextPath}/front"
	id="toryLetterWriteForm">
	<input type="hidden" name="id"
		value="${requestScope.toryHomeImformation.id}"> <input
		type="hidden" name="id_writer" value="${mvo.id }"> <input
		type="hidden" name="command" value="toryletterWrite">
	<table id="letterWrite">
		<tbody>
			<tr>
				<td><textarea id="letterForm" cols="130" rows="4"
						name="contentLetter" required="required"></textarea></td>
				<td>&emsp; <input type="submit" value="확인">
				</td>
			</tr>
		</tbody>
	</table>
</form>

<%-- 방명록 페이징 --%>
<div class="pagingArea">
	<c:set var="paging" value="${requestScope.letterVO.pagingBean }" />
	<ul class="pagination">
		<c:if test="${paging.previousPageGroup }">
			<li><a
				href="${pageContext.request.contextPath}/front?command=toryHome&id=${requestScope.letterVO.letterList[0].memberVO.id}&letterPageNo=${paging.startPageOfPageGroup-1 }">&laquo;</a>
			</li>
		</c:if>
		<c:forEach var="i" begin="${paging.startPageOfPageGroup }"
			end="${paging.endPageOfPageGroup }">
			<c:choose>
				<c:when test="${pb.nowPage!=i }">
					<li><a
						href="${pageContext.request.contextPath}/front?command=toryHome&id=${requestScope.letterVO.letterList[0].memberVO.id}&letterPageNo=${i }">${i }</a></li>
				</c:when>
				<c:otherwise>
					<li class="active"><a href="#">${i }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.nextPageGroup }">
			<li><a
				href="${pageContext.request.contextPath}/front?command=toryHome&id=${requestScope.letterVO.letterList[0].memberVO.id}&letterPageNo=${paging.endPageOfPageGroup+1 }">&raquo;</a>
			</li>
		</c:if>
	</ul>
</div>