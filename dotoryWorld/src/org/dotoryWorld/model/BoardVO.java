package org.dotoryWorld.model;

public class BoardVO {
	private String boardNo;//번호
	private String boardTitle;//작은항목 제목
	private String boardImage; //이미지 주소
	private int boardLike;//작은항목 좋아요
	private CategoryVO categoryVO;//큰항목

	public BoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BoardVO(String boardNo, String boardTitle, int boardLike, String boardImage, CategoryVO categoryVO) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardImage = boardImage;
		this.boardLike = boardLike;
		this.categoryVO = categoryVO;
	}

	public String getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(String boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}


	public String getBoardImage() {
		return boardImage;
	}

	public void setBoardImage(String boardImage) {
		this.boardImage = boardImage;
	}

	public int getBoardLike() {
		return boardLike;
	}

	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}

	public CategoryVO getCategoryVO() {
		return categoryVO;
	}

	public void setCategoryVO(CategoryVO categoryVO) {
		this.categoryVO = categoryVO;
	}

	@Override
	public String toString() {
		return "BoardVO [boardNo=" + boardNo + ", boardTitle=" + boardTitle
				+ ", boardImage=" + boardImage + ", boardLike=" + boardLike + ", categoryVO=" + categoryVO + "]";
	}

}
