package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;

public class ToryletterWriteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 미니홈피 주인과 방문자의 id 정보를 받아온다.
		String id =request.getParameter("id");
		String id_writer = request.getParameter("id_writer");
		String contentLetter = request.getParameter("contentLetter");
		
		MemberDAO.getInstance().addToryLetter(id, id_writer, contentLetter);
		
		return "front?command=toryHome";
	}

}
