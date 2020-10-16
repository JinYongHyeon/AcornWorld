<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- controller 작동을 위해 임시로 만든 버튼 -->
<form action="${pageContext.request.contextPath}/front">
	<input type="hidden" name="command" value="postList">
	<input type="hidden" name="hobbyBoardNo" value="1">
	<input type="submit" value="1번 게시판">
</form>
<form action="${pageContext.request.contextPath}/front">
	<input type="hidden" name="command" value="postList">
	<input type="hidden" name="hobbyBoardNo" value="2">
	<input type="submit" value="2번 게시판">
</form>
</body>
</html>