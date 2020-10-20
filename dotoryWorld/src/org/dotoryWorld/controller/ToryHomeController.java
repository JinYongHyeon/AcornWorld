package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.ToryhomeVO;

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
		
		// 방명록 가져오기(작성 예정)
		ToryhomeVO toryhomeVO = MemberDAO.getInstance().ToryHomeLetterInformation(toryHomeMVO);
		
		
		
		return "views/template/tory-layout.jsp";
	}

}
