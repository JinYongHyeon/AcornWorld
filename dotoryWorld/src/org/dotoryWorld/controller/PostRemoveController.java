package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.PostDAO;

public class PostRemoveController implements Controller {

	@Override
	public String execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null||
				request.getMethod().equals("POST")==false){
			return "redirect:index.jsp";
		}
		String no=request.getParameter("no");
		PostDAO.getInstance().deletePosting(Integer.parseInt(no));
		String bno=request.getParameter("bno");
		// 게시물 목록을 보여주기 위해
		// path를 front?command=postList setting하고
		// 리다이렉트 방식으로 이동시킨다. 
		return "redirect:front?command=postList&hobbyBoardNo="+bno;
	}
}
