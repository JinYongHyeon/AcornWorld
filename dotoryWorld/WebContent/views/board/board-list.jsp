<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<body>
	<form id="categoryContent">
		<c:choose>
			<c:when test="${requestScope.categoryNo==1}">
				<img
					src="${pageContext.request.contextPath}/resources/img/exercise.png">
		${requestScope.boardList[0].categoryVO.categoryContent}
	</c:when>
			<c:when test="${requestScope.categoryNo==2}">
				<img
					src="${pageContext.request.contextPath}/resources/img/cooking-pots.png">
		${requestScope.boardList[1].categoryVO.categoryContent}
	</c:when>
			<c:when test="${requestScope.categoryNo==3}">
				<img
					src="${pageContext.request.contextPath}/resources/img/video-camera.png">
		${requestScope.boardList[2].categoryVO.categoryContent}
	</c:when>
			<c:when test="${requestScope.categoryNo==4}">
				<img
					src="${pageContext.request.contextPath}/resources/img/music-notes.png">
		${requestScope.boardList[3].categoryVO.categoryContent}
	</c:when>
		</c:choose>
	</form>
	<br>
	<br>
	<div class="container text-center">
		<div class="row" id="boardList">
			<div class="col-sm-12">
				<ul>
					<c:forEach items="${requestScope.boardList}" var="boardList">
						<li>
							<form action="${pageContext.request.contextPath}/front"
								id="boardListForm">
								<input type="hidden" name="command" value="postList"> <input
									type="hidden" name="hobbyBoardNo" value="${boardList.boardNo}">
								<img
									src="${pageContext.request.contextPath}/resources/img/${boardList.boardImage}">
								<c:if test="${sessionScope.mvo != null}">
									<input type="button" value="⭐">
									<br>
									<input type="submit" value="${boardList.boardTitle}">
								</c:if>
								<c:if test="${sessionScope.mvo == null}">
									<br>
									<input type="submit" value="${boardList.boardTitle}"
										style="width: 100%;">
								</c:if>
								<br> <br> <br>
							</form>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							/* 즐겨찾기 */
							$(document)
									.on(
											"click",
											"#boardList input[value=⭐]",
											function() {
												var no = $(this)
														.parent()
														.children(
																"input[name=hobbyBoardNo]")
														.val();
												$
														.ajax({
															type : "post",//전송방식
															url : "${pageContext.request.contextPath}/front", //주소
															dataType : "text", //받는타입
															data : "command=bookmark&id=${sessionScope.mvo.id}&link="
																	+ no
																	+ "&bookmark=즐겨찾기", //보낼 값
															success : function(
																	data) {
																if (data == '중복') {
																	alert("취미 즐겨찾기가 중복입니다.");
																} else if (data == '성공') {
																	alert("즐겨찾기 추가 완료");
																	if (confirm("취미 리스트로 이동하시겠습니까")) {
																		location.href = "${pageContext.request.contextPath}/front?command=favoritesList&id=${sessionScope.mvo.id}&bookmark=즐겨찾기";
																	}
																} else {
																	location.href = "${pageContext.request.contextPath}/views/error.jsp";
																}
															}
														});
											});

						});
	</script>