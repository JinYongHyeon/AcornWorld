package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PostDAO;

public class MyPostDeleteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null|| session.getAttribute("mvo") == null) {
			return "redirect:front?command=main";
		}
		String no[] = request.getParameterValues("deletePost");
		System.out.println(request.getParameterValues("deletePost"));
		for(int i=0;i<no.length;i++) {
			PostDAO.getInstance().deletePostingsByNo(Integer.parseInt(no[i]));
		}
		
		return "redirect:front?command=myPostList";
	}

}
