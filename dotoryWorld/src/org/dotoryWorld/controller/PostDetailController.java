package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class PostDetailController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null){
			return "redirect:index.jsp";
		}
		String no=request.getParameter("no");
		MemberVO mvo = (MemberVO)session.getAttribute("mvo");
		PostVO vo = PostDAO.getInstance().getPostingByNo(no);		
		
		// 개별 게시물 조회  
		@SuppressWarnings("unchecked")
		ArrayList<String> noList=(ArrayList<String>) session.getAttribute("noList");
		/* 읽은 게시물을 다시 읽었을 때 조회수 증가를 방지하기 위해 
			noList에 게시글번호가 존재하지 않으면 조회수를 증가시킨다. 
		*/
		if(noList.contains(no)==false) {
			PostDAO.getInstance().updateViewcount(no);
			noList.add(no);
		}
		
		/**
		 * 좋아요 체크
		 */
		int count = PostDAO.getInstance().postLikeCheck(mvo.getId(), no);
		String likeCheck = null;
		if(count == 1) {
			likeCheck = "up";
		}else {
			likeCheck = "down";
		}
		
		request.setAttribute("likeCheck", likeCheck);
		request.setAttribute("pvo", vo);
		request.setAttribute("url", "/views/board/post-detail-form.jsp");
		return "/views/template/main-layout.jsp";
	}
}
