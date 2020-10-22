<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="row" id="favoriteList">
	<div class="col-sm-12">
		<ul>
			<c:forEach items="${requestScope.bookmarkList}" var="mark">
				<li>
					<form action="${pageContext.request.contextPath}/front"
						id="favoriteForm">
						<a href="${pageContext.request.contextPath}/front?command=postList&hobbyBoardNo=${mark.bookmarkLink}"><img
							src="${pageContext.request.contextPath}/resources/img/${mark.boardVO.boardImage}"></a>
						<input type="button" value="${mark.boardVO.boardTitle}"
							onclick="location.href='${pageContext.request.contextPath}/front?command=postList&hobbyBoardNo=${mark.bookmarkLink}'">
					</form>
				</li>
			</c:forEach>
		</ul>
		</div>
		</div>
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<c:if test="${requestScope.bookmarkPagin.previousPageGroup}">
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${requestScope.bookmarkPagin.startPageOfPageGroup-1}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
				</c:if>

				<c:forEach
					begin="${requestScope.bookmarkPagin.startPageOfPageGroup}"
					end="${requestScope.bookmarkPagin.endPageOfPageGroup}"
					var="bmPagin">
					<c:choose>
						<c:when test="${requestScope.bookmarkPagin.nowPage == bmPagin}">
							<li class="page-item active"><a class="page-link"
								href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${bmPagin}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기">${bmPagin}</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item"><a class="page-link"
								href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${bmPagin}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기">${bmPagin}</a></li>
						</c:otherwise>
					</c:choose>

				</c:forEach>

				<c:if test="${requestScope.bookmarkPagin.nextPageGroup}">
					<li class="page-item"><a class="page-link"
						href="${pageContext.request.contextPath}/front?command=favoritesList&nowPage=${requestScope.bookmarkPagin.endPageOfPageGroup+1}&id=${sessionScope.mvo.id}&bookmark=즐겨찾기"
						"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</c:if>
			</ul>
		</nav>