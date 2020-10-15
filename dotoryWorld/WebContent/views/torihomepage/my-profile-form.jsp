<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myHomecss.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="row">
		<div class="col-sm-8 offset-2" id="toryProfileForm">
			<table>
				<thead>
					<tr>
						<th colspan="2">프로필</th>
					</tr>
				</thead>
				<tr>
					<th>프로필 사진</th>
					<td><div class="toryProfileImg">
							<img
								src="${pageContext.request.contextPath}/resources/img/profile/profileDefualt.png">
						</div></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td>
						<div class="toryProfileNick">
							<span>네이마르</span>
						</div>
					</td>
				</tr>
				<tr>
					<th>소개글</th>
					<td><div class="toryProfileContent">
							<span>소개입니다. </span>
						</div></td>
				</tr>
			</table>
			<div>
				<a href="${pageContext.request.contextPath}">프로필 수정</a>
			</div>
		</div>

	</div>

</body>
</html>