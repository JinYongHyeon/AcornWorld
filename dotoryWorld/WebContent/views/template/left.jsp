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

<style>
input[type=text], input[type=password] {
	border: 2px solid #F57F17;
	border-radius: 5px;
}

input[type=submit], input[type=button] {
	border: 2px solid #F57F17;
	border-radius: 5px;
	background-color: #F57F17;
	color: white;
}
</style>
<script type="text/javascript">
	function enjoy() {
		location.href = "${pageContext.request.contextPath}/front?command=registerMemberForm";
	}
</script>
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
				<input type="submit" value="로그인"> <input type="button"
					value="회원가입" onclick="enjoy()">
			</form>
			<br>
		</c:when>
		<c:otherwise>
		${sessionScope.mvo.name}님<br>
			<a href="${pageContext.request.contextPath}/front?command=logout">로그아웃</a>
			<br>
			<a
				href="${pageContext.request.contextPath}/front?command=updateMemberInfoForm">회원
				정보 수정</a>
		</c:otherwise>
	</c:choose>
</body>
</html>