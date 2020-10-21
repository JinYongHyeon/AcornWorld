package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;

public class ToryProfileUpdateController implements Controller {
	/**
	 * 닉네임과 소개글 수정 후 session 사용자 정보 재활당 
	 */
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("mvo") == null)return "redirect:front?command=main";
		String ninkName = request.getParameter("nickName");
		String profileContent = request.getParameter("profileContent");
		String id = request.getParameter("id");
		MemberDAO.getInstance().toryProfileUpdate(ninkName, profileContent, id);
		
		session.setAttribute("mvo", MemberDAO.getInstance().addToryHomeInformation(id));
		return "redirect:front?command=toryProfileForm&id="+id;
	}

}
