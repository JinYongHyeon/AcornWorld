package org.dotoryWorld.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

/**
 * 게시물 검색 서블릿 ㅠㅠ.. 
 */
@WebServlet("/PostSearchServlet")
public class PostSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String postTitle = request.getParameter("postTitle");
		response.getWriter().write(getJSON(postTitle));
	}
	public String getJSON(String postTitle) {
		if(postTitle==null) postTitle="";
		StringBuffer result=new StringBuffer("");
		result.append("{\"result\":[");
		PostDAO postDAO = new PostDAO();
		ArrayList<PostVO> list = new ArrayList<PostVO>();
		for (int i = 0; i < list.size(); i++) {
			result.append("[{\"value\":\""+list.get(i).getPostTitle()+"\"}],");
		}
		result.append("]}");
		return result.toString();
	}

}





