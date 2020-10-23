package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;
import org.dotoryWorld.model.PostDAO;

public class AdminManageDeleteController implements Controller {
	/**
	 * 체크박스 체크 한 name에 value을 가져와 for loop을 돌려 DAO에서 순차적으로 삭제작업
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
		String no[] = request.getParameterValues("postNo");
		for(int i=0;i<no.length;i++) {
			PostDAO.getInstance().deletePostingsByNo(Integer.parseInt(no[i]));
			MemberDAO.getInstance().bookmarkRemove((no[i]));
		}
		
		return "redirect:front?command=adminManage";
	}

}
