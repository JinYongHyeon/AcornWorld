<%@page import="org.dotoryWorld.model.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	<div align="center">
		<h2><img src="resources/img/도토리.png" width="250px" height="70px"></h2>
		<form action="${pageContext.request.contextPath}/front" id="boardTable">
		<input type="hidden" name="command" value="deleteMyDotory">
			<table>
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
				<div><input type="submit" onclick="return friendDelete()" value="  도토리 삭제  ">&emsp;&emsp;</div>
				<!-- submit을 하면 js로 가서 함수를 실행시킴.
				true를 반환받으면 form이 명시한 front로 가고,
				false를 반환받으면 그대로 작동을 멈춘다.(페이지에 머무른다.) -->
		</form>
	</div>
