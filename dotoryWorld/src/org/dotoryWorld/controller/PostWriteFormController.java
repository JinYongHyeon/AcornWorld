package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PostWriteFormController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String boardNo = request.getParameter("boardNo");
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null){
			return "redirect:index.jsp";
		}
		request.setAttribute("boardNo", boardNo);
		request.setAttribute("url", "/views/board/post-write-form.jsp");		
		return "/views/template/main-layout.jsp";
	}

}
