<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
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
<table class="table">
	<tr>
		<td>글번호 ${requestScope.pvo.postNo }</td>
		<td>제목: ${requestScope.pvo.postTitle}</td>
		<td>작성자 : ${requestScope.pvo.memberVO.name }</td>
		<td>조회수 : ${requestScope.pvo.viewCount }</td>
		<td>${requestScope.pvo.postDate }</td>
	</tr>
	<tr>
		<td colspan="5"><pre>${requestScope.pvo.postContent}</pre></td>
	</tr>
	<%-- <c:if test="${requestScope.pvo.memberVO.id==sessionScope.mvo.id}"> --%>
		<tr>
			<td colspan="5" class="btnArea">
				<form name="deleteForm"
					action="${pageContext.request.contextPath}/front" method="post">
					<input type="hidden" name="command" value="reportPostRemove">
					<input type="hidden" name="no" value="${requestScope.pvo.postNo}">
				</form>				
				<form name="updateForm"
					action="${pageContext.request.contextPath}/front" method="post">
					<input type="hidden" name="command" value="reportPostUpdateForm">
					<input type="hidden" name="no" value="${requestScope.pvo.postNo}">
				</form>
				<button type="button" class="btn" onclick="deletePost()">삭제</button>
				<button type="button" class="btn" onclick="updatePost()">수정</button>
			</td>
		</tr>
	<%-- </c:if> --%>
</table>
</body>
</html>