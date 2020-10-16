package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.PostDAO;


public class BoardListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("categoryList", PostDAO.getInstance().getCategoryList());	
		request.setAttribute("url", "/views/template/right.jsp");
		return "/views/template/main-layout.jsp";
	}

}
