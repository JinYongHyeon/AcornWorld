package org.dotoryWorld.model;

import java.util.ArrayList;

public class ToryLetterListVO {	// 방명록 페이징에 필요
	private ArrayList<ToryhomeVO> LetterList;
	private PagingBean pagingBean;
	
	public ToryLetterListVO(ArrayList<ToryhomeVO> letterList, PagingBean pagingBean) {
		super();
		LetterList = letterList;
		this.pagingBean = pagingBean;
	}

	public ArrayList<ToryhomeVO> getLetterList() {
		return LetterList;
	}
	public void setLetterList(ArrayList<ToryhomeVO> letterList) {
		LetterList = letterList;
	}
	public PagingBean getPagingBean() {
		return pagingBean;
	}
	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	@Override
	public String toString() {
		return "ToryLetterListVO [LetterList=" + LetterList + ", pagingBean=" + pagingBean + "]";
	}
	
	
}
