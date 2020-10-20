package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PostDAO;

public class DeleteMyDotoryController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		MemberVO mvo = (MemberVO) session.getAttribute("mvo");
		if (session == null || session.getAttribute("mvo")==null) 
			return "redirect:front?command=main";
			
			MemberDAO.getInstance().deleteMydotory(mvo.getId());
			String id[] = request.getParameterValues("friendNo");
			for(int i=0;i<id.length;i++) {
				MemberDAO.getInstance().deleteMydotory(id[i]);
			}
		return "redirect:front?command=myDotoryList&id="+mvo.getId();  //session에서 가져온 내 id를 같이 보냄
	}
	}

