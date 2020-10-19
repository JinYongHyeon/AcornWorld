<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--API 구동에 필요한 파일 로딩 --%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	// API는 카카오에서 그대로 가져왔습니다.
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // 현재 코드에서는 참고 항목을 사용하지 않는다
                    //document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                // 현재 코드에서 우편번호를 사용하지 않는다.
                //document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
	}
	
	$(document).read(function(){
		
	})

</script>

<style>	
	table {
		text-align: left;
		margin: auto;
	}
</style>

<%-- 로그인 여부를 체크하고 로그인이 안됐을 경우 회원 정보 수정 페이지 접근 불가 처리 --%>
<c:choose>
	<c:when test="${sessionScope.mvo !=null }">
		<form method="post" action="front">
		<input type="hidden" name="command" value="updateMemberInfo">
			<table>
				<tbody>
					<tr>
						<td>아이디</td>
						<%-- readonly 옵션은 value값 수정이 불가하고, form 전송이 가능하다. --%>
						<td>
							<input type="text" readonly="readonly"
								name="updateId" value="${sessionScope.mvo.id}">
						</td>				
					</tr>
					<tr>
						<td>현재 비밀번호</td>
						<td><input type="password" name="nowPassword"></td>
					</tr>
					<tr>
						<td>새 비밀번호</td>
						<td><input type="password" name="updatePassword"></td>
					</tr>
					<tr>
						<td>새 비밀번호 확인</td>
						<td><input type="password" name="updatePasswordCheck"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td><input type="text" name="updateName"></td>
					</tr>
					<tr>
						<td rowspan="3" align ="left">주소</td>
						<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
					</tr>
					<tr>
						<td><input style="width: 300px" type="text" name="updateAddress" id="sample6_address" placeholder="주소"></td>
					</tr>
					<tr>
						<td><input style="width: 200px" type="text" name="updateAddressDetail" id="sample6_detailAddress" placeholder="상세주소"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input style="width: 250px" type="text" name="updateEmail"></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="submit" value="수정 완료">
							<button type="button" onclick="location.href='${pageContext.request.contextPath}/front?command=deleteMemberForm'">회원탈퇴</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			alert("로그인이 필요합니다.");
			location.href="${pageContext.request.contextPath}/front?command=main";
		</script>
	</c:otherwise>
</c:choose>

