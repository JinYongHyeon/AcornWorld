<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#btn_group button{
	border: 1px solid skyblue;
	background-color:rgba(0,0,0,0);
	color: skyblue;
	padding: 5px;
}
</style>
<c:choose>
	<c:when test="${sessionScope.mvo==null}">
		<form method="post" action="${pageContext.request.contextPath}/front">
			<input type="hidden" name="command" value="login">
			<div class="form-group">
				ID:<input type="text" id="id" placeholder="Enter id" name="id"
					required="required">
			</div>
			<div class="form-group">
				Password:<input type="password" id="password"
					placeholder="Enter password" name="password" required="required">
			</div>
			<input type="submit" value="Login">
		</form>
		<div id="btn_group">
		<button type="button" onclick="location.href='${pageContext.request.contextPath}/front?command=registerMemberForm'">회원가입</button>
		</div>
		<br>
	</c:when>
	<c:otherwise>
		${sessionScope.mvo.name}님<br>
		<a href="${pageContext.request.contextPath}/front?command=logout">로그아웃</a>
		<br>
		<a href="${pageContext.request.contextPath}/front?command=updateMemberInfoForm">회원 정보 수정</a>
		<div id="btn_group">
			 <button type="button" onclick="location.href='${pageContext.request.contextPath }/front?command=toryHome'">내 미니홈피 가기</button>
			 </div>
	</c:otherwise>
</c:choose>