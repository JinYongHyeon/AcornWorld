<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
</script>


<style>
	table {
		width: 1000px;
		margin-top: 20px;
		text-align: center;
	}

	#head th{
		padding: 3px;
		border: 3px solid #00264d;
		text-align: center;
	}
	
	#body td{
		padding: 30px;
		border: 2px solid #FFC0CB;
		
	}
	
	.pagingArea{
		text-align: center;
	}
	
	#letterWrite td{
		border: 3px solid lime;
		resize: none;
	}
	
	#letterForm{
		resize: none;
	}

</style>
${mvo.id == list.homewriterId || mvo.id == list.memberVO.id || mvo.grade == '다람쥐'}
<table >
	<c:forEach var="list" items="${requestScope.letterVO.letterList }">
		<thead>
			<tr id="head">
				<th>No.${list.homeNo }</th>
				<th>${list.homewriterId }</th>
				<th>${list.homeDate }</th>
				<c:choose>
					<c:when test="${mvo.id == list.homewriterId || mvo.id == list.memberVO.id || mvo.grade == '다람쥐'}">
						<th><button onclick="dd()">삭제</button></th>
					</c:when>
					<c:otherwise>
						<th></th>
					</c:otherwise>
				</c:choose>
			</tr>
		</thead>
		<tbody>
			<tr id ="body">
				<c:choose>
					<c:when test="${list.memberVO.profilePhoto==null }">
						<td colspan="2">
							<img width="20px" src="${pageContext.request.contextPath}/resources/img/profile/profileDefualt.png">
						</td>
					</c:when>
					<c:otherwise>
						<td colspan="2">${list.memberVO.profilePhoto }</td>
					</c:otherwise>
				</c:choose>
				<td colspan="2">
					${list.homeContent }
				</td>
			</tr>
			<tr><td><br></td></tr>
		</tbody>
	</c:forEach>
</table>

<div class="pagingArea">
	<c:set var="paging" value="${requestScope.letterVO.pagingBean }"/>
	<ul class="pagination">
		<c:if test="${paging.previousPageGroup }">
			<li>
				<a href="${pageContext.request.contextPath}/front?command=toryHome&id=${requestScope.letterVO.letterList[0].memberVO.id}&letterPageNo=${paging.startPageOfPageGroup-1 }">&laquo;</a>
			</li>
		</c:if>
		<c:forEach var="i" begin="${paging.startPageOfPageGroup }" end="${paging.endPageOfPageGroup }">
			<c:choose>
				<c:when test="${pb.nowPage!=i }">
					<li><a href="${pageContext.request.contextPath}/front?command=toryHome&id=${requestScope.letterVO.letterList[0].memberVO.id}&letterPageNo=${i }">${i }</a></li>
				</c:when>
				<c:otherwise>
					<li class="active"><a href="#">${i }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.nextPageGroup }">
			<li>
				<a href="${pageContext.request.contextPath}/front?command=toryHome&id=${requestScope.letterVO.letterList[0].memberVO.id}&letterPageNo=${paging.endPageOfPageGroup+1 }">&raquo;</a>
			</li>
		</c:if>
	</ul>
</div>

<table id="letterWrite">
	<tbody>
		<tr>
			<td>
				<textarea id="letterForm" cols="130" rows="4" name="content" required="required" placeholder="본문내용을 입력하세요"></textarea>
			</td>
			<td>
				<input type="submit" value="글 남기기">
			</td>
		</tr>
	</tbody>
</table>