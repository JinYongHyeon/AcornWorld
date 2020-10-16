package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class SearchPostController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String title=request.getParameter("keyWord");
		ArrayList<PostVO> pvo= PostDAO.getInstance().searchPost(title);
		request.setAttribute("pvo", pvo);
		return "/views/board/post-list.jsp";
	}

}
