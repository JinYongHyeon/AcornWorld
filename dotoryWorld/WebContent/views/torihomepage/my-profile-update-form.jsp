<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(document).ready(function(){

	//프로필 등록 이벤트
	$(document).on("click", ".toryProfileUploadButton #profileUploadBtn", function() {
		if (!profileFileCheck()) {
			return false;
		}
		var formData = new FormData($('#profileUploadForm')[0]);

		$.ajax({
			type: "post",
			enctype: 'multipart/form-data',
			url: $("#path").val() + "/profileUpload",
			dataType: "text",
			data: formData, //
			processData: false, // Jquery 내부적으로 query string 방식으로 사용을 안할 때 사용 : 파일 전송때는 사용 안함 - 필수
			contentType: false, // multipart/form-data 방식으로 하기 위해 설정 - 필수
			success: function(data) {
				if (data != null) {
					$("#profileUploadForm")[0].reset();
						$("#toryProfileImgMainForm .toryProfileImg img").remove();
						$("#toryProfileImgMainForm .toryProfileImg svg").css({ 'display': 'inline' });
						$("#toryProfileImgMainForm .toryProfileText").css({ 'display': 'block' });
						$(".toryProfileImg img").attr("src","${pageContext.request.contextPath}/resources/img/profile/"+data);
					$("#toryProfileImgForm").animate({
						top: "40%",
						opacity: 0
					}, 1000, function() {
						$(this).css({ 'display': 'none' });
					});
				}
			}
		});
	});

});
</script>
<!-- 
	프로필 이미지 등록 뷰
 -->
<input type="hidden" id="path"
	value="${pageContext.request.contextPath}">
<div class="row" id="toryProfileImgForm">
	<div class="col-sm-12" id="toryProfileImgTilte">
		<h1>프로필 사진 선택</h1>
	</div>
	<div class="col-sm-12" id="toryProfileImgMainForm">
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
			<h1>프로필 사진을 업로드해주세요.</h1>
		</div>
		<div class="toryProfileUpload">
			<form id="profileUploadForm" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${sessionScope.mvo.id}"> <input
					type="file" name="profileImg" id="profileImg" accept="image/*"
					>
			</form>
		</div>
	</div>
	<div class="col-sm-12 toryProfileUploadButton">
		<input type="button" value="프로필 사진으로 설정" id="profileUploadBtn">
		<input type="button" value="취소" />
	</div>
</div>
<!-- 
	 	미니홈피 -> 프로필 보기(사진 + 소개글 + 닉네임) -> 수정하기(완료) -> 프로필 보기;
		프로필 닉네임 소개글 수정 뷰
	 -->
<div class="col-sm-8 offset-2" id="toryProfileUpdateForm">
	<form action="${pageContext.request.contextPath}/front" method="post">
		<input type="hidden" name="command" value="toryProfileUpdate">
		<input type="hidden" name="id" value="${sessionScope.mvo.id}">
		<table>

			<tr>
				<th colspan="2"><h1>회원정보 수정</h1></th>
			</tr>

			<tr>
				<th>프로필</th>
				<td>
					<div class="toryProfileImg">
						<div class="cameraicon">
							<svg width="100px" height="100px" viewBox="0 0 16 16"
								class="bi bi-camera-fill" fill="currentColor"
								xmlns="http://www.w3.org/2000/svg">
  <path d="M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z" />
  <path fill-rule="evenodd"
									d="M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z" />
</svg>
						</div>

						<c:choose>
							<c:when test="${sessionScope.mvo.profilePhoto == null }">
								<img
							src="${pageContext.request.contextPath}/resources/img/profile/profileDefualt.png">
							</c:when>
							<c:otherwise>
							<img
							src="${pageContext.request.contextPath}/resources/img/profile/${sessionScope.mvo.profilePhoto}">
							</c:otherwise>
						</c:choose>
					
					</div>
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<div class="toryProfileNick">
						<input type="text" name="nickName" required="required"
							placeholder="닉네임을 입력해주세요." value="${sessionScope.mvo.nickname}">
					</div>
				</td>
			</tr>
			<tr>
				<th>소개글</th>
				<td>
					<div class="toryProfileContent">
						<input type="text" name="profileContent" required="required"
							placeholder="소개글을 입력해주세요."
							value="${sessionScope.mvo.profileContent}">
					</div>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="프로필 수정"></td>
				<td><input type="button" value="취소"></td>
			</tr>


		</table>
	</form>
</div>

