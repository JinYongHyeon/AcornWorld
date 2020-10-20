<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h1>${requestScope.toryLetterList[0].memberVO.id } 방명록 부분</h1>
<script type="text/javascript">
	
</script>
<c:forEach items="${requestScope.toryLetterList }" var="list">
	${list.homeNo } / ${list.homewriterId } / ${list.homeDate }<br>
</c:forEach>

<table border="1">
	<thead>
		<tr>
			<td></td><td>${sessionScope.mvo.nickname }(${sessionScope.mvo.id })</td><td></td>
		</tr>
	</thead>
	<tbody>
	
	</tbody>
	<tfoot>
		
	</tfoot>
</table>
