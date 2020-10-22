package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class MyDotoryListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("mvo") == null)return "front?command=main";
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		request.setAttribute("myDotoryList", MemberDAO.getInstance().mydotorylist(request.getParameter("id")));
		request.setAttribute("url","/views/member/mydotory-list.jsp");
		return "/views/template/main-layout.jsp";
	}
}






