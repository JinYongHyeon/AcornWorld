<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	function sport() {
		location.href ="${pageContext.request.contextPath}/front?command=boardList&categoryNo=1";
	}
	function cooking() {
		location.href ="${pageContext.request.contextPath}/front?command=boardList&categoryNo=2";
	}
</script>
	<input type="button" value="운동" onclick="sport()"> <br><br>
	<input type="button" value="요리" onclick="cooking()">

