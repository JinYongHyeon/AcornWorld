<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${sessionScope.mvo != null}">
	<a
		href="${pageContext.request.contextPath}/front?command=toryHome&id=${sessionScope.mvo.id}">내
		미니홈피 가기</a>
	<c:if test="${sessionScope.mvo.grade == '다람쥐'}">
		<a href="${pageContext.request.contextPath}/front?command=adminManage">관리자
			페이지</a>
	</c:if>
</c:if>

<div class="row">
	<div class="col-sm-6"></div>
	<div class="col-sm-6"></div>
</div>