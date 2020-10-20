package org.dotoryWorld.model;

public class CategoryVO {
	private String categoryNo; //카테고리 번호
	private String categoryName; //카테고리 이름[운동]
	private String categoryContent;	//카테고리 설명

	public CategoryVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CategoryVO(String categoryNo, String categoryName, String categoryContent) {
		super();
		this.categoryNo = categoryNo;
		this.categoryName = categoryName;
		this.categoryContent = categoryContent;
	}

	public String getCategoryNo() {
		return categoryNo;
	}

	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	public String getCategoryContent() {
		return categoryContent;
	}

	public void setCategoryContent(String categoryContent) {
		this.categoryContent = categoryContent;
	}

	@Override
	public String toString() {
		return "CategoryVO [categoryNo=" + categoryNo + ", categoryName=" + categoryName + ", categoryContent="
				+ categoryContent + "]";
	}

}
