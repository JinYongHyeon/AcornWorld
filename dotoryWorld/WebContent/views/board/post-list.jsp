<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- <script type="text/javascript">
   $(document).ready(function() {
      $(document).on('click', '#btnSearch', function(e) {
         e.preventDefault();
         var url = "${pageContext.request.contextPath}/board/post-list";
         url = url + "?searchType=" + $('#searchType').val();
         url = url + "&keyword=" + $('#keyword').val();
         location.href = url;
         console.log(url);
      });
   }); 
</script>
-->
<style>
tr:hover {background-color:#E4F7BA;}
</style>
<!-- 게시물 검색-->
<div class="row searchPost" id=searchResultForm>
	
	<!-- <form action="post-search-list.jsp" method="post"> -->
	<form action="${pageContext.request.contextPath }/front" id="boardTable" onsubmit="return searchTextCheck()">
	<input type="hidden" name="command" value="searchPost">
	<input type="hidden" name="hobbyBoardNo" value="${requestScope.hobbyBoardNo}">

			<div class="form-group row" style= "margin-left:510px">
				 <select name="keyField">
					<option value="title">제목</option>
				</select>&emsp;
				<div class="w300">
					<input type="text" class="form-control" name="keyword" id="keyWord" size="25">
				</div>
            &emsp;<input type="submit" value="검색" >
            <hr>
         </div>
   </form>

</div>
<!-- 게시글 리스트가 나열되는 부분 -->
<div class="row boardMain">
<div class="col-sm-1"></div><!-- 빈공간 -->
<div class="col-sm-10">
<form id="boardTable" >
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
	<!-- 공지게시물 노출 -->
		<c:forEach var="pvo" items="${requestScope.noticeListPaging.list}">
			<tr bgcolor="#F3F781">
				<td>${pvo.postNo }</td>
				<td>
					<c:choose>
						<c:when test="${sessionScope.mvo!=null}">
							<a href="${pageContext.request.contextPath}/front?command=postDetail&no=${pvo.postNo}">${pvo.postTitle }</a>
						</c:when>
						<c:otherwise>
							${pvo.postTitle }
						</c:otherwise> 
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${sessionScope.mvo!=null}">
							<a href="${pageContext.request.contextPath}/front?command=toryHome&id=${pvo.memberVO.id }">${pvo.memberVO.id }</a>
						</c:when>
						<c:otherwise>
						${pvo.memberVO.id }
						</c:otherwise>
					</c:choose>
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
					<!-- 로그인 상태에는 글을 읽을 수 있다. -->
					<c:choose>
						<c:when test="${sessionScope.mvo!=null}">
							<c:choose>
								<c:when test="${requestScope.hobbyBoardNo == 18 }">
									<c:choose>
										<c:when test="${sessionScope.mvo.id == pvo.memberVO.id || sessionScope.mvo.grade == '다람쥐' }">
												<a href="${pageContext.request.contextPath}/front?command=postDetail&no=${pvo.postNo }">${pvo.postTitle }</a>
										</c:when>
										<c:otherwise>
											${pvo.postTitle } <!-- 18번 게시판에서는 글 작성자만 글을 읽을 수 있다. -->
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<a href="${pageContext.request.contextPath}/front?command=postDetail&no=${pvo.postNo }">${pvo.postTitle }</a>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							${pvo.postTitle } <!-- 비 로그인 상태에는 글을 읽을 수 없다. -->
						</c:otherwise> 
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${sessionScope.mvo!=null}">
							<a href="${pageContext.request.contextPath}/front?command=toryHome&id=${pvo.memberVO.id }">${pvo.memberVO.id }</a>
						</c:when>
						<c:otherwise>${pvo.memberVO.id }</c:otherwise>
					</c:choose>					
				</td>
				<td>${pvo.postDate }</td>				
				<td>${pvo.viewCount }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form>
<!-- 17번 게시판일 경우 다람쥐만 글 쓰기 버튼이 보인다. -->
<!-- 17번 게시판이 아닌 경우 다람쥐와 도토리 모두에게 글쓰기 버튼이 보인다. -->
<c:choose>
	<c:when test="${requestScope.hobbyBoardNo == 17}">
		<c:if test="${sessionScope.mvo.grade == '다람쥐'}">
			<form action="${pageContext.request.contextPath}/front">
				<input type="hidden" name="command" value="postWriteForm">
				<input type="hidden" name="boardNo" value="${requestScope.hobbyBoardNo}">
				<div id="write_button">
					<input type="submit" value="글쓰기">
				</div>
			</form>
		</c:if>
	</c:when>
	<c:otherwise>
		<c:if test="${sessionScope.mvo.grade != null}">
			<form action="${pageContext.request.contextPath}/front">
				<input type="hidden" name="command" value="postWriteForm">
				<input type="hidden" name="boardNo" value="${requestScope.hobbyBoardNo}">
				<div id="write_button">
					<input type="submit" value="글쓰기">
				</div>
			</form>
		</c:if>
	</c:otherwise>
</c:choose>


<!-- 17번 게시판에서 다람쥐에게만 보이는 버튼이다. -->
<c:if test="${requestScope.boardNo == 17 && sessionScope.postingListPaging.list.grade == '다람쥐'}">
<form action="${pageContext.request.contextPath}/front">
	<input type="hidden" name="command" value="postWriteForm">
	<input type="hidden" name="boardNo" value="${requestScope.hobbyBoardNo}">
	<div id="write_button">
		<input type="submit" value="글쓰기">
	</div>
</form>
</c:if>
<%-- paging 처리 --%>
<c:set var="pb" value="${requestScope.postingListPaging.pagingBean}"/>
<c:if test="${requestScope.postingListPaging==null}">
<c:set var="pb" value="${requestScope.noticeListPaging.pagingBean}"/>
</c:if>
<div class="pagingArea">
	<ul class="pagination">
		<c:if test="${pb.previousPageGroup}">
			<li class="page-item">
				<a href="front?command=postList&pageNo=${pb.startPageOfPageGroup-1}&hobbyBoardNo=${requestScope.hobbyBoardNo}&keyword=${requestScope.keyword}"
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
				<a href="front?command=postList&pageNo=${pb.endPageOfPageGroup+1}&hobbyBoardNo=${requestScope.hobbyBoardNo}&keyword=${requestScope.keyword}"
				class="page-link">&raquo;</a>
			</li>
		</c:if>
	</ul>
</div> <!-- pagingArea -->
</div> <!-- col-sm-10 -->
</div> <!-- row boardMain -->