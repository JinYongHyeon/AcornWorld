<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="row" id="boardList">
	<div class="col-sm-6">
		<img src="${pageContext.request.contextPath}/resources/img/best_hobby.PNG" id="mainImage">
		<form action="${pageContext.request.contextPath}/front"
			id="homeBoardList">
			<input type="hidden" name="command" value="postList"> 
			<input type="hidden" name="hobbyBoardNo" value="13">
			<img src="${pageContext.request.contextPath}/resources/img/dance.jpg">
			<br> <input type="submit" value="댄스"> <Br><Br>
			<input type="hidden" name="hobbyBoardNo" value="9">
			<img src="${pageContext.request.contextPath}/resources/img/romance.jpg">
			<br> <input type="submit" value="로맨스">
		</form>
	</div>
	<div class="col-sm-6">
		<img src="${pageContext.request.contextPath}/resources/img/hot_hobby.PNG" id="mainImage">
		<form action="${pageContext.request.contextPath}/front"
			id="homeBoardList">
			<input type="hidden" name="command" value="postList"> 
			<input type="hidden" name="hobbyBoardNo" value="8">
			<img src="${pageContext.request.contextPath}/resources/img/korea_food.jpg">
			<br> <input type="submit" value="한식"> <br><Br>
			<input type="hidden" name="hobbyBoardNo" value="5">
			<img src="${pageContext.request.contextPath}/resources/img/basketball.jpg">
			<br> <input type="submit" value="농구">
		</form>
	</div>
</div>