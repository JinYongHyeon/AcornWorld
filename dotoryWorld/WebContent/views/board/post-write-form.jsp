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
			//oEditors.getById["PostContent"].exec("PASTE_HTML", ["기존 DB에 저장된 내용을 에디터에 적용할 문구"]);
			},
			fCreator: "createSEditor2"
		});
	      
		//저장버튼 클릭시 form 전송
		$("#postWrite").click(function(){
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
	<input type="hidden" name="command" value="postWrite">
	<input type="hidden" name="boardNo" value="${requestScope.boardNo}">
	<table class="table" >
		<tr>
		    <td>제목 &nbsp;&nbsp;
				<input type="text" id="postTitle" name="title" placeholder="게시글 제목을 입력하세요" required="required">
		    </td>
	    </tr>   
	    <tr>
			<td>     
				<div class="row">
					<div class="col-sm-12">
						<textarea cols="165" rows="20" id="postContent" name="content" required="required" placeholder="본문내용을 입력하세요"></textarea>	
					</div>
				</div>
				
			</td>
		</tr> 
	</table>    
	<div class="btnArea">
		<button type="button" id="postWrite" class="btn" >확인</button>  
		<button type="reset" class="btn" >취소</button>   
	</div>  
</form>