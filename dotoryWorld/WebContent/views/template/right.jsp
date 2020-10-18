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
	function movie() {
		location.href ="${pageContext.request.contextPath}/front?command=boardList&categoryNo=3";
	}
	function music() {
		location.href ="${pageContext.request.contextPath}/front?command=boardList&categoryNo=4";
	}
</script>
	<input type="button" value="운동" onclick="sport()" style="float: left; WIDTH: 70pt; height: 35pt;"> <br><br><br>
	<input type="button" value="요리" onclick="cooking()" style="float: left; WIDTH: 70pt; height: 35pt;"> <br><br><br>
	<input type="button" value="영화" onclick="movie()" style="float: left; WIDTH: 70pt; height: 35pt;"> <br><br><br>
	<input type="button" value="음악" onclick="music()" style="float: left; WIDTH: 70pt; height: 35pt;"> <br><br><br>

