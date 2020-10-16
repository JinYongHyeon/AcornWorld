<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</head>
<body>
	<!-- 로그인 세션 완료 시 미니홈페이지 주인  놀러온 손님이 친구일 경우 안보이게 하기 -->
	<button type="button" onclick="addDotory()">친구추가</button>
	<script type="text/javascript">
	//도토리 친구추가	
	function addDotory(){
		if(confirm("님 과 친구추가 하시겠습니까?")){//미니홈페이지 주인 아이디 들어가야됨.
			location.href="${pageContext.request.contextPath}/front?command=addDotory"
		} 
	}
	</script>
	 <button type="button" onclick="location.href='${pageContext.request.contextPath }/front?command=myDotoryList'">내 도토리들 보기</button>
	
	
</body>
</html>