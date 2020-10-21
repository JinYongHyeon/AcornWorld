<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<ul>
	<c:forEach items="${requestScope.bookmarkList}" var="mark">
		<li>
		<form action="${pageContext.request.contextPath}/front">
		<img src="${pageContext.request.contextPath}/resources/img/${mark.boardVO.boardImage}">
		<a href="${pageContext.request.contextPath}/front?command=postList&hobbyBoardNo=${mark.bookmarkLink}">${mark.boardVO.boardTitle}</a>
		</form>
		</li>
	</c:forEach>
</ul>
<nav aria-label="Page navigation example">
	<ul class="pagination">
		<c:if test="${requestScope.bookmarkPagin.previousPageGroup}">
			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${requestScope.bookmarkPagin.startPageOfPageGroup-1}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
			</a></li>
		</c:if>

		<c:forEach begin="${requestScope.bookmarkPagin.startPageOfPageGroup}" end="${requestScope.bookmarkPagin.endPageOfPageGroup}" var="bmPagin">
			<c:choose>
				<c:when test="${requestScope.bookmarkPagin.nowPage == bmPagin}">
					<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${bmPagin}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기">${bmPagin}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${bmPagin}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기">${bmPagin}</a></li>
				</c:otherwise>
			</c:choose>

		</c:forEach>

		<c:if test="${requestScope.bookmarkPagin.nextPageGroup}">
			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${requestScope.bookmarkPagin.endPageOfPageGroup+1}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기" "
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a></li>
		</c:if>
	</ul>
</nav>