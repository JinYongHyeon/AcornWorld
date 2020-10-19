package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class PostUpdateController implements Controller {

	@Override
	public String execute(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null||
				request.getMethod().equals("POST")==false){
			return "redirect:index.jsp";
		}	
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		PostVO vo=new PostVO();
		vo.setPostNo(request.getParameter("no"));
		vo.setPostTitle(title);
		vo.setPostContent(content);
		PostDAO.getInstance().updatePosting(vo);			
		String path="redirect:front?command=postDetail&no="+vo.getPostNo();
		return path;
	}
}
