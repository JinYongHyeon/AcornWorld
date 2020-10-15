<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
 	function passCheck() {
		
	}
</script>
</head>
<body>
<div class="card">
    <form action="DispatcherServlet" method="post" onsubmit="return passCheck()">
        <input type="hidden" name="command" value="delete">
        <input type="hidden" name="id" value="${sessionScope.mvo.id}" readonly="readonly">
        <input type="hidden" name="passCheck" value="${sessionScope.mvo.id}">
        <h3>회원탈퇴</h3>
        <h4>비밀번호를 입력하세요</h4>
        <table>       
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="password" ></td>
            </tr>
            <tr rowspan="2">
                <td><input type="submit" value="탈퇴하기"/></td>
            </tr>
        </table>
    </form>
 </div>
</body>
</html>