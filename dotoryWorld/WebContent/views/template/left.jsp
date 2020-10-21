<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			<input type="submit" value="로그인">&emsp;<input type="button"
				value="회원가입"
				onclick="location.href = '${pageContext.request.contextPath}/front?command=registerMemberForm'">
				<br>
		</form>
		<br>
	</c:when>
	<c:otherwise>
		<form id="leftForm">
			<c:choose>
				<c:when test="${sessionScope.mvo.profilePhoto==null}">
					<img
						src="${pageContext.request.contextPath}/resources/img/profileDefualt.png">
				</c:when>
				<c:otherwise>
					<img
						src="${pageContext.request.contextPath}/resources/img/profile/${sessionScope.mvo.profilePhoto}">
				</c:otherwise>
			</c:choose>
		</form>
		<h6><b>${sessionScope.mvo.name}님</b></h6>

		<input type="button" value="로그아웃"
			onclick="location.href = '${pageContext.request.contextPath}/front?command=logout'">&emsp;
		<input type="button" value="회원정보수정"
			onclick="location.href = '${pageContext.request.contextPath}/front?command=updateMemberInfoForm'">
			<br> <br>
		<input type="button" value="내 게시물 조회"
			onclick="location.href = '${pageContext.request.contextPath}/front?command=myPostList'">
	</c:otherwise>
</c:choose>
<c:if test="${sessionScope.mvo != null}">
	<hr>
	<input type="button" value="내 미니홈피 가기"
		onclick="location.href = '${pageContext.request.contextPath}/front?command=toryHome&id=${sessionScope.mvo.id}'">
		<hr>
	<input type="button" onclick="location.href='${pageContext.request.contextPath }/front?command=myDotoryList&id=${sessionScope.mvo.id}'" value="내 도토리 리스트">
		<br>
		<hr>

	<c:if test="${sessionScope.mvo.grade == '다람쥐'}">
		<input type="button" value="관리자 페이지"
			onclick="location.href = '	${pageContext.request.contextPath}/front?command=adminManage'">
	</c:if>
</c:if>