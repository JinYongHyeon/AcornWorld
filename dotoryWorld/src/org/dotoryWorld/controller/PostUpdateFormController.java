package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class PostUpdateFormController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null){
			return "redirect:index.jsp";
		}
		
		PostVO pvo = PostDAO.getInstance().getPostingByNo(request.getParameter("no"));		
		request.setAttribute("pvo", pvo);
		request.setAttribute("url", "/views/board/post-update-form.jsp");
		return "/views/template/main-layout.jsp";
	}
}
