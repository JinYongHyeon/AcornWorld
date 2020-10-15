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
		
		$("#memberPassCheck").keyup(function() {
			var passCheckValue=$(this).val();
			var passValue=$("#memberPass").val();
			if(passCheckValue!=passValue) {
				$("#checkPassResult").html("비밀번호가 일치하지 않습니다").css("color", "red");
				return false;
			} else {
				$("#checkPassResult").html("비밀번호가 일치합니다").css("color", "blue");
				return;
			}
		});//keyup
	});//ready
	
	function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                   // document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    //document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("address").value=addr;
            }
        }).open();
    }
</script>

<body>
<form action="${pageContext.request.contextPath}/front" method="post" id="registerForm">
<input type="hidden" name="command" value="registerMember">
아이디 <input type="text" name="id" id="memberId" required="required">
<span id="checkResult"></span> <br>
비밀번호 <input type="password" name="password" id="memberPass" required="required"> <br>
비밀번호 확인 <input type="password" name="passwordCheck" id="memberPassCheck" required="required">
<span id="checkPassResult"></span> <br>
이름 <input type="text" name="name" required="required"> <br>
주소 <input type="text" id="address" name="address">
<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
상세 주소 <input type="text" id="addressDetail" name="addressDetail"> <br>
이메일 <input type="text" name="email" required="required"> <br>
닉네임 <input type="text" name="nickname" required="required"> <br>
소개글 <textarea cols="25" rows="3" name="profileContent" required="required" placeholder="소개글을 입력하세요"></textarea> <br>
<input type="submit" value="회원가입">
</form>
</body>
</html>