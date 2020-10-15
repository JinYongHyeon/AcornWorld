<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>도토리 월드</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="/views/template/header.jsp"></jsp:include>
	<jsp:include page="${requestScope.url}"></jsp:include>
	<a href="${pageContext.request.contextPath}/front?command=registerMemberForm">회원가입</a>
	<a href="${pageContext.request.contextPath}/front?command=updateMemberInfoForm">회원 정보 수정</a>
	<jsp:include page="/views/template/right.jsp"></jsp:include>
	<jsp:include page="/views/template/footer.jsp"></jsp:include>
</body>
</html>