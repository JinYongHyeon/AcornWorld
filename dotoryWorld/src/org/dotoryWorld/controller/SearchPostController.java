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
		String hobbyboardNo = request.getParameter("hobbyBoardNo");
		System.out.println(hobbyboardNo);
		int TotalCount = PostDAO.getInstance().searchPost(title);
		PagingBean pgb=null;
		if(nowPage==null) {
			 pgb = new PagingBean(TotalCount, 15,10);  
		}else {
			 pgb = new PagingBean(TotalCount, Integer.parseInt(nowPage), 15,10);  
		}
		
		ArrayList<PostVO> pvo=PostDAO.getInstance().searchPost(title,hobbyboardNo, pgb);
		ListVO lvo=new ListVO(pvo, pgb);
		request.setAttribute("keyword", title);
		request.setAttribute("hobbyBoardNo", hobbyboardNo);
		request.setAttribute("postingListPaging", lvo);
		request.setAttribute("url", "/views/board/post-list.jsp");
		return "/views/template/main-layout.jsp";
	}

}
