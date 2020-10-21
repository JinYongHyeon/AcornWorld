$(document).ready(function() {


	/* 프로필 이미지 업로드 폼 --> 수정 폼 카메라 아이콘 클릭 시  이벤트*/
	$(document).on("click", "#toryProfileUpdateForm .toryProfileImg .cameraicon", function() {
		$("#toryProfileImgForm").css({ 'display': 'block' });
		$("#toryProfileImgForm").animate({
			top: "50%",
			opacity: 1
		}, 1000);


	});

	/* 프로필 이미지 업로드 폼 --> 취소버튼 클릭 시  이벤트*/
	$(document).on("click", "#toryProfileImgForm .toryProfileUploadButton input[value='취소']", function() {

		$("#toryProfileImgForm").animate({
			top: "40%",
			opacity: 0
		}, 1000, function() {
			$(this).css({ 'display': 'none' },
				$("#profileUploadForm")[0].reset(),
				$("#toryProfileImgMainForm .toryProfileImg img").remove(),
				$("#toryProfileImgMainForm .toryProfileImg svg").css({ 'display': 'inline' }),
				$("#toryProfileImgMainForm .toryProfileText").css({ 'display': 'block' })
			);
		});


	});

	/*프로필 확장자 체크*/
	$(document).on("change", "#profileUploadForm #profileImg", function() {
		//확장자 체크
		var ext = $(this).val().split(".").pop().toLowerCase();

		if ($.inArray(ext, ["gif", "jpg", "jpeg", , "png"]) == -1) {
			alert("gif,jpg,jpeg,png 파일만 업로드 해주세요.");
			$(this).val("");
			return;
		}
		profileFileSee();

	});


});

//프로필이미지 보여주기
function profileFileSee() {
	$("#toryProfileImgMainForm .toryProfileImg svg").css({ 'display': 'none' });
	$("#toryProfileImgMainForm .toryProfileText").css({ 'display': 'none' });
	$("#toryProfileImgMainForm .toryProfileImg img").remove();
	var reader = new FileReader();//읽기

	reader.onload = function(event) {
		var img = document.createElement("img");
		img.setAttribute("src", event.target.result); //img 속성 중 src 에 주소값 넣기

		document.querySelector("#toryProfileImgMainForm .toryProfileImg").appendChild(img); //이미지를 넣는다
	};

	reader.readAsDataURL(event.target.files[0]);
}

//프로필등록 시 값 NULL NOTNULL 체크
function profileFileCheck() {
	var profile = document.getElementById("profileImg");
	var flag = true;
	if (profile.value == "") {
		alert("프로필 이미지를 등록해주십시오.");
		flag = false;
	}
	return flag;
}

//어드민 페이지 게시물 삭제 이벤트
function postDelete() {
	var no = document.getElementsByName("postNo");
	var postDeleteForm = document.getElementById("adminPostDeletForm");
	var flag = false;
	for (var i = 0; i < no.length; i++) {
		if (no[i].checked === true) {
			flag = true;
			break;
		}
	}
	if (flag === false) {
		alert("체크박스를 체크해주세요");
		return flag;
	}
}
function myPostDelete() {
	var no = document.getElementsByName("postNo");
	var myPostDeleteForm = document.getElementById("myPostDeleteFrom");
	var flag = false;
	for (var i = 0; i < no.length; i++) {
		if (no[i].checked === true) {
			flag = true;
			break;
		}
	}
	if (flag === false) {
		alert("체크박스를 체크해주세요");
		return flag;
	}
}



