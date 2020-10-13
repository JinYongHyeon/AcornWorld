package org.dotoryWorld.model;

public class ToryhomeVO {
	private String homeNo;
	private String homeTitle;
	private String homeContent;
	private String homeDate;
	private String homewriterId;
	private MemberVO memberVO;

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
