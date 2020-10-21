package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.BoardVO;
import org.dotoryWorld.model.PostDAO;

public class MainController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<BoardVO> bestList = PostDAO.getInstance().bestBoardList();//베스트
		ArrayList<BoardVO> hotList = PostDAO.getInstance().hotBoardList();//핫
		request.setAttribute("bestList", bestList);
		request.setAttribute("hotList", hotList);
		
		
		request.setAttribute("url", "/views/home.jsp");
		return "views/template/main-layout.jsp";
	}

}
