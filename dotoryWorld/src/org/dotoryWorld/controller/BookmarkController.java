
package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.BookmarkVO;
import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class BookmarkController implements Controller {
	/**
	 * 북마크 추가 INSERT 성공 되면 1 이상 실패 시 0
	 */
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(false);
		if(session == null || session.getAttribute("mvo") == null)return "front?command=main";
		String id = request.getParameter("id");
		String link = request.getParameter("link");
		String bookmark = request.getParameter("bookmark");
		String title = request.getParameter("title");
		String message = null;

		BookmarkVO mark = new BookmarkVO();
		mark.setBookmarkLink(link);
		mark.setBookmarkDivide(bookmark);

		MemberVO mvo = new MemberVO();
		mvo.setId(id);

		mark.setMemberVO(mvo);
	
		if (MemberDAO.getInstance().bookmarkCheck(mark).contains(link)) {
			 message="중복";
		} else {
			int coin = MemberDAO.getInstance().addBookMark(mark);
		
			if (coin > 0) {
				message = "성공";
			} else {
				message = "실패";
			}
		}
		request.setAttribute("responsebody", message);

		return "/AjaxView";
	}

}
