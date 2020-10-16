package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class MyDotoryListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setAttribute("myDotoryList", MemberDAO.getInstance().mydotorylist());
		request.setAttribute("url","/views/member/mydotory-list.jsp");
		return "/views/torihomepage/tory-home.jsp";
	}
}






