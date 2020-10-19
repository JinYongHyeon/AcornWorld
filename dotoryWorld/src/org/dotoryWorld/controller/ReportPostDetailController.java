package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ReportPostDetailController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null) {
			return "redirect:index.jsp";
		}
		String no=request.getParameter("no");
		@SuppressWarnings("unchecked")
		ArrayList<String> noList=(ArrayList<String>)session.getAttribute("noList");
		
		return null;
	}

}
