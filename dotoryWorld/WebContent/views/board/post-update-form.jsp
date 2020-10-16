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
	 <form action="${pageContext.request.contextPath}/front" method="post" >
 		<input type="hidden" name="command" value="UpdatePost"></input>	
 		<input type="hidden" name="no" value="${pvo.no}"></input>	
  		<table class="table" >
	   		 <tr>
	   			<td>제목 &nbsp;&nbsp;
	     			<input type="text" name="title" value="${pvo.title}" required="required">
	    		</td>
	    	</tr>   
	    	<tr>
	    		 <td>     
	     			<textarea cols="90" rows="15" name="content" required="required" >${pvo.content }</textarea>
	     		</td>
	    	</tr> 
     	</table>    
     <div class="btnArea">
	     <button type="submit" class="btn" >수정</button>  
	     <button type="reset" class="btn" >취소</button>   
    </div>  
  </form>
</body>
</html>