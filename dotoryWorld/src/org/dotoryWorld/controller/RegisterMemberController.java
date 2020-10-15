package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class RegisterMemberController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		String name=request.getParameter("name");
		String address=request.getParameter("address");
		String addressDetail=request.getParameter("addressDetail");
		String email=request.getParameter("email");
		String nickname=request.getParameter("nickname");
		String profileContent=request.getParameter("profileContent");
		MemberVO memberVO=new MemberVO(id, password, name, address+" "+addressDetail, email, nickname, profileContent, null, "도토리");
		MemberDAO.getInstance().registerMember(memberVO);
		return "redirect:views/member/register-result.jsp";
	}

}
