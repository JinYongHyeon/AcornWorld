package org.dotoryWorld.model;

public class MemberVO {
	private String id; //아이디
	private String password; //비밀번호
	private String name; //이름
	private String address; //주소
	private String email; //이메일
	private String nickname; //닉네임
	private String profileContent; //소개글
	private String profilePhoto; //프로필
	private String grade; //등급

	public MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberVO(String id, String password, String name, String address, String email, String nickname,
			String profileContent, String profilePhoto, String grade) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.address = address;
		this.email = email;
		this.nickname = nickname;
		this.profileContent = profileContent;
		this.profilePhoto = profilePhoto;
		this.grade = grade;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getProfileContent() {
		return profileContent;
	}

	public void setProfileContent(String profileContent) {
		this.profileContent = profileContent;
	}

	public String getProfilePhoto() {
		return profilePhoto;
	}

	public void setProfilePhoto(String profilePhoto) {
		this.profilePhoto = profilePhoto;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", password=" + password + ", name=" + name + ", address=" + address + ", email="
				+ email + ", nickname=" + nickname + ", profileContent=" + profileContent + ", profilePhoto="
				+ profilePhoto + ", grade=" + grade + "]";
	}

}
