<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	function sendList() {
		location.href = "${pageContext.request.contextPath}/index.jsp";
	}
	function deletePost() {
		if (confirm("게시글을 삭제하시겠습니까?")) {
			document.deleteForm.submit();
		}
	}
	function updatePost() {
		if (confirm("게시글을 수정하시겠습니까?")) {
			document.updateForm.submit();
		}
	}
</script>
<div class="row postDetailForm">
	<div class="col-sm-1"></div>
	<div class="col-sm-10">
		<table class="table">
			<tr>
				<td>글번호 ${requestScope.pvo.postNo }</td>
				<td>제목: ${requestScope.pvo.postTitle}</td>
				<td>작성자 : ${requestScope.pvo.memberVO.name }</td>
				<td>조회수 : ${requestScope.pvo.viewCount }</td>
			</tr>
			<tr>
				<td colspan="5"><pre>${requestScope.pvo.postContent}</pre></td>
			</tr>
			<c:if test="${requestScope.pvo.memberVO.id==sessionScope.mvo.id}">
				<tr>
					<td colspan="5" class="btnArea">
						<form name="deleteForm"
							action="${pageContext.request.contextPath}/front" method="post">
							<input type="hidden" name="command" value="postRemove"> <input
								type="hidden" name="no" value="${requestScope.pvo.postNo}">
						</form>				
						<form name="updateForm"
							action="${pageContext.request.contextPath}/front" method="post">
							<input type="hidden" name="command" value="postUpdateForm"> <input
								type="hidden" name="no" value="${requestScope.pvo.postNo}">
						</form>
						<button type="button" class="btn" onclick="deletePost()">삭제</button>
						<button type="button" class="btn" onclick="updatePost()">수정</button>
					</td>
				</tr>
			</c:if>
		</table>
	</div> <!-- col-sm-10 -->
</div> <!-- row postDetailForm -->