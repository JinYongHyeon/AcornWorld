<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h1>${requestScope.toryLetterList[0].memberVO.id } 방명록 부분</h1>
<script type="text/javascript">
</script>


<style>
	table {
		width: 1000px;
		
	}

	#head th{
		padding: 10px;
		border: 3px solid #00264d;
	}
	
	#body td{
		padding: 50px;
		border: 2px solid #FFC0CB;
		
	}

</style>

<table>
	<c:forEach items="${requestScope.toryLetterList }" var="list">
		<thead>
			<tr id="head">
				<th>${list.homeNo }</th>
				<th>${list.homewriterId }</th>
				<th>${list.homeDate }</th>
			</tr>
			<tr><td></td></tr>
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
				<td>
					${list.homewriterId }
				</td>
			</tr>
		</tbody>
	</c:forEach>
	<tfoot>
		
	</tfoot>
</table>
