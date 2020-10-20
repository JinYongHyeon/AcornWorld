<%@page import="org.dotoryWorld.model.MemberVO"%>
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
<script type="text/javascript">
function friendDelete() {
	var no = document.getElementsByName("friendNo");
	var friendDeleteForm = document.getElementById("deleteMyDotory");
	var flag = false;
	for (var i = 0; i < no.length; i++) {
		if(no[i].checked === true) {
			flag = true;
			break;
		}
	}
	if (flag === false) {
		alert("체크박스를 체크해주세요");
		return flag;
	}
}
</script>
<style>
 /* #container {width: 960px; margin: 0 auto;}
        #container #input-form {text-align: center;}
        #user-table {margin: 0 auto; text-align: center;}
        #input-form {margin-top: 10px; margin-bottom: 10px;}

        #user-table > thead > tr { background-color: #333; color:#fff; }
        #user-table > thead > tr > th { padding: 8px; width: 150px; }
        #user-table > tbody > tr > td { border-bottom: 1px solid gray; padding:8px; } */
  table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  padding: 6px;
  text-align: center;
  border-bottom: 1px solid #ddd;
  
}
th {
  background-color: #FFBB00;
  color: white;
}
}
h2 {
  border-style: solid;
  border-color: coral;
}
body {
 
}
#example1 {
  border: 2px solid #FFBB00;
  padding: 25px;
  background-size: auto;
  background-color: white;
}
tr:hover {background-color:#E4F7BA;}
</style>
</head>
<body>
	
	<div align="center" id="example1" style="padding-top: 10px;">
		<h2><img src="resources/img/도토리.png" width="250px" height="70px"></h2>
		<form action="${pageContext.request.contextPath}/front">
		<input type="hidden" name="command" value="deleteMyDotory">
			<table border="1">
				<tr>
					<th> &emsp;&emsp;&emsp; 도토리 ID  &emsp;&emsp;&emsp;</th>
					<th>선택</th>
					<!-- <th>&emsp; grade&emsp; </th>
					<th> &emsp;name&emsp; </th>
					<th>&emsp; email &emsp;</th> -->
				</tr>
				<c:forEach items="${requestScope.myDotoryList}" var="friend">
				<tr>
					<td><a href="${pageContext.request.contextPath}/front?command=toryHome&id=${friend.id}">${friend.id}</a></td>
					<%-- <td>${friend.grade}</td>
					<td>${friend.name}</td>
					<td>${friend.email}</td> --%>
					<td>
				&emsp;<input type="checkbox" name="friendNo" value="${friend.id}"></td>
				</tr>
				</c:forEach>
			</table>
				<br>
				<div align="right"><input type="submit" onclick="return friendDelete()" value="  도토리 삭제  "></div>
				<!-- submit을 하면 js로 가서 함수를 실행시킴.
				true를 반환받으면 form이 명시한 front로 가고,
				false를 반환받으면 그대로 작동을 멈춘다.(페이지에 머무른다.) -->
		</form>
	</div>
</body>
</html>






