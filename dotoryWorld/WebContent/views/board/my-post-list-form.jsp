<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
tr:hover {background-color:#E4F7BA;}
</style>
<!-- 게시물 검색-->
<h2><img src="resources/img/myPost.png" width="500px" height="70px"></h2>

<form action="${pageContext.request.contextPath }/front" id="boardTable">
	<input type="hidden" name="command" value="searchPost">
			<div class="form-group row"  style= "margin-left:670px">
				 <select name="keyField">
					<option value="title">제목</option>
					<option value="id">작성자</option>
				</select>&emsp;
	<input type="text" name="keyword" size="20">
            &emsp;<input type="submit" value="검색">
            </div>
            <hr>
   </form>
<!-- 게시글 리스트가 나열되는 부분 -->
<div class="row boardMain">
<div class="col-sm-1"></div><!-- 빈공간 -->
<div class="col-sm-10">
<form action="${pageContext.request.contextPath}/front" id="boardTable" onsubmit="return myPostDelete()">
	<table class="table table-bordered  table-hover boardlist" bgcolor="white">
	<thead>
		<tr class="success">
			<th></th>
			<th>번호</th>
			<th class="title">제목</th>
			<th>게시판</th>
			<th>작성일</th>
			<th>조회</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="pvo" items="${requestScope.lvo.list}">
			<tr>
				<td>
					<input type="hidden" name="command" value="myPostDelete">
					<input type="checkbox" name="deletePost" value="${pvo.postNo }"> <!-- 추후 복수 삭제를 위해 추가? -->
				</td>
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
				<td>${pvo.boardVO.boardTitle }</td>
				<td>${pvo.postDate }</td>				
				<td>${pvo.viewCount }</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="6">
				<input type="submit" value="삭제">
		<tr>
	</tbody>
</table>
</form>
<%-- paging 처리 --%>
<c:set var="pb" value="${requestScope.lvo.pagingBean}"/>
<div class="pagingArea">
	<ul class="pagination">
		<c:if test="${pb.previousPageGroup}">
			<li>
				<a href="front?command=postList&pageNo=${pb.startPageOfPageGroup-1}&hobbyBoardNo=${requestScope.hobbyBoardNo}">&laquo;</a>
			</li>
		</c:if>
		<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${i != pb.nowPage}">
					<li><a href="front?command=postList&pageNo=${i}&hobbyBoardNo=${requestScope.hobbyBoardNo}">${i}</a></li>
				</c:when>
				<c:otherwise>
					<li class="active"><a href="#">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pb.nextPageGroup}">
			<li>
				<a href="front?command=postList&pageNo=${pb.endPageOfPageGroup+1}&hobbyBoardNo=${requestScope.hobbyBoardNo}">&raquo;</a>
			</li>
		</c:if>
	</ul>
</div> <!-- pagingArea -->
</div> <!-- col-sm-10 -->
</div> <!-- row boardMain -->