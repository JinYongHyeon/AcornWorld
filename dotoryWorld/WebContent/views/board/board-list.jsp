<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myHomecss.css" >
</head>
<body>
<form id="categoryContent">
<c:choose>
	<c:when test="${requestScope.categoryNo==1}">
		<img src="${pageContext.request.contextPath}/resources/img/exercise.png">
		${requestScope.boardList[0].categoryVO.categoryContent}
	</c:when>
	<c:when test="${requestScope.categoryNo==2}">
		<img src="${pageContext.request.contextPath}/resources/img/cooking.png">
	</c:when>
	<c:when test="${requestScope.categoryNo==3}">
		<img src="${pageContext.request.contextPath}/resources/img/video-camera.png">
	</c:when>
	<c:when test="${requestScope.categoryNo==4}">
		<img src="${pageContext.request.contextPath}/resources/img/music-notes.png">
	</c:when>
</c:choose>
</form>
<br><br>
	<div class="container text-center">
		<div class="row" id="boardList">
		<div class="col-sm-12">
		<ul>
			<c:forEach items="${requestScope.boardList}" var="boardList">
			<li>	<form action="${pageContext.request.contextPath}/front"
					id="boardListForm">
					<input type="hidden" name="command" value="postList"> <input
						type="hidden" name="hobbyBoardNo" value="${boardList.boardNo}">
						<img src="${pageContext.request.contextPath}/resources/img/${boardList.boardImage}">
						<input type="submit" value="${boardList.boardTitle}"> <br><br> 
				</form></li>
			</c:forEach>
			</ul>
			</div>
		</div>
	</div>
</body>
</html>