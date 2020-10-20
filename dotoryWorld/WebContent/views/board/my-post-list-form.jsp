<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
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
<!-- 게시물 검색-->
<div class="row searchPost">
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<input type="hidden" name="searchFiled" value="${postVO.searchFiled }" />
	<input type="hidden" name="searchValue" value="${postVO.searchValue }" />
	<form action="post-search-list.jsp" method="post">
		<div class="container2">
			<div class="form-group row justify-content-center">
				<input type="hidden" name="searchflag" onkeyup="searchFunction()"
					value="true"> &emsp;&emsp; <select name="keyField">
					<option value="title">제목</option>
				</select>&emsp;
				<div class="w300" style="padding-right: 10px">
					<input type="text" class="form-control" name="keyWord" id="keyWord">
				</div>
            <button class="btn btn-primary" type="button" id="btnSearch"
               onclick="searchFunction()">
               검색<span class="glyphicon glyphicon-search"> </span>
            </button>
            <hr>
         </div>
      </div>
   </form>
   &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
   &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
</div>
<!-- 게시글 리스트가 나열되는 부분 -->
<div class="row boardMain">
<div class="col-sm-1"></div><!-- 빈공간 -->
<div class="col-sm-10">
<form action="${pageContext.request.contextPath}/front" id="myPostDeleteForm" onsubmit="return myPostDelete()">
	<table class="table table-bordered  table-hover boardlist">
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