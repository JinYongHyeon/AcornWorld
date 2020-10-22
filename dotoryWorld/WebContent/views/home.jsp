<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="row">
	<div class="col-sm-6" id="boardListMain">
		<img src="${pageContext.request.contextPath}/resources/img/best_hobby.PNG" id="mainImage">

		<c:forEach items="${requestScope.bestList}" var="best">
			<form action="${pageContext.request.contextPath}/front" id="boardListMainForm">
				<input type="hidden" name="command" value="postList">
				<input type="hidden" name="hobbyBoardNo" value="${best.boardNo}">
				<img src="${pageContext.request.contextPath}/resources/img/${best.boardImage}"> <br>
				<input type="submit" value="${best.boardTitle}">
			</form>
		</c:forEach>
	</div>
	<div class="col-sm-6" id="boardListMain">
		<img src="${pageContext.request.contextPath}/resources/img/hot_hobby.PNG" id="mainImage">
		<c:forEach items="${requestScope.hotList}" var="hot">
			<form action="${pageContext.request.contextPath}/front" id="boardListMainForm">
				<input type="hidden" name="command" value="postList">
				<input type="hidden" name="hobbyBoardNo" value="${hot.boardNo }">
				<img src="${pageContext.request.contextPath}/resources/img/${hot.boardImage}"> <br>
				<input type="submit" value="${hot.boardTitle}">
			</form>
		</c:forEach>
	</div>
</div>