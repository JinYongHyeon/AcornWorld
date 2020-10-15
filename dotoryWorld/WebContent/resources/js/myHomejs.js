$(document).ready(function(){
	
	//프로필 등록 이벤트
	$(document).on("click","#profileUploadForm input[value=등록]",function(){
		if(!profileFileCheck()){
			return false;	
		}
		$.ajax({
			type : "post",
			url : "profileUpload",
			dataType : "text",
			data : "id="+$("#profileUploadForm input[name=id]").val()+"&profileImg="+$("#profileUploadForm input[name=profileImg]"),
			success : function(data){
				
			}
		});
	});

});

//프로필이미지 보여주기
function profileFileSee(){
	$("#toryProfileImgMainForm .toryProfileImg").html("");
			var reader = new FileReader();//읽기
			
			reader.onload = function(event){
				var img = document.createElement("img");
				img.setAttribute("src",event.target.result); //img 속성 중 src 에 주소값 넣기
				
				document.querySelector("#toryProfileImgMainForm .toryProfileImg").appendChild(img); //이미지를 넣는다
			};
			
			reader.readAsDataURL(event.target.files[0]);
}

//프로필등록 시 값 NULL NOTNULL 체크
function profileFileCheck(){
	var profile = document.getElementById("profileImg");
	var flag=true;
	if(profile.value==""){
		alert("프로필 이미지를 등록해주십시오.");
		flag=false;
	}
	return flag;
	
}