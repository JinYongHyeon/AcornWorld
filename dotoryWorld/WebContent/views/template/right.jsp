<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form id="categoryForm">
	<input type="button" value="운동"
	 onclick="location.href ='${pageContext.request.contextPath}/front?command=boardList&categoryNo=1'"> <br><br><br>
	<input type="button" value="요리" 
	onclick="location.href ='${pageContext.request.contextPath}/front?command=boardList&categoryNo=2'"> <br><br><br>
	<input type="button" value="영화" 
	onclick="location.href ='${pageContext.request.contextPath}/front?command=boardList&categoryNo=3'"> <br><br><br>
	<input type="button" value="음악" 
	onclick="location.href ='${pageContext.request.contextPath}/front?command=boardList&categoryNo=4'"> <br><br><br>
	<input type="button" value="공지/신고" 
	onclick="location.href ='${pageContext.request.contextPath}/front?command=boardList&categoryNo=5'"> <br><br><br>
</form>
	

