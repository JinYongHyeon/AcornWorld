package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.ListVO;
import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class SearchPostController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String title=request.getParameter("keyword");
		String nowPage=request.getParameter("pageNo");
		int TotalCount = PostDAO.getInstance().searchPost(title);
		PagingBean pgb=null;
		if(nowPage==null) {
			 pgb = new PagingBean(TotalCount, 15,5);  
		}else {
			 pgb = new PagingBean(TotalCount, Integer.parseInt(nowPage), 15,5);  
		}
		
		ArrayList<PostVO> pvo=PostDAO.getInstance().searchPost(title, pgb);
		ListVO lvo=new ListVO(pvo, pgb);
		request.setAttribute("lvo", lvo);
		request.setAttribute("keyword", title);
		request.setAttribute("url", "/views/board/post-list.jsp");
		return "/views/template/main-layout.jsp";
	}

}
