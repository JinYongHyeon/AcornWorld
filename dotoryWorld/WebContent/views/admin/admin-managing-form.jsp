<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<form action="${pageContext.request.contextPath}/front"
						method="post" id="adminPostDeletForm" onsubmit="return postDelete()">
<table class="table">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
			<th>비고</th>
		</tr>
	</thead>
	
	<tbody>
		<c:forEach items="${requestScope.postList}" var="list"
			varStatus="index">
			<tr>
				<td>${list.postNo}</td>
				<td>${list.postTitle}</td>
				<td>${list.memberVO.id}</td>
				<td>${list.postDate}</td>
				<td>${list.viewCount}</td>
				<td>
						<input type="hidden" name="command" value="adminManageDelete"> <input
							type="checkbox" name="postNo" value="${list.postNo}">
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<button type="submit">삭제</button>
</form>

	<nav aria-label="Page navigation example" id="adminPagin">
	<ul class="pagination">
		<c:if test="${paginBean.previousPageGroup == true}">
			<li class="page-item"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=adminManage&nowPage=${paginBean.startPageOfPageGroup-1}"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
		</c:if>
		<c:forEach begin="${paginBean.startPageOfPageGroup}"
			end="${paginBean.endPageOfPageGroup}" var="index">
			<c:choose>
				<c:when test="${paginBean.nowPage == index}">
					<li class="page-item active"><a class="page-link"
						href="${pageContext.request.contextPath}/front?command=adminManage&nowPage=${index}">${index}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/front?command=adminManage&nowPage=${index}">${index}</a></li>
				</c:otherwise>
			</c:choose>

		</c:forEach>
		<c:if test="${paginBean.nextPageGroup == true}">
			<li class="page-item"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=adminManage&nowPage=${paginBean.endPageOfPageGroup+1}"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</c:if>
	</ul>
</nav>






