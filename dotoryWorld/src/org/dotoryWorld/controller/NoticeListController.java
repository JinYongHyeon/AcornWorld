package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.ListVO;
import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class NoticeListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		String categoryNo=request.getParameter("categoryNo");
		int totalPostCount=PostDAO.getInstance().getTotalNoticePostCount(categoryNo);
		String pageNo=request.getParameter("pageNo");
		PagingBean pagingBean=null; 
		int postCountPerPage=3;
		int pageCountPerPageGroup=3;
		if(pageNo==null)
			pagingBean=new PagingBean(totalPostCount, postCountPerPage, pageCountPerPageGroup);
		else
			pagingBean=new PagingBean(totalPostCount,Integer.parseInt(pageNo), postCountPerPage, pageCountPerPageGroup);
		ArrayList<PostVO> noticeList = PostDAO.getInstance().getNoticePostingList(pagingBean, categoryNo);
		ListVO noticeListPaging = new ListVO(noticeList, pagingBean);
		ListVO postingListPaging = (ListVO) request.getAttribute("postingListPaging");
		request.setAttribute("postingListPaging", postingListPaging);
		request.setAttribute("noticeListPaging", noticeListPaging);
		request.setAttribute("url", "/board/list.jsp");
		request.setAttribute("url", "/views/board/post-list.jsp");		
		return "/views/template/main-layout.jsp";
	}

}
