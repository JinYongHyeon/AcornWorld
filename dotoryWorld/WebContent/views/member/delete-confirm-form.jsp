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

 	function passCheck() {
		 var password = $("#myForm input[name=password]").val();
		 var passwordComp = $("#myForm input[name=passCheckComp]").val();
 		var flag=true;
		 if(password!==passwordComp){
			alert("비밀번호가 일치하지 않습니다.");
			flag=false;
			}  
		return flag;
		}
 	
</script>
<style>
    @font-face{
    font-family: "notom";
    src:url('../../../font/NotoSansKR-Regular.eot');
    src:url('../../../font/NotoSansKR-Regular.eot?#iefix') fotmat("eot"),
    url('../../../font/NotoSansKR-Regular.woff') format("woff"),
    url('../../../font/NotoSansKR-Regular.otf') format("opentype");
    font-weight: normal;
    font-style: normal;
    }
<%--폰트를 참조해준다. --%>
    .font1 {font-family: notom; font-size: 12px; color: #333333; font-weight: bolder; position: absolute;}
    .font2 {font-family: notom; font-size: 14px; font-weight: bold; color: #333333;  position: relative; left: 50px;}
<%--폰트 정의--%>
    body { margin: 0; padding: 0; }
    .btn0 {background-color: #0066ba; border: 0; color: #ffffff; border-radius: 5px; height: 100px; height: 40px;}
    .btn1 {background-color: #0066ba; color: #ffffff; width: 100px; height: 30px; border: 0; border-radius: 5px; }
    .btn2 {background-color: #aaaaaa; color: #ffffff; width: 100px; height: 30px; border: 0; border-radius: 5px; margin-left: 25px;}
<%--버튼 정의--%>
    .div1 {width: 1000px; height: 400px; border: 1px solid #cccccc; margin: 0 auto; font
family: 'notom'; position: absolute;}
    .tablecss {width: 900px; height: 240px; border: 1px solid #0067b8; margin: 0 auto; list-style: none; padding: 0; position: relative; bottom: 20px; left: 45px;}
    .tablecss > li {width: 120px; height: 40px;}
    .tablecss > li:nth-child(1) {width: 120px;  border: 1px solid  #0067b8;}
    .div1 ul li {float: left; } //
    .div1 ul {float: left; list-style: none;}
    .li {width: 120px; height: 40px;}
<%--div 클래스 정의--%>
    .text1 {width: 200px; height: 30px;}
    .text2 {width: 400px; height: 30px;}   <%--텍스트 크기 정의 --%>
    .divbtn {width: 600px; height: 30px; text-align: center; margin-top: 30px; position: relative; left: 350px; bottom: 10px; }
    </style>
</head>
<body>
<div>
    <form id="myForm" action="${pageContext.request.contextPath}/front" method="post" onsubmit="return passCheck()">
        <input type="hidden" name="command" value="deleteMember">
        <input type="hidden" name="id" value="${sessionScope.mvo.id}" readonly="readonly">
        <input type="hidden" name="passCheckComp" value="${sessionScope.mvo.password}">
        <h6>회원탈퇴</h6>
        <h6>비밀번호를 입력하세요</h6>
        <table>       
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="password" ></td>
            </tr>
        </table>
         <input type="submit" value="탈퇴하기"/>
    </form>
 </div>

</body>
</html>