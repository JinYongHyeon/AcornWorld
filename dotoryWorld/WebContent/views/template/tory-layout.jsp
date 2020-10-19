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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/toryHome.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
	background-image:
		url(${pageContext.request.contextPath}/resources/img/bgPattern.png);
}
</style>
</head>
<body>

	<div class="row" id="toryHomeForm">

		<div class="col-sm-3" id="toryHomeLeftForm">
			<div id="toryHomeRing">
				<ul>
					<li></li>
					<li></li>
					<li></li>
					<li></li>
				</ul>
			</div>
			<div class="toryHomeIcon">
				<a href="${pageContext.request.contextPath}/front?command=main"><img
					src="${pageContext.request.contextPath}/resources/img/main_logo2.png"
					alt="아이콘"></a>
			</div>
			<div class="toryHomeLeft">
				<div class="toryHomeLeftProfileImg">
					<c:choose>
						<c:when
							test="${requestScope.toryHomeImformation.profilePhoto == null}">
							<img
								src="${pageContext.request.contextPath}/resources/img/profileDefualt.png">
						</c:when>
						<c:otherwise>
							<img
								src="${pageContext.request.contextPath}/resources/img/profile/${requestScope.toryHomeImformation.profilePhoto}">
						</c:otherwise>
					</c:choose>
				</div>
				<div class="toryHomeLeftProfileContent">
					<h3>${requestScope.toryHomeImformation.profileContent}</h3>
				</div>
				<div class="toryHomeLeftNickName">
					<c:if
						test="${sessionScope.mvo.id != requestScope.toryHomeImformation.id}">
						<p>
							<a href="#" id="addDotory">친구추가</a>
						</p>
					</c:if>
					<p>${requestScope.toryHomeImformation.id}</p>
					<p>${requestScope.toryHomeImformation.email}</p>
				</div>
			</div>
		</div>
		<div class="col-sm-9" id="toryHomeRightForm">
			<div class="toryHomeNickTitle">
				<h2>${requestScope.toryHomeImformation.nickname}님의토리홈피</h2>
			</div>
			<div class="toryHomeRight">
				<jsp:include page="${requestScope.url}"></jsp:include>
			</div>
			<div class="toryHomeNav">
				<ul>
					<li><a href="#">방명록</a></li>
					<li><a href="#">사진첩</a></li>
					<li><a href="#">다이어리</a></li>
					<c:if
						test="${sessionScope.mvo.id == requestScope.toryHomeImformation.id}">
						<li><a
							href="${pageContext.request.contextPath}/front?command=toryProfileForm">내
								프로필</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var xhr;
		$(document)
				.ready(
						function() {

							/*도토리(친구)추가 이벤트*/
							$(document)
									.on(
											"click",
											"#addDotory",
											function() {
												if (confirm("${requestScope.toryHomeImformation.id}님 과 친구추가 하시겠습니까?")) {//미니홈페이지 주인 아이디 들어가야됨.
													var id = "${sessionScope.mvo.id}";
													var friendId = "${requestScope.toryHomeImformation.id}";
													//ajax 통신을 위한 자바스크립트 객체
													xhr = new XMLHttpRequest();
													//readystate가 변화될 때 호출 -> 우측 익명함수로 해도 됨.
													xhr.onreadystatechange = callback;
													//요청 메서드방식과 처리할 서버 프로그램  url
													xhr
															.open("post",
																	"${pageContext.request.contextPath}/front");
													//javascript ajax post 방식일 때 content type을 지정해야 한다.
													xhr
															.setRequestHeader(
																	"Content-Type",
																	"application/x-www-form-urlencoded");
													//post방식일 때 값 여기다 넣음, get일 때는 null로 보내주면 됨.
													xhr
															.send("command=addDotory&id="
																	+ id
																	+ "&friendId="
																	+ friendId);
													//location.href="${pageContext.request.contextPath}/front?command=addDotory"
												}
											});
						});
		function callback() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				alert(xhr.responseText);
			}
		}
	</script>
</body>
</html>