<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>my dotory list</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>도토리 월드</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/toryHome.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
 /* #container {width: 960px; margin: 0 auto;}
        #container #input-form {text-align: center;}
        #user-table {margin: 0 auto; text-align: center;}
        #input-form {margin-top: 10px; margin-bottom: 10px;}

        #user-table > thead > tr { background-color: #333; color:#fff; }
        #user-table > thead > tr > th { padding: 8px; width: 150px; }
        #user-table > tbody > tr > td { border-bottom: 1px solid gray; padding:8px; } */
  table, td, th {
  border: 2px solid #B77300;
    border-collapse: collapse;

}
h2 {
  border-style: solid;
  border-color: coral;
}
body {
  background-color: #FFFFD2;
}
#example1 {
  border: 2px solid black;
  padding: 25px;
  background-size: auto;
}
</style>
</head>
<body>
	
	<div align="center" id="example1" style="padding-top: 10px;">
		<h2 style="color:#FFBB00">My Dotory List</h2>
		<hr>
		<form action="">
			<table border="1">
				<tr>
					<th>&emsp; grade&emsp; </th>
					<th> &emsp;id &emsp;</th>
					<th> &emsp;name&emsp; </th>
					<th>&emsp; email &emsp;</th>
				</tr>
				<c:forEach items="${requestScope.myDotoryList}" var="friend">
				<tr>
					<td>${friend.grade}</td>
					<td>${friend.id}</td>
					<td>${friend.name}</td>
					<td>${friend.email}</td>
				</tr>
				</c:forEach>
				
			</table>
		</form>
	</div>
</body>
</html>






