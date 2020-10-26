<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div>
    <form id="myForm" action="${pageContext.request.contextPath}/front" method="post"> 
        <input type="hidden" name="command" value="deleteMember">
<%--         <input type="hidden" name="id" value="${sessionScope.mvo.id}" readonly="readonly">     
 --%><%--   <input type="hidden" name="passCheckComp" value="${sessionScope.mvo.password}">
 --%>       
<%--         <input type="hidden" name="id" value="${sessionScope.mvo.id}" readonly="readonly">
 --%>       
<%--   <input type="hidden" name="passCheckComp" value="${sessionScope.mvo.password}">
 --%>        <h2><b>회원탈퇴</b></h2>
        <h6><b>비밀번호를 입력하세요</b></h6> <br>
        <table>       
            <tr>
                <td colspan="2"><span>비밀번호</span><input type="password" name="password"></td>
            </tr>
        </table>
        <br>
         <input type="submit" value="탈퇴하기"/>
         <!-- onsubmit 은 위에 자바스크립트를 거쳐서 감, 안 쓸 경우 위의 action으로가서 command로 감 -->
    </form>
 </div>
