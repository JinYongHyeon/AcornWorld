package org.dotoryWorld.model;

public class BookmarkVO {
	private String bookmarkNo;
	private String bookmarkLink;
	private String bookmarkDivide;
	private MemberVO memberVO;

	public BookmarkVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BookmarkVO(String bookmarkNo, String bookmarkLink, String bookmarkDivide, MemberVO memberVO) {
		super();
		this.bookmarkNo = bookmarkNo;
		this.bookmarkLink = bookmarkLink;
		this.bookmarkDivide = bookmarkDivide;
		this.memberVO = memberVO;
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

	@Override
	public String toString() {
		return "BookmarkVO [bookmarkNo=" + bookmarkNo + ", bookmarkLink=" + bookmarkLink + ", bookmarkDivide="
				+ bookmarkDivide + ", memberVO=" + memberVO + "]";
	}

}
