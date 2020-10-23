package org.dotoryWorld.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class AddDotoryController implements Controller {
	
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		/**
		 * ajax을 이용 친구 아이디, 내 아이디를 가져와 추가 하기전 중복 확인 후 이상 없을 시 추가 name : responsebody 로
		 * value : message 중복 시 중복알림 아닐 시 추가 알림
		 */
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("mvo") == null)
			return "redirect:front?command=main";
		String message = null;
		String friendId = request.getParameter("friendId"); // 상대방 아이디
		String id = request.getParameter("id");// 내 아이디

		ArrayList<MemberVO> myDotory = MemberDAO.getInstance().mydotorylist(id);
		ArrayList<String> myDotoryList = new ArrayList<String>();
		for (MemberVO dotory : myDotory) {
			myDotoryList.add(dotory.getId());
		}

		if (myDotoryList.contains(friendId)) {
			message = friendId + "님과 이미 친구추가 되어 있습니다.";
		} else {
			MemberDAO.getInstance().addDotory(friendId, id);
			message = friendId + "님과 친구추가 완료";
		}

		request.setAttribute("responsebody", message);
		return "AjaxView";
	}

}
