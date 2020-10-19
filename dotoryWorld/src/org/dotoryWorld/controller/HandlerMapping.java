package org.dotoryWorld.controller;

public class HandlerMapping {
	private static HandlerMapping instance = new HandlerMapping();

	private HandlerMapping() {
	}

	public static HandlerMapping getInstance() {
		return instance;
	}

	public Controller create(String command) {
		Controller controller = null;
		if (command.contentEquals("main")) { // HOME 폼
			controller = new MainController();
		} else if (command.contentEquals("loginForm")) { // 로그인 폼
			controller = new LoginFormController();
		} else if (command.contentEquals("login")) {// 로그인
			controller = new LoginController();
		} else if (command.contentEquals("logout")) { // 로그아웃
			controller = new LogoutController();
		} else if (command.contentEquals("registerMemberForm")) { // 회원가입 폼
			controller = new RegisterMemberFormController();
		} else if (command.contentEquals("registerMember")) { // 회원가입
			controller = new RegisterMemberController();
		} else if (command.contentEquals("idCheck")) { // 아이디 체크
			controller = new IdCheckController();
		} else if (command.contentEquals("updateMemberInfoForm")) { // 업데이트 폼
			controller = new UpdateMemberInfoFormController();
		} else if (command.contentEquals("updateMemberInfo")) { // 업데이트
			controller = new UpdateMemberInfoController();
		} else if (command.contentEquals("deleteMemberForm")) { // 회원탈퇴 폼
			controller = new DeleteMemberFormController();
		} else if (command.contentEquals("deleteMember")) { // 회원탈퇴
			controller = new DeleteMemberController();
		} else if (command.contentEquals("toryHome")){ //미니홈피 폼
			controller = new ToryHomeController(); 
		} else if (command.contentEquals("adminManage")) { //어드민 게시물 관리
			controller = new AdminManageController();
		} else if (command.contentEquals("boardList")) { //작은 항목(운동,요리)
			controller = new BoardListController();
		} else if (command.contentEquals("postList")) { //게시물
			controller = new PostListController();
		} else if (command.contentEquals("myPostList")) { //내 게시물
			controller = new MyPostListController();
		} else if (command.contentEquals("myPostDelete")) { //내 게시물
			controller = new MyPostDeleteController();
		} else if (command.contentEquals("reportPostList")) { //신고 게시물
			controller = new ReportPostListController();
		} else if (command.contentEquals("postUpdateForm")) { //게시물 수정 폼
			controller = new PostUpdateFormController();
		} else if (command.contentEquals("postUpdate")) { //게시물 수정
			controller = new PostUpdateController();
		} else if (command.contentEquals("postWriteForm")) { //게시물 작성 폼
			controller = new PostWriteFormController();
		} else if (command.contentEquals("postWrite")) { //게시물 작성
			controller = new PostWriteController();
		} else if (command.contentEquals("searchPost")) { //게시물 검색 
			controller = new SearchPostController();
		} else if (command.contentEquals("postRemove")) { //게시물 삭제
			controller = new PostRemoveController();
		} else if (command.contentEquals("postDetail")) { //게시물 상세
			controller = new PostDetailController();			
		} else if (command.contentEquals("reportPostWriteForm")) { //신고게시물 작성 폼
			controller = new ReportPostWriteFormController();
		} else if (command.contentEquals("reportPostWrite")) { //신고게시물 작성
			controller = new ReportPostWriteController();
		} else if (command.contentEquals("reportPostUpdateForm")) { //신고게시물 수정 폼
			controller = new ReportPostUpdateFormController();
		} else if (command.contentEquals("reportPostUpdate")) { //신고게시물 수정
			controller = new ReportPostUpdateController();
		} else if (command.contentEquals("reportPostRemove")) { //신고게시물 삭제
			controller = new ReportPostRemoveController();
		} else if (command.contentEquals("reportPostDetail")) { //신고게시물 상세
			controller = new ReportPostDetailController();
		} else if(command.contentEquals("toryProfileForm")) {//미니홈피 내 정보 폼
			controller = new ToryProfileFormController();
		} else if (command.contentEquals("toryProfileUpdateForm")) { //미니홈피 내 정보 수정 폼
			controller = new ToryProfileUpdateFormController();
		} else if (command.contentEquals("toryProfileUpdate")) { //미니홈피 내 정보 수정
			controller = new ToryProfileUpdateController();
		} else if (command.contentEquals("toryLetterList")) { //미니홈피 방명록 
			controller = new ToryLetterListController();
		} else if (command.contentEquals("toryletterWrite")) { //미니홈피 방명록 작성
			controller = new ToryletterWriteController();
		} else if(command .contentEquals("toryLetterDelete")) { //미니홈피 방명록 삭제
			controller = new ToryLetterDeleteController();
		}else if(command.contentEquals("myDotoryList")) { //내 친구 목록
			controller = new MyDotoryListController();
		}else if(command.contentEquals("addDotory")) { //친구추가
			controller = new AddDotoryController();
		}else if(command.contentEquals("adminManageDelete")) {//어드민 게시물 삭제
			controller = new AdminManageDeleteController();
		}
		return controller;
	}
}
