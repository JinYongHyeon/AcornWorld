package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.ListVO;
import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class PostListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int totalPostCount = PostDAO.getInstance().getTotalPostCount();
		String pageNo = request.getParameter("pageNo");
		PagingBean  pagingBean = null;
		if(pageNo==null) {
			pagingBean=new PagingBean(totalPostCount);
		} else {
			pagingBean = new PagingBean(totalPostCount, Integer.parseInt(pageNo));
		}
		ArrayList<PostVO> list = PostDAO.getInstance().getPostingList(pagingBean);		
		ListVO listVO = new ListVO(list, pagingBean);
		request.setAttribute("lvo", listVO);
		//request.setAttribute("url", "/board/list.jsp");		
		//return "/template/layout.jsp";
		return "/views/board/post-list.jsp";
	}

}
