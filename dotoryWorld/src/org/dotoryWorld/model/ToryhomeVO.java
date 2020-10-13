package org.dotoryWorld.model;

public class ToryhomeVO {
	private String homeNo; //미니홈피 게시물 번호
	private String homeTitle; //미니홈피 게시물 머릿말[방명록,다이어리..]
	private String homeContent;//미니홈피 게시물 내용
	private String homeDate;//미니홈피 게시물 작성일자
	private String homewriterId;//미니홈피 게시물 작성자
	private MemberVO memberVO;//미니홈피 도토리 주인

	public ToryhomeVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ToryhomeVO(String homeNo, String homeTitle, String homeContent, String homeDate, String homewriterId,
			MemberVO memberVO) {
		super();
		this.homeNo = homeNo;
		this.homeTitle = homeTitle;
		this.homeContent = homeContent;
		this.homeDate = homeDate;
		this.homewriterId = homewriterId;
		this.memberVO = memberVO;
	}

	public String getHomeNo() {
		return homeNo;
	}

	public void setHomeNo(String homeNo) {
		this.homeNo = homeNo;
	}

	public String getHomeTitle() {
		return homeTitle;
	}

	public void setHomeTitle(String homeTitle) {
		this.homeTitle = homeTitle;
	}

	public String getHomeContent() {
		return homeContent;
	}

	public void setHomeContent(String homeContent) {
		this.homeContent = homeContent;
	}

	public String getHomeDate() {
		return homeDate;
	}

	public void setHomeDate(String homeDate) {
		this.homeDate = homeDate;
	}

	public String getHomewriterId() {
		return homewriterId;
	}

	public void setHomewriterId(String homewriterId) {
		this.homewriterId = homewriterId;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}

	@Override
	public String toString() {
		return "ToryhomeVO [homeNo=" + homeNo + ", homeTitle=" + homeTitle + ", homeContent=" + homeContent
				+ ", homeDate=" + homeDate + ", homewriterId=" + homewriterId + ", memberVO=" + memberVO + "]";
	}

}
