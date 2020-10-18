<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container text-center">
		<br>
		<div class="row">
			<div class="col-sm-6">
				<c:forEach items="${requestScope.boardList}" var="boardList">
					<form action="${pageContext.request.contextPath}/front">
						<input type="hidden" name="command" value="postList"> <input
							type="hidden" name="hobbyBoardNo" value="${boardList.boardNo}">
						<br>
						<c:choose>
							<c:when test="${boardList.boardNo==1}">
								<img src="resources/img/soccer.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==2}">
								<img src="resources/img/badminton.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==3}">
								<img src="resources/img/japan_food.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==4}">
								<img src="resources/img/italian_food.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==9}">
								<img src="resources/img/romance.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==10}">
								<img src="resources/img/thriller.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==13}">
								<img src="resources/img/dance.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==14}">
								<img src="resources/img/classic.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
						</c:choose>
					</form>
				</c:forEach>
			</div>
			<div class="col-sm-6">
				<c:forEach items="${requestScope.boardList}" var="boardList">
					<form action="${pageContext.request.contextPath}/front">
						<input type="hidden" name="command" value="postList"> <input
							type="hidden" name="hobbyBoardNo" value="${boardList.boardNo}">
						<br>
						<c:choose>
							<c:when test="${boardList.boardNo==5}">
								<img src="resources/img/basketball.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==6}">
								<img src="resources/img/baseball.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==7}">
								<img src="resources/img/chinese_food.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==8}">
								<img src="resources/img/korea_food.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==11}">
								<img src="resources/img/horror.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==12}">
								<img src="resources/img/action.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==15}">
								<img src="resources/img/ballad.png" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
							<c:when test="${boardList.boardNo==16}">
								<img src="resources/img/pop.jpg" class="img-responsive"
									style="width: 100%" alt="Image">
								<br>
								<input type="submit" value="${boardList.boardTitle}"
									style="WIDTH: 347pt;">
							</c:when>
						</c:choose>
					</form>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>