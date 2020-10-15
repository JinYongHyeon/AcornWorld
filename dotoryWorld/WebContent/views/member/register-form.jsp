<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<script type="text/javascript">
	$(document).ready(function() {
		var checkId="";
		$("#memberId").keyup(function() {
			checkId="";
			var idValue=$(this).val();
			if(idValue.length<4||idValue.length>10) {
				$("#checkResult").html("아이디는 4자 이상 10자 이하만 가능합니다").css("color", "black");
				return;
			}
			
			$.ajax({
				type:"get",
				url:"front",
				data:"command=idCheck&id="+idValue,
				success:function(result) {
					if(result=="ok") {
						$("#checkResult").html("사용가능한 아이디입니다").css("color", "blue");
						checkId=idValue;
					} else {
						$("#checkResult").html("사용불가한 아이디입니다").css("color", "red");
					}
				}
			});//ajax
		});//keyup
		$("#registerForm").submit(function() {
			if(checkId=="") {
				alert("아이디 중복 확인을 해주세요!");
				return false;
			}
		});//submit
	});//ready
</script>

<body>
<form action="${pageContext.request.contextPath}/front" method="post" id="registerForm">
<input type="hidden" name="command" value="registerMember">
아이디 <input type="text" name="id" id="memberId" required="required">
<span id="checkResult"></span> <br>
비밀번호 <input type="password" name="password" required="required"> <br>
이름 <input type="text" name="name" required="required"> <br>
주소 <input type="text" name="address" required="required"> <br>
이메일 <input type="text" name="email" required="required"> <br>
닉네임 <input type="text" name="nickname" required="required"> <br>
소개글 <textarea cols="25" rows="3" name="profileContent" required="required" placeholder="소개글을 입력하세요"></textarea> <br>
<input type="submit" value="회원가입">
</form>
</body>
</html>