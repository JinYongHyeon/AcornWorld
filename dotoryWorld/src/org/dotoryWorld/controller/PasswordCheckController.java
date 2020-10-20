package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberVO;

public class PasswordCheckController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		MemberVO mvo = (MemberVO) session.getAttribute("mvo");
		String pw = request.getParameter("nowPassword");
		
		if(pw.contentEquals(mvo.getPassword())) {
			return "/views/member/updatePwCheck_ok.jsp";
		}
		
		return "views/member/updatePwCheck_fail.jsp";
	}

}
