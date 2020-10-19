<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="row">
	<div class="col-sm-8 offset-2" id="toryProfileForm">
		<table>

			<tr>
				<th colspan="2">프로필</th>
			</tr>

			<tr>
				<th>프로필 사진</th>
				<td><div class="toryProfileImg">
						<c:choose>
							<c:when test="${sessionScope.mvo.profilePhoto == null}">
								<img
									src="${pageContext.request.contextPath}/resources/img/profile/profileDefualt.png">
							</c:when>
							<c:otherwise>
								<img src="${pageContext.request.contextPath}/resources/img/profile/${sessionScope.mvo.profilePhoto}">
							</c:otherwise>
						</c:choose>

					</div></td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<div class="toryProfileNick">
						<span>${sessionScope.mvo.nickname}</span>
					</div>
				</td>
			</tr>
			<tr>
				<th>소개글</th>
				<td><div class="toryProfileContent">
						<span>${sessionScope.mvo.profileContent}</span>
					</div></td>
			</tr>
		</table>
		<a
			href="${pageContext.request.contextPath}/front?command=toryProfileUpdateForm">프로필
			수정</a>
					 <button type="button" onclick="location.href='${pageContext.request.contextPath }/front?command=myDotoryList'">내 도토리들 보기</button>
			
	</div>

</div>

