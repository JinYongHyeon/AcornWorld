<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/editor/js/HuskyEZCreator.js"></script>
<script type="text/javascript">
	var oEditors = [];
	$(function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "postContent",
			//SmartEditor2Skin.html 파일이 존재하는 경로
			sSkinURI: "${pageContext.request.contextPath}/resources/editor/SmartEditor2Skin.html",  
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,             
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,     
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,         
				fOnBeforeUnload : function(){}
			}, 
			fOnAppLoad : function(){
			//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
			oEditors.getById["PostContent"].exec("PASTE_HTML", []);
			},
			fCreator: "createSEditor2"
		});
	      
		//저장버튼 클릭시 form 전송
		$("#postUpdate").click(function(){
			if($("#postTitle").val()==""){
		    	alert("게시글 제목을 입력하세요.");
		    	return;
			}
			oEditors.getById["postContent"].exec("UPDATE_CONTENTS_FIELD", []);
			if($("#postContent").val()==""){
				alert("게시글 내용을 입력하세요.");
				return;
			}
			
			$("#frm").submit();
		});
	});
</script>
<form action="${pageContext.request.contextPath}/front" id="frm" method="post" >
	<input type="hidden" name="command" value="postUpdate"></input>	
	<input type="hidden" name="no" value="${pvo.postNo}"></input>	
	<table class="table" >
		<tr>
			<td colspan="4">제목 &nbsp;&nbsp;
				<input type="text" id ="postTitle" name="title" value="${pvo.postTitle}" required="required">
			</td>
		</tr>   
		<tr>
			<td colspan="4">     
				<textarea cols="90" rows="15" id="postContent" name="content" required="required" >${pvo.postContent }</textarea>
			</td>
		</tr> 
		<tr>
				<td>게시판번호: ${requestScope.pvo.boardVO.boardNo}</td> <!-- 번호가 아닌 텍스트로 잡으면? -->
				<td>글번호: ${requestScope.pvo.postNo }</td>
				<td>작성자 : ${requestScope.pvo.memberVO.name }</td>
				<td>작성일시 : ${requestScope.pvo.postDate }</td>
		</tr>
	</table>    
	<div class="btnArea">
		<button type="button" id="postUpdate" class="btn" >수정</button>  
		<button type="reset" class="btn" >취소</button>   
	</div>  
</form>