package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.PostDAO;


public class BoardListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String categoryNo=request.getParameter("categoryNo");
		request.setAttribute("boardList", PostDAO.getInstance().getBoardList(categoryNo));	
		request.setAttribute("url", "/views/board/board-list.jsp");
		return "/views/template/main-layout.jsp";
	}

}
