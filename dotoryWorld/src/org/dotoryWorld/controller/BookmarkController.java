package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.BookmarkVO;
import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PostDAO;

public class BookmarkController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		String link = request.getParameter("link ");
		String bookmark = request.getParameter("bookmark");
		
		BookmarkVO mark = new BookmarkVO();
		mark.setBookmarkLink(link);
		mark.setBookmarkDivide(bookmark);
		
		MemberVO mvo = new MemberVO();
		mvo.setId(id);
		
		mark.setMemberVO(mvo);
		
		PostDAO.getInstance().addBookMark(mark);
		
		return null;
	}

}
