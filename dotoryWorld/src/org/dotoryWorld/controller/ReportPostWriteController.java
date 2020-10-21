package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class ReportPostWriteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null||
				request.getMethod().equals("POST")==false){
			return "redirect:index.jsp";
		}
		String title = request.getParameter("title");
		String content = request.getParameter("content");
				
		PostVO pvo=new PostVO();
		pvo.setPostTitle(title);
		pvo.setPostContent(content);
		pvo.setMemberVO((MemberVO)session.getAttribute("mvo"));		
		
		return "/views/board/report-post-write-form.jsp";
	}

}



