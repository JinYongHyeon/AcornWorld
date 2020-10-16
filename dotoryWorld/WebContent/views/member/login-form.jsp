<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
		<c:choose>
	<c:when test="${sessionScope.memberVO==null}">
	<form method="post" action="${pageContext.request.contextPath}/front">
	<input type="hidden" name="command" value="login">
	    <input type="text" name="id"   placeholder="아이디"> 
	   <input type="password" name="password"  placeholder="비밀번호">
	    <input type="submit" value="로그인">
	</form>
	</c:when>
	<c:otherwise>
	<a href="${pageContext.request.contextPath}/index.jsp">홈</a>&nbsp;&nbsp;
	<a href="${pageContext.request.contextPath}/front?command=WritePostForm">글쓰기</a>&nbsp;&nbsp; 
	 ${sessionScope.memberVO.name}님 &nbsp;&nbsp; 
	 <a href="javascript:logout()">로그아웃</a>
	</c:otherwise>
	</c:choose>
</body>
</html>