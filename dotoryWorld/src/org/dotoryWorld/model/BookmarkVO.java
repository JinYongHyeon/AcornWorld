package org.dotoryWorld.model;

public class BookmarkVO {
	private String bookmarkNo;// 번호
	private String bookmarkLink;// 북마크 링크 or 즐겨찾기 링크
	private String bookmarkDivide;// 북마크 or 즐겨찾기 구분
	private MemberVO memberVO;// 도토리
	private PostVO postVO;// 게시물
	private BoardVO boardVO;// 작은카테고리

	public BookmarkVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BookmarkVO(String bookmarkNo, String bookmarkLink, String bookmarkDivide, MemberVO memberVO, PostVO postVO,
			BoardVO boardVO) {
		super();
		this.bookmarkNo = bookmarkNo;
		this.bookmarkLink = bookmarkLink;
		this.bookmarkDivide = bookmarkDivide;
		this.memberVO = memberVO;
		this.postVO = postVO;
		this.boardVO = boardVO;
	}

	public String getBookmarkNo() {
		return bookmarkNo;
	}

	public void setBookmarkNo(String bookmarkNo) {
		this.bookmarkNo = bookmarkNo;
	}

	public String getBookmarkLink() {
		return bookmarkLink;
	}

	public void setBookmarkLink(String bookmarkLink) {
		this.bookmarkLink = bookmarkLink;
	}

	public String getBookmarkDivide() {
		return bookmarkDivide;
	}

	public void setBookmarkDivide(String bookmarkDivide) {
		this.bookmarkDivide = bookmarkDivide;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	public BoardVO getBoardVO() {
		return boardVO;
	}

	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}

	public PostVO getPostVO() {
		return postVO;
	}

	public void setPostVO(PostVO postVO) {
		this.postVO = postVO;
	}

	@Override
	public String toString() {
		return "BookmarkVO [bookmarkNo=" + bookmarkNo + ", bookmarkLink=" + bookmarkLink + ", bookmarkDivide="
				+ bookmarkDivide + ", memberVO=" + memberVO + ", postVO=" + postVO + ", boardVO=" + boardVO + "]";
	}


}
