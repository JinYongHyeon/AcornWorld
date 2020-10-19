package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class DeleteMemberController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/*
		HttpSession session = request.getSession();	
		String id=request.getParameter("id");
		MemberDAO.getInstance().deleteMember(id);
            session.invalidate();
            return "redirect:views/member/delete-result.jsp";
            */
           
		/*
			String id=request.getParameter("id");
            String password=request.getParameter("password");
            MemberVO vo=MemberDAO.getInstance().deleteMember(password);
            if(vo!==)
            
			return "redirect:front?command=delete-confirm-fail";
			*/
    		HttpSession session = request.getSession(false);  // false를 써줘야 session이 새로 안 생기고 기존에 있던 session 에서 mvo를 가져옴	
    		MemberVO mvo =(MemberVO) session.getAttribute("mvo");
    		String password=mvo.getPassword();  // session 에서 가져온 password
    		String pass=request.getParameter("password");  // 입력받은 password
    		if(password==pass) {
    			return "redirect:front?command=deleteMember";
    		}else {
    			return "redirect:views/member/delete-confirm-fail.jsp";
    		}

        
	}

}
