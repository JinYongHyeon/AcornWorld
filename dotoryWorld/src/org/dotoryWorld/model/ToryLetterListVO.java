package org.dotoryWorld.model;

import java.util.ArrayList;

public class ToryLetterListVO {	// 방명록 페이징에 필요
	private ArrayList<ToryhomeVO> letterList;
	private PagingBean pagingBean;
	
	public ToryLetterListVO(ArrayList<ToryhomeVO> letterList, PagingBean pagingBean) {
		super();
		this.letterList = letterList;
		this.pagingBean = pagingBean;
	}

	public ArrayList<ToryhomeVO> getletterList() {
		return letterList;
	}
	public void setletterList(ArrayList<ToryhomeVO> letterList) {
		this.letterList = letterList;
	}
	public PagingBean getPagingBean() {
		return pagingBean;
	}
	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	@Override
	public String toString() {
		return "ToryletterListVO [letterList=" + letterList + ", pagingBean=" + pagingBean + "]";
	}
	
	
}
