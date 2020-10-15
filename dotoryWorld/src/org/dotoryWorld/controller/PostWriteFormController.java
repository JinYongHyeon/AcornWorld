package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class PostWriteFormController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//HttpSession session=request.getSession(false);
		//if(session==null||session.getAttribute("mvo")==null){
		//	return "redirect:index.jsp";
		//}
		//request.setAttribute("url", "/board/write.jsp");		
		//return "/template/layout.jsp";
		return "/views/board/post-write-form.jsp";
	}

}
