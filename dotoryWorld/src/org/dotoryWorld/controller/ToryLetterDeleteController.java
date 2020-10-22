package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;

public class ToryLetterDeleteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id_writer = request.getParameter("letterWriter");
		String id = request.getParameter("id");
		String toryhome_no = request.getParameter("ltterNo");
		
		System.out.println(id_writer +"/" + id +"/"+toryhome_no);
		
		MemberDAO.getInstance().deleteToryLetter(id_writer, id, toryhome_no);
		
		return "redirect:front?command=toryHome&id="+id;
	}

}
