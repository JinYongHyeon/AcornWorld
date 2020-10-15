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

public class PostListController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String hobbyBoardNo=request.getParameter("hobbyboardNo");
		int totalPostCount = PostDAO.getInstance().getTotalPostCount(hobbyBoardNo);
		String pageNo = request.getParameter("pageNo");
		PagingBean  pagingBean = null;
		int postCountPerPage = 15; // 한 페이지에 보이는 게시물의 수를 설정하는 변수
		int pageCountPerPageGroup = 9; // 한 페이지 그룹에 보이는 페이지의 수를 설정하는 변수
		if(pageNo==null) {
			pagingBean=new PagingBean(totalPostCount, postCountPerPage, pageCountPerPageGroup);
		} else {
			pagingBean = new PagingBean(totalPostCount, Integer.parseInt(pageNo), postCountPerPage, pageCountPerPageGroup );
		}
		ArrayList<PostVO> list = PostDAO.getInstance().getPostingList(pagingBean);		
		ListVO listVO = new ListVO(list, pagingBean);
		request.setAttribute("lvo", listVO);
		// 세션 의미부여
		HttpSession session = request.getSession();
		// 임시 세션 추후 삭제
		session.setAttribute("mvo", new MemberVO("java","java","java","java","java","java","java","java","java"));
		session.setAttribute("noList",new ArrayList<String>());
		//request.setAttribute("url", "/board/list.jsp");		
		//return "/template/layout.jsp";
		return "/views/board/post-list.jsp";
	}

}
