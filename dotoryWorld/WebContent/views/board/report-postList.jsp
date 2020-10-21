<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<table class="table table-bordered  table-hover boardlist">
	<thead>
		<tr class="success">
			<th>번호</th>
			<th class="title">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="pvo" items="${requestScope.lvo.list}">
			<tr>
				<td>${pvo.postNo}</td>
				<td>
					<c:choose>
						<c:when test="${sessionScope.mvo!=null}">
							<a href="${pageContext.request.contextPath}/front?command=reportPostDetail&no=${pvo.postNo}">${pvo.postTitle}</a>
						</c:when>
						<c:otherwise>
								${pvo.postTitle }
						</c:otherwise>
					</c:choose>
				</td>
				<td>${pvo.memberVO.name }</td>
				<td>${pvo.postDate }</td>
				<td>${pvo.viewCount }</td>
			</tr>
		</c:forEach>
		<tr>
			<td> <input type = "submit" value="글쓰기" > </td>
		</tr>
	</tbody>
</table>

<%-- paging 처리  --%>
<c:set var="pb" value="${requestScope.lvo.pagingBean}" />
<div class="pagingArea">
<ul class="pagination">
<c:if test="${pb.previousPageGroup}">
	<li>
		<a href="front?command=List&pageNo=${pb.startPageOfPageGroup-1}&hobbyBoardNo=${requestScope.hobbyBoardNo}">&laquo;</a>
	</li>
</c:if>
<c:forEach var="i" begin="${pb.startPageOfPageGroup}" 
end="${pb.endPageOfPageGroup}">
<c:choose>
	<c:when test="${pb.nowPage!=i}">
		<li><a href="front?command=List&pageNo=${i}&hobbyBoardNo=${requestScope.hobbyBoardNo}">${i}</a></li>
	</c:when>
	<c:otherwise>
		<li class="active"><a href="#">${i}</a></li>
	</c:otherwise>
</c:choose>
</c:forEach>
<c:if test="${pb.nextPageGroup}">
	<li>
		<a href="front?command=List&pageNo=${pb.endPageOfPageGroup+1}&hobbyBoardNo=${requestScope.hobbyBoardNo}">&raquo;</a>
	</li>
</c:if>
</ul>
</div> 



</body>
</html>