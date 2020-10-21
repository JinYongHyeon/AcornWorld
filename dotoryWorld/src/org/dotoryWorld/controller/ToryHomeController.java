package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PagingBean;
import org.dotoryWorld.model.ToryLetterListVO;
import org.dotoryWorld.model.ToryhomeVO;

import jdk.management.resource.internal.TotalResourceContext;

public class ToryHomeController implements Controller {
	/**
	 * 미니홈피 가기 아이디 값을 DAO에 보내 정보를 가져와 미니홈피에 전달
	 * template 미니홈피 레이아웃 사용
	 */
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("mvo") == null) {
			System.out.println("session null");
			return "redirect:front?command=main";
		}
		//방명록 정보 가져와야됨.
		MemberVO toryHomeMVO = MemberDAO.getInstance().addToryHomeInformation(request.getParameter("id"));
		if(toryHomeMVO != null) {
		request.setAttribute("toryHomeImformation",toryHomeMVO);
		request.setAttribute("url", "/views/torihomepage/tory-letterList.jsp");
		}else {
			System.out.println("toryHomeNVO null");
			return "redirect:front?command=main";
		}
		
		// 방명록 정보 가저오기, 페이징
		int tototalLetterCount = MemberDAO.getInstance().getTotalLetterCount(request.getParameter("id"));
		String letterPageNo=request.getParameter("LetterPateNo");
		PagingBean letterPaging = null;
		if (letterPageNo==null) {
			letterPaging = new PagingBean(tototalLetterCount);
		}else {
			letterPaging = new PagingBean(tototalLetterCount, Integer.parseInt(letterPageNo), 3, 5);
		}
		ArrayList<ToryhomeVO> toryLetterList = MemberDAO.getInstance().toryHomeLetterList(request.getParameter("id"), letterPaging);
		ToryLetterListVO LetterVO = new ToryLetterListVO(toryLetterList, letterPaging);
		request.setAttribute("toryLvo", LetterVO);		
		
		
		return "views/template/tory-layout.jsp";
	}

}
