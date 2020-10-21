package org.dotoryWorld.model;

public class PostVO {
	private String postNo; //게시물 번호
	private String postTitle; //게시물 제목
	private String postContent; //게시물 내용
	private String postDate; // 작성일자
	private int postLike; //좋아요
	private int viewCount; //조회수
	private BoardVO boardVO; //큰항목 표시[EX/축구]
	private MemberVO memberVO; //작성자
	private CategoryVO categoryVO;

	public PostVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PostVO(String postNo, String postTitle, String postContent, String postDate, int postLike, int viewCount,
			BoardVO boardVO, MemberVO memberVO, CategoryVO categoryVO) {
		super();
		this.postNo = postNo;
		this.postTitle = postTitle;
		this.postContent = postContent;
		this.postDate = postDate;
		this.postLike = postLike;
		this.viewCount = viewCount;
		this.boardVO = boardVO;
		this.memberVO = memberVO;
		this.categoryVO = categoryVO;
	}

	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public String getPostDate() {
		return postDate;
	}

	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}

	public int getPostLike() {
		return postLike;
	}

	public void setPostLike(int postLike) {
		this.postLike = postLike;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public BoardVO getBoardVO() {
		return boardVO;
	}

	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public CategoryVO getCategoryVO() {
		return categoryVO;
	}

	public void setCategoryVO(CategoryVO categoryVO) {
		this.categoryVO = categoryVO;
	}

	@Override
	public String toString() {
		return "PostVO [postNo=" + postNo + ", postTitle=" + postTitle + ", postContent=" + postContent + ", postDate="
				+ postDate + ", postLike=" + postLike + ", viewCount=" + viewCount + ", boardVO=" + boardVO
				+ ", memberVO=" + memberVO + ", categoryVO=" + categoryVO + "]";
	}

}
