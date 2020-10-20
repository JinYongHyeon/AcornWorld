<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>도토리 월드</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myHomecss.css" />
</head>

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
        
        // 상세주소 입력 가능 상태로 변경
        $("input[name=updateAddressDetail]").attr('readonly', false);
	}
	
	// submit 실행
	function updateMember() {
		var checkResult = false;
		if(updateForm.updatePassword.value !== updateForm.updatePasswordCheck.value){ // 새 비밀번호 일치 확인
			alert("새 비밀 번호가 일치하지 않습니다.")
			updateForm.updatePassword.focus();
		}else{
			checkResult = confirm("정보를 변경하시겠습니까?");
		}
		
		return checkResult;
	}
	
	// 비밀 번호 확인 진행여부 확인
	$(document).ready(function(){
		// name으로 접근 시 ${tag_name [name=valu_name]} 형식으로
		$("input[name=updatePassword]").keyup(function () {
			if(updateForm.nowPassword.value !== updateForm.pwCheck.value || updateForm.nowPassword.value=== ""){
				alert("비밀번호 확인 이후 입력이 가능합니다.");
				updateForm.updatePassword.value="";
				updateForm.nowPassword.focus();
			}
		})
		
		$("input[name=updatePasswordCheck]").keyup(function () {
			if(updateForm.nowPassword.value !== updateForm.pwCheck.value || updateForm.nowPassword.value=== ""){
				alert("비밀번호 확인 이후 입력이 가능합니다.");
				updateForm.updatePasswordCheck.value="";
				updateForm.nowPassword.focus();
			}
		})
	})

</script>



<%-- 로그인 여부를 체크하고 로그인이 안됐을 경우 회원 정보 수정 페이지 접근 불가 처리 --%>
<c:choose>
	<c:when test="${sessionScope.mvo !=null }">
		<form name="updateForm" method="post" action="front" onsubmit="return updateMember()"
		id="updateTable">
		<input type="hidden" name="command" value="updateMemberInfo">
			<table>
				<tbody>
					<tr>
						<td>아이디</td>
						<%-- readonly 옵션은 value값 수정이 불가하고, form 전송이 가능하다. --%>
						<td>
							<input type="text" readonly="readonly"
								name="nowId" value="${sessionScope.mvo.id}">
						</td>				
					</tr>
					<tr>
						<td>새 비밀번호</td>
						<td>
							<input type="password" name="updatePassword"
								placeholder="비밀번호 변경시 입력">
						</td>
					</tr>
					<tr>
						<td>새 비밀번호 확인</td>
						<td><input type="password" name="updatePasswordCheck"></td>
					</tr>
					<tr>
						<td>이름</td>
						<td>
							<input type="text" name="updateName"
								value="${sessionScope.mvo.name}" required="required">
						</td>
					</tr>
					<tr>
						<td>현재 주소</td>
						<td>
							<input style="width: 350px" type="text" readonly="readonly"
								name="nowAddress" value="${sessionScope.mvo.address}">
						</td>
					</tr>
					<tr>
						<td>새 주소</td>
						<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
					</tr>
					<tr>
						<td rowspan="2"></td>
						<td><input style="width: 300px" type="text" name="updateAddress" id="sample6_address" placeholder="주소" readonly="readonly"></td>
					</tr>
					<tr>
						<td><input style="width: 200px" type="text" name="updateAddressDetail" id="sample6_detailAddress" placeholder="상세주소" readonly="readonly"></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td>
							<input style="width: 250px" type="text" required="required"
								name="updateEmail" value="${sessionScope.mvo.email}">
						</td>
					</tr>
					<tr>
						<td></td>
						<td align="left">
							<input type="submit" value="수정 완료">
							<input type="button" onclick="location.href='${pageContext.request.contextPath}/front?command=deleteMemberForm'" value="회원탈퇴">
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



