<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>도토리 월드</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myHomecss.css" />
</head>
<body>
	<c:choose>
		<c:when test="${sessionScope.mvo==null}">
			<h2>
				<b>LOGIN</b>
			</h2>
			<form method="post" action="${pageContext.request.contextPath}/front">
				<input type="hidden" name="command" value="login">
				<div class="form-group">
					<input type="text" id="id" placeholder="Enter id" name="id"
						required="required">
				</div>
				<div class="form-group">
					<input type="password" id="password" placeholder="Enter password"
						name="password" required="required">
				</div>
				<input type="submit" value="로그인"> 
				<input type="button" value="회원가입" onclick="location.href = '${pageContext.request.contextPath}/front?command=registerMemberForm'">
			</form>
			<br>
		</c:when>
		<c:otherwise>

		<img src="resources/img/profileDefualt.png">
		${sessionScope.mvo.name}님<br><br>
			<input type="button" value="로그아웃" onclick="location.href = '${pageContext.request.contextPath}/front?command=logout'">
			<input type="button" value="회원정보수정" onclick="location.href = '${pageContext.request.contextPath}/front?command=updateMemberInfoForm'">

		${sessionScope.mvo.name}님<br>
			<a href="${pageContext.request.contextPath}/front?command=logout">로그아웃</a>
			<br>
			<a href="${pageContext.request.contextPath}/front?command=updateMemberInfoForm">회원 정보 수정</a>
			<br>
			<a href="${pageContext.request.contextPath}/front?command=myPostList">내 게시물 조회</a>

		</c:otherwise>
	</c:choose>
	<c:if test="${sessionScope.mvo != null}">
	<br>
	<input type="button" value="내 미니홈피 가기" onclick="location.href = '${pageContext.request.contextPath}/front?command=toryHome&id=${sessionScope.mvo.id}'">
	<c:if test="${sessionScope.mvo.grade == '다람쥐'}">
		<input type="button" value="관리자 페이지" onclick="location.href = '	${pageContext.request.contextPath}/front?command=adminManage'">
	</c:if>
</c:if>
</body>
</html>
