package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.ListVO;
import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class MyPostListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if(request.getParameter("keyword")!=null&&request.getParameter("keyword")!="") {
			return "front?command=searchMyPost";
		}
		HttpSession session=request.getSession(false);
		if(session==null||session.getAttribute("mvo")==null){
			return "redirect:index.jsp";
		}
		MemberVO mvo = (MemberVO) session.getAttribute("mvo");
		String userId = mvo.getId();
		int totalPostCount = PostDAO.getInstance().getTotalPostCountById(userId);
		String pageNo = request.getParameter("pageNo");
		PagingBean  pagingBean = null;
		int postCountPerPage = 15; // 한 페이지에 보이는 게시물의 수를 설정하는 변수
		int pageCountPerPageGroup = 9; // 한 페이지 그룹에 보이는 페이지의 수를 설정하는 변수
		
		if(pageNo==null) {
			pagingBean = new PagingBean(totalPostCount, postCountPerPage, pageCountPerPageGroup);
		} else {
			pagingBean = new PagingBean(totalPostCount, Integer.parseInt(pageNo), postCountPerPage, pageCountPerPageGroup );
		}
		ArrayList<PostVO> list = PostDAO.getInstance().getPostingListById(pagingBean, userId);		
		ListVO listVO = new ListVO(list, pagingBean);
		request.setAttribute("postingListPaging", listVO);
		request.setAttribute("url", "/views/board/my-post-list-form.jsp");		
		return "/views/template/main-layout.jsp";
	}
}
