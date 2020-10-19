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
	<div class="container text-center">
		<div class="row">
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