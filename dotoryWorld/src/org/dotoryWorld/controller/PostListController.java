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
		String hobbyBoardNo=request.getParameter("hobbyBoardNo");
		request.setAttribute("hobbyBoardNo", hobbyBoardNo);
		System.out.println("postListC 실행-1"); 
		System.out.println(hobbyBoardNo); // test 용
		int totalPostCount = PostDAO.getInstance().getTotalPostCount(hobbyBoardNo);
		System.out.println(totalPostCount); // test 용
		String pageNo = request.getParameter("pageNo");
		//String postNo = request.getParameter("postNo"); // 게시물이 삭제된 부분의 게시물들을 조회하고자 할때 사용한다????
		PagingBean  pagingBean = null;
		int postCountPerPage = 15; // 한 페이지에 보이는 게시물의 수를 설정하는 변수
		int pageCountPerPageGroup = 9; // 한 페이지 그룹에 보이는 페이지의 수를 설정하는 변수
		if(pageNo==null) {
			pagingBean = new PagingBean(totalPostCount, postCountPerPage, pageCountPerPageGroup);
		} else {
			pagingBean = new PagingBean(totalPostCount, Integer.parseInt(pageNo), postCountPerPage, pageCountPerPageGroup );
		}
		ArrayList<PostVO> list = PostDAO.getInstance().getPostingList(pagingBean, hobbyBoardNo);		
		ListVO listVO = new ListVO(list, pagingBean);
		request.setAttribute("lvo", listVO);
		// 세션 의미부여
		//HttpSession session = request.getSession();
		// 임시 세션 추후 삭제
		//session.setAttribute("mvo", new MemberVO("user2","1234","사용자2","판교","user2@gmail.com","도토리2","도토리2입니다",null,"도토리"));
		//session.setAttribute("noList",new ArrayList<String>());
		request.setAttribute("url", "/views/board/report-postList.jsp");		
		return "/views/template/main-layout.jsp";
	}

}
