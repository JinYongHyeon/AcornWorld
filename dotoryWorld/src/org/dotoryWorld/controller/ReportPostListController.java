package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.ListVO;
import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class ReportPostListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, 
			HttpServletResponse response) throws Exception {
		String categoryNo=request.getParameter("categoryNo");
		int totalPostCount=PostDAO.getInstance().getTotalReportPostCount(categoryNo);
		System.out.println(totalPostCount);
		String pageNo=request.getParameter("pageNo");
		PagingBean pagingBean=null; 
		int postCountPerPage=15;
		int pageCountPerPageGroup=9;
		if(pageNo==null)
			pagingBean=new PagingBean(totalPostCount, postCountPerPage, pageCountPerPageGroup);
		else
			pagingBean=new PagingBean(totalPostCount,Integer.parseInt(pageNo), postCountPerPage, pageCountPerPageGroup);
		ArrayList<PostVO> list = PostDAO.getInstance().getReportPostingList(pagingBean, categoryNo);
		System.out.println(list.size()); // test 용 추후 삭제
		ListVO lvo = new ListVO(list, pagingBean);
		request.setAttribute("lvo", lvo);
		request.setAttribute("url", "/views/board/report-postList.jsp");
		System.out.println("reportPostListController 작동"); // test용 추후 삭제
		return "/views/template/main-layout.jsp";
	}

}
