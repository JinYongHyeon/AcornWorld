package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ToryProfileFormController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		
		if(session == null || session.getAttribute("mvo") == null)return "redirect:front?command=main";
		request.setAttribute("url", "/views/torihomepage/my-profile-form.jsp");
		return "views/template/main-layout.jsp";
	}

}
