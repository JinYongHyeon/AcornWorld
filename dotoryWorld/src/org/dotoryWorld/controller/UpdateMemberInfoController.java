package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class UpdateMemberInfoController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// update-form.jsp 에서 전달 받은 Parameter 값
		String updateId = request.getParameter("nowId");
		String updatePassword = request.getParameter("updatePassword");
		String updateName = request.getParameter("updateName");
		String updateAddress = request.getParameter("updateAddress");
		updateAddress += " "+request.getParameter("updateAddressDetail");
		String updateEmail = request.getParameter("updateEmail");
		
		MemberVO updateMember 
		= new MemberVO(updateId, updatePassword, updateName, updateAddress,
				updateEmail, null, null, null, null);
		
		// 회원정보 DB 데이터 수정
		// 패스워드를 변경했을 때와 변경하지 않았을 때의 경우를 구분함.
		if (updatePassword =="") {
			MemberDAO.getInstance().updateMemberInfoNoPassword(updateMember);
		}else {
			MemberDAO.getInstance().updateMemberInfo(updateMember);
		}
		
		// session에 있는 mvo값 덮어 쓰기
		MemberVO memberVO = MemberDAO.getInstance().login(updateId, updatePassword);
		HttpSession session = request.getSession();
		session.setAttribute("mvo", memberVO);
	
		return "redirect:front?command=main";
	}

}
