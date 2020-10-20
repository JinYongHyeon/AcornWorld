<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
</head>
<body bgcolor="lime" onunload="closePop">
	<script type="text/javascript">
		var pwPop=window.opener.updateForm;
		pwPop.pwCheck.value=${sessionScope.mvo.password}
		function closePop() {
			self.close();
		}
	</script>
	<h4>비밀번호가 일치합니다.</h4>
	<input type="button" value="확인" onclick="closePop()">
</body>
</html>