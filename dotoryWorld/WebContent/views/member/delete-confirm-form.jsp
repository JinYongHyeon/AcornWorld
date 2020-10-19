<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 <script type="text/javascript">
 /*
 	function passCheck() {
		 var password = $("#myForm input[name=password]").val();
		 var passwordComp = $("#myForm input[name=passCheckComp]").val();
 		var flag=true;
		 if(password!==passwordComp){
			alert("비밀번호가 일치하지 않습니다.");
			//location.href = "${pageContext.request.contextPath}/delete-confirm-fail.jsp";
			flag=false;
			}  
		return flag;
		}
 */
</script>
</head>
<body>
<div>
    <form id="myForm" action="${pageContext.request.contextPath}/front" method="post">
        <input type="hidden" name="command" value="deleteMember">
<%--         <input type="hidden" name="id" value="${sessionScope.mvo.id}" readonly="readonly">
 --%>       
<%--   <input type="hidden" name="passCheckComp" value="${sessionScope.mvo.password}">
 --%>        <h6>회원탈퇴</h6>
        <h6>비밀번호를 입력하세요</h6>
        <table>       
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="password" ></td>
            </tr>
        </table>
         <input type="submit" value="탈퇴하기"/>
         <!-- onsubmit 은 위에 자바스크립트를 거쳐서 감, 안 쓸 경우 위의 action으로가서 command로 감 -->
    </form>
 </div>

</body>
</html>