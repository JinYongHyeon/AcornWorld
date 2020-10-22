package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.BookmarkVO;
import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.PagingBean;

public class BookmarkListController implements Controller {
	
	/**
	 * 내 북마크 가져오는 기능
	 */
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("mvo") == null) return "front?command=main";
		
		String id = request.getParameter("id");
 		String bookmark = request.getParameter("bookmark");
 		String nowPage = request.getParameter("nowPage");
 		
 		 /**
		  * 페이지당 게시물수
		  */
		  int postCountPerPage = 10;
		 /**
		  * 페이지 그룹당 페이지수
		  */
		  int pageCountPerPageGroup =5 ;
 		
 		PagingBean paginBean = null;
 		int totalCount = MemberDAO.getInstance().bookmartListCount(id, bookmark);
		if(nowPage == null) {
		paginBean = new PagingBean(totalCount,postCountPerPage,pageCountPerPageGroup);
		}else {
		paginBean = new PagingBean(totalCount,Integer.parseInt(nowPage),postCountPerPage,pageCountPerPageGroup);
		}
		
		ArrayList<BookmarkVO> bookList =MemberDAO.getInstance().bookmarkListAll(id,bookmark,paginBean);
		request.setAttribute("bookmarkPagin", paginBean);
		request.setAttribute("bookmarkList", bookList);		
		request.setAttribute("url", "/views/bookmark/bookmark.jsp");
	
		
		return "views/template/main-layout.jsp";
	}

}
