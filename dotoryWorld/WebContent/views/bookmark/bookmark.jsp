<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 링크 주자 --%>
		<h2><img src="resources/img/bookMark.png" id="bookMarkImg"></h2>

<form  id="boardTable">
<table class="table">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>취미</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${requestScope.bookmarkList}" var="mark">
			<tr>
				<td>${mark.bookmarkNo}</td>
				<td><a href="${pageContext.request.contextPath}/front?command=postDetail&no=${mark.bookmarkLink}">${mark.postVO.postTitle}</a></td>
				<td>${mark.memberVO.id}</td>
				<td>${mark.boardVO.boardTitle }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form>
<nav aria-label="Page navigation example">
	<ul class="pagination">
		<c:if test="${requestScope.bookmarkPagin.previousPageGroup}">
			<li class="page-item"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=bookmarkList&nowPage=${requestScope.bookmarkPagin.startPageOfPageGroup-1}&id=${sessionScope.mvo.id}&bookmark=북마크"
				aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
		</c:if>

		<c:forEach begin="${requestScope.bookmarkPagin.startPageOfPageGroup}"
			end="${requestScope.bookmarkPagin.endPageOfPageGroup}" var="bmPagin">
			<c:choose>
				<c:when test="${requestScope.bookmarkPagin.nowPage == bmPagin}"><li class="page-item active"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=bookmarkList&nowPage=${bmPagin}&id=${sessionScope.mvo.id}&bookmark=북마크">${bmPagin}</a></li></c:when>
				<c:otherwise><li class="page-item"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=bookmarkList&nowPage=${bmPagin}&id=${sessionScope.mvo.id}&bookmark=북마크">${bmPagin}</a></li></c:otherwise>
			</c:choose>
			
		</c:forEach>

		<c:if test="${requestScope.bookmarkPagin.nextPageGroup}">
			<li class="page-item"><a class="page-link"
				href="${pageContext.request.contextPath}/front?command=bookmarkList&nowPage=${requestScope.bookmarkPagin.endPageOfPageGroup+1}&id=${sessionScope.mvo.id}&bookmark=북마크"
				"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</c:if>
	</ul>
</nav>

