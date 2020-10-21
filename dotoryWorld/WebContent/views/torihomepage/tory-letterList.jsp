<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
	}
	
	#body td{
		padding: 30px;
		border: 2px solid #FFC0CB;
		
	}

</style>

<table >
	<c:forEach items="${requestScope.toryLetterList }" var="list">
		<thead>
			<tr id="head">
				<th>No.${list.homeNo }</th>
				<th>${list.homewriterId }</th>
				<th>${list.homeDate }</th>
				<c:choose>
					<c:when test="${0==0 }">
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
						<td colspan="2">null</td>
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
	<tfoot>
		<tr>
			<td colspan="4">
				<c:set var="paging" value="${requestScope.toryLvo.letterPaging }"/>
				<ul class="pagination">
					<c:if test="${paging.previousPageGroup }">
						<li>
							<a href="front?command=List&pageNo=${pb.startPageOfPageGroup-1 }">&laquo;</a>
						</li>
					</c:if>
					<c:forEach var="i" begin="${paging.startPageOfPageGroup }" end="${paging.endPageOfPageGroup }">
						<c:choose>
							<c:when test="${pb.nowPage!=i }">
								<li><a href="front?command=List&pageNo=${i }">${i }</a></li>
							</c:when>
							<c:otherwise>
								<li class="active"><a href="#">${i }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${paging.nextPageGroup }">
						<li>
							<a href="front?command=List&pageNo=${paging.endPageOfPageGroup+1 }">&raquo;</a>
						</li>
					</c:if>
				</ul>
			</td>
		</tr>
	</tfoot>
</table>
