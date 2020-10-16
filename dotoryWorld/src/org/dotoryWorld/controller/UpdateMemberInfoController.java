package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;
import org.dotoryWorld.model.MemberVO;

public class UpdateMemberInfoController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// update-form.jsp 에서 전달 받은 Parameter 값
		String updateId = request.getParameter("updateId");
		String updatePassword = request.getParameter("updatePassword");
		String updateName = request.getParameter("updateName");
		String updateAddress = request.getParameter("updateAddress");
		updateAddress += " "+request.getParameter("updateAddressDetail");
		String updateEmail = request.getParameter("updateEmail");
		
		MemberVO updateMember 
		= new MemberVO(updateId, updatePassword, updateName, updateAddress,
				updateEmail, null, null, null, null);
		
		// 회원정보 DB 데이터 수정
		MemberDAO.getInstance().updateMemberInfo(updateMember);
	
		return "redirect:front?command=main";
	}

}
