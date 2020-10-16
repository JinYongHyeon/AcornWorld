package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.BoardVO;
import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class PostWriteController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		/*if(session==null||session.getAttribute("mvo")==null||request.getMethod().equals("POST")==false){
			return "redirect:index.jsp";
		}*/
		String title = request.getParameter("title");
		String content = request.getParameter("content");
				
		PostVO pvo=new PostVO();
		pvo.setPostTitle(title);
		pvo.setPostContent(content);

		BoardVO bvo = new BoardVO();
		bvo.setBoardNo(request.getParameter("boardNo"));
		pvo.setBoardVO(bvo);

		MemberVO mvo = new MemberVO();
		mvo.setId("user1");
		pvo.setMemberVO(mvo);
		
		//pvo.setMemberVO((MemberVO)session.getAttribute("mvo"));		

		PostDAO.getInstance().postWrite(pvo);		
		String path="redirect:front?command=PostDetailNoHits&no="+pvo.getPostNo();
		return path;
	}

}
