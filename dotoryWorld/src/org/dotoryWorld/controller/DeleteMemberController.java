package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.PostDAO;

public class DeleteMemberController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		if(session==null||session.getAttribute("MemberVO")==null) {
			return "redirect:index.jsp";
		}
		String id=request.getParameter("id");
        String password=request.getParameter("password");
         MemberDAO.getInstance().
         
        /*if(deleteConfirm==0) {
            return "redirect:views/member/delete-confirm-fail.jsp";
        }else {
            session.invalidate();
            MemberDAO.getInstance().
            return "redirect:views/member/delete-result.jsp";
        }*/
	}

}
