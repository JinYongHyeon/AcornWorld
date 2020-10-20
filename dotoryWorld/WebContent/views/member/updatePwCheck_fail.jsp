<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
</head>
<body bgcolor="red" onunload="closePop()">
	<script type="text/javascript">
		var pwPop=window.opener.updateForm;
		pwPop.nowPassword.value="";
		pwPop.pwCheck.value="";
		
		function closePop(){
			pwPop.nowPassword.focus();
			self.close();
		}
	</script>
	<h4>비밀번호가 일치하지 않습니다.</h4>
	<input type="button" value="확인" onclick="closePop()">
</body>
</html>