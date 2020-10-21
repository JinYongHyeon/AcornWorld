<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- 게시물 검색-->
<div class="row searchPost" id=searchResultForm>
	
	<!-- <form action="post-search-list.jsp" method="post"> -->
	<form action="${pageContext.request.contextPath }/front" id="boardTable">
	<input type="hidden" name="command" value="searchPost">
			<div class="form-group row">
				 <select name="keyField">
					<option value="title">제목</option>
					<option value="id">작성자</option>
				</select>&emsp;
				<div class="w300">
					<input type="text" class="form-control" name="keyword" id="keyWord" size="25">
					
				</div>
            &emsp;<input type="submit" value="검색">
            <hr>
         </div>
   </form>

</div>
<!-- 게시글 리스트가 나열되는 부분 -->
<div class="row boardMain">
<div class="col-sm-1"></div><!-- 빈공간 -->
<div class="col-sm-10">
<form id="boardTable" >
	<table class="table table-bordered  table-hover boardlist" bgcolor="white">
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
	<!-- 공지게시물 노출 -->
		<c:forEach var="pvo" items="${requestScope.noticeListPaging.list}">
			<tr>
				<td>${pvo.postNo }</td>
				<td>
					<c:choose>
						<c:when test="${sessionScope.mvo!=null}">
							<a href="${pageContext.request.contextPath}/front?command=postDetail&no=${pvo.postNo }">${pvo.postTitle }</a>
						</c:when>
						<c:otherwise>
							${pvo.postTitle }
						</c:otherwise> 
					</c:choose>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/front?command=toryHome&id=${pvo.memberVO.id }">${pvo.memberVO.id }</a>
				</td>
				<td>${pvo.postDate }</td>				
				<td>${pvo.viewCount }</td>
			</tr>
		</c:forEach>
	<!-- 일반게시물 노출 -->
		<c:forEach var="pvo" items="${requestScope.postingListPaging.list}">
			<tr>
				<td>${pvo.postNo }</td>
				<td>
					<c:choose>
						<c:when test="${sessionScope.mvo!=null}">
							<a href="${pageContext.request.contextPath}/front?command=postDetail&no=${pvo.postNo }">${pvo.postTitle }</a>
						</c:when>
						<c:otherwise>
							${pvo.postTitle }
						</c:otherwise> 
					</c:choose>
				</td>
				<td>
					<a href="${pageContext.request.contextPath}/front?command=toryHome&id=${pvo.memberVO.id }">${pvo.memberVO.id }</a>
					
				</td>
				<td>${pvo.postDate }</td>				
				<td>${pvo.viewCount }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form>
	<form action="${pageContext.request.contextPath}/front">
		<input type="hidden" name="command" value="postWriteForm">
		<input type="hidden" name="boardNo" value="${requestScope.hobbyBoardNo}">
		<div id="write_button">
		<input type="submit" value="글쓰기">
		</div>
	</form>
<%-- paging 처리 --%>
<c:set var="pb" value="${requestScope.postingListPaging.pagingBean}"/>
<c:if test="${requestScope.postingListPaging==null}">
<c:set var="pb" value="${requestScope.noticeListPaging.pagingBean}"/>
</c:if>
<div class="pagingArea">
	<ul class="pagination">
		<c:if test="${pb.previousPageGroup}">
			<li class="page-item">
				<a href="front?command=postList&pageNo=${pb.startPageOfPageGroup-1}&hobbyBoardNo=${requestScope.hobbyBoardNo}"
				class="page-link">&laquo;</a>
			</li>
		</c:if>
		<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${i != pb.nowPage}">
					<li class="page-item"><a href="front?command=postList&pageNo=${i}&hobbyBoardNo=${requestScope.hobbyBoardNo}&keyword=${requestScope.keyword}"
					class="page-link">${i}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item active"><a class="page-link" href="#">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pb.nextPageGroup}">
			<li class="page-item">
				<a href="front?command=postList&pageNo=${pb.endPageOfPageGroup+1}&hobbyBoardNo=${requestScope.hobbyBoardNo}"
				class="page-link">&raquo;</a>
			</li>
		</c:if>
	</ul>
</div> <!-- pagingArea -->
</div> <!-- col-sm-10 -->
</div> <!-- row boardMain -->