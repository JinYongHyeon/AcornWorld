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
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/myHomecss.css">
</head>
<body>
<!-- 
	프로필 이미지 등록 뷰
 -->
<input type="hidden" id="path" value="${pageContext.request.contextPath}">
	<div class="row" id="toryProfileImgForm">
		<div class="col-sm-8 offset-2">

			<div id="toryProfileImgTilte">
				<h1>프로필 사진 선택</h1>
			</div>
			<div id="toryProfileImgMainForm">
				<div class="toryProfileImg">
					<svg width="100px" height="100px" style="color: #999"
						viewBox="0 0 16 16" class="bi bi-images" fill="currentColor"
						xmlns="http://www.w3.org/2000/svg">
					  <path fill-rule="evenodd"
							d="M12.002 4h-10a1 1 0 0 0-1 1v8l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71a.5.5 0 0 1 .577-.094l1.777 1.947V5a1 1 0 0 0-1-1zm-10-1a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V5a2 2 0 0 0-2-2h-10zm4 4.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z" />
					  <path fill-rule="evenodd"
							d="M4 2h10a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1v1a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2h1a1 1 0 0 1 1-1z" />
					</svg>
				</div>
				<div class="toryProfileText">
					<h1>프로필 사진을 여기에 업로드해주세요.</h1>
				</div>
				<div class="toryProfileUpload">
					<form id="profileUploadForm" enctype="multipart/form-data">
						<input type="hidden" name="id" value="test">
						<input type="file" name="profileImg" id="profileImg"
							accept="image/*" onchange="profileFileSee()"> <input
							type="button" value="등록">
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 
	 	미니홈피 -> 프로필 보기(사진 + 소개글 + 닉네임) -> 수정하기(완료) -> 프로필 보기;
		프로필 닉네임 소개글 수정 뷰
	 -->
	 <h1>회원정보 수정</h1>
		<div class="col-sm-8 offset-2">
			<form action="${pageContext.request.contextPath}/front" method="post">
				<input type="hidden" name="command" value="toryProfileUpdate">
				<input type="hidden" name="id" value="${sessionScope.id}">
				<span>닉네임</span><input type="text" name="nickName" required="required" placeholder="닉네임을 입력해주세요.">
				<span>소개글</span><input type="text" name="profileContent" required="required" placeholder="소개글을 입력해주세요.">
				<input type="submit" value="프로필 수정">
			</form>
		</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		

	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/myHomejs.js"></script>
</body>
</html>