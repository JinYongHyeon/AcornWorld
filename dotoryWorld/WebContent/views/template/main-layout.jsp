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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/myHomejs.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myHomecss.css" />
</head>
<body>
		<div class="header">
			<jsp:include page="/views/template/header.jsp"></jsp:include>
		</div>
		<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-2 sidenav">
       <jsp:include page="/views/template/left.jsp"></jsp:include>
    </div>
    <div class="col-sm-8 main "> 
    	<jsp:include page="${requestScope.url}"></jsp:include>
    </div>
    <div class="col-sm-2 sidenav">
      <jsp:include page="/views/template/right.jsp"></jsp:include>
    </div>
  </div>
</div>
<div class="wrap">
	<footer class="container-fluid text-center">
  <jsp:include page="/views/template/footer.jsp"></jsp:include>
</footer>
</div>
</body>
</html>