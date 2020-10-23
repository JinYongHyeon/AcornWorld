package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.PostDAO;

public class LikeController implements Controller {
	/**
	 * 좋아요 기능
	 * 커뮤니티 게시물 번호와 아이디를 가지고 좋아요 여부를 체크 후 좋아요 상태면 마이너스 그렇지 않을경우 플러스
	 */
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("mvo") == null) return "front?command=main";
		
		String id = request.getParameter("id");
		String no = request.getParameter("no");
		//커뮤니티 게시물 번호와 아이디를 가지고 좋아요 여부를 체크
		int count = PostDAO.getInstance().postLikeCheck(id,no);
		String like = null;
		if(count == 1) {
			//마이너스
			PostDAO.getInstance().postLikeRemove(id, no);
			PostDAO.getInstance().postLikeMinus(no);
			like="down";
		}else {
			//플러스
			PostDAO.getInstance().postLike(id, no);
			PostDAO.getInstance().postLikeUp(no);
			like="up";
		}
		request.setAttribute("responsebody", like);
		return "/AjaxView";
	}

}

