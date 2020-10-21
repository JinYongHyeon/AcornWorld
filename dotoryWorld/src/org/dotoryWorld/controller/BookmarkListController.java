package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.BookmarkVO;
import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.PagingBean;

public class BookmarkListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("mvo") == null) return "front?command=main";
		
		String id = request.getParameter("id");
 		String bookmark = request.getParameter("bookmark");
 		String nowPage = request.getParameter("nowPage");
 		PagingBean paginBean = null;
 		int totalCount = MemberDAO.getInstance().bookmartListCount(id, bookmark);
		if(nowPage == null) {
		paginBean = new PagingBean(totalCount,10,5);
		}else {
		paginBean = new PagingBean(totalCount,Integer.parseInt(nowPage),10,5);
		}
		ArrayList<BookmarkVO> bookList =MemberDAO.getInstance().bookmarkListAll(id,bookmark,paginBean);
		
		request.setAttribute("bookmarkPagin", paginBean);
		request.setAttribute("bookmarkList", bookList);		
		request.setAttribute("url", "/views/bookmark/bookmark.jsp");
	
		
		return "views/template/main-layout.jsp";
	}

}
