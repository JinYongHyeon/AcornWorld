package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;

public class AddDotoryController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String dotoryId = request.getParameter("dotoryId"); //상대방 아이디
		String MyId = request.getParameter("id");//내 아이디
		
		MemberDAO.getInstance().addDotory("user3", "user4");
		
		return "views/torihomepage/tory-home.jsp";
	}

}
