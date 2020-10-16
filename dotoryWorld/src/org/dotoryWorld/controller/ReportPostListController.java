package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class ReportPostListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		String boardNo=request.getParameter("boardNo");
		int totalPostCount=PostDAO.getInstance().getTotalPostCount(boardNo);
		String pageNo=request.getParameter("pageNo");
		PagingBean pagingBean=null;
		int postCountPerPage=15;
		int pageCountPerPageGroup=9;
		if(pageNo==null)
			pagingBean=new PagingBean(totalPostCount, postCountPerPage, pageCountPerPageGroup);
		else
			pagingBean=new PagingBean(totalPostCount,Integer.parseInt(pageNo), postCountPerPage, pageCountPerPageGroup);
		ArrayList<PostVO> list
		=PostDAO.getInstance().getPostingList(pagingBean, boardNo);
	request.setAttribute("lvo", list);
	//request.setAttribute("url", "/board/list.jsp");
System.out.println("reportPostListController 작동");
		
		return "/views/board/report-postList.jsp";
	}

}

