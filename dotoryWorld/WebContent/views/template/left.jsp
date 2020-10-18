<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<a href="${pageContext.request.contextPath}/front?command=registerMemberForm">회원가입</a>
		<br>
	</c:when>
	<c:otherwise>
		${sessionScope.mvo.name}님<br>
		<a href="${pageContext.request.contextPath}/front?command=logout">로그아웃</a>
		<br>
		<a href="${pageContext.request.contextPath}/front?command=updateMemberInfoForm">회원 정보 수정</a>
		<br>
		<a href="${pageContext.request.contextPath}/front?command=myPostList">내 게시물 조회</a>
	</c:otherwise>
</c:choose>