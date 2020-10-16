package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;

public class ToryProfileUpdateController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ninkName = request.getParameter("nickName");
		String profileContent = request.getParameter("profileContent");
		//String id = request.getParameter("id");
		MemberDAO.getInstance().toryProfileUpdate(ninkName, profileContent, "user3");
		
		return "redirect:front?command=main";
	}

}
