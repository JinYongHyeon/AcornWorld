package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.PostDAO;
import org.dotoryWorld.model.PostVO;

public class AdminManageController implements Controller {
	/**
	 * 게시물 관리자 페이지 이동
	 * 등급이 다람쥐가 아니면 메인 페이지로 이동
	 * 페이지당 10으로 지정 그룹당 페이지는 5로 지정
	 * template 메인
	 */
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null|| session.getAttribute("mvo") == null) {
			return "redirect:front?command=main";
		}else {
			MemberVO mvo = (MemberVO) session.getAttribute("mvo");
			if(!mvo.getGrade().contentEquals("다람쥐"))return "redirect:front?command=main";
			
		}
		String nowPage = request.getParameter("nowPage");
		PagingBean paginBean = null;
		int totalPostCount = PostDAO.getInstance().getAllCountPost();
		int postCountPerPage = 10; //페이지당  게시물 수
		int pageCountPerPageGroup = 5; // 그룹당 페이징 수
		if(nowPage == null) {
			paginBean = new PagingBean(totalPostCount,postCountPerPage,pageCountPerPageGroup);
		}else {
			paginBean = new PagingBean(totalPostCount,Integer.parseInt(nowPage),postCountPerPage,pageCountPerPageGroup);
		}
		
		ArrayList<PostVO> pvoList = PostDAO.getInstance().getAllPostList(paginBean);
		
		request.setAttribute("paginBean", paginBean);
		request.setAttribute("postList", pvoList);
		request.setAttribute("url", "/views/admin/admin-managing-form.jsp");

		return "views/template/main-layout.jsp";
	}

}
