package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberVO;

public class UpdateMemberInfoController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String updateId = request.getParameter("updateId");
		String updatePassword = request.getParameter("updatePassword");
		String updateName = request.getParameter("updateName");
		String updateAddress = request.getParameter("updateAddress");
		updateAddress += " "+request.getParameter("updateAddressDetail");
		String updateEmail = request.getParameter("updateEmail");
		String updateNick = request.getParameter("updateNick");
		String updateIntro = request.getParameter("updateIntro");
		
		
		MemberVO updateMember 
		= new MemberVO(updateId, updatePassword, updateName, updateAddress, updateEmail, updateNick, updateIntro, null, "도토리");
		// 데이터 넘어오는 것 확인
		System.out.println(updateMember.toString());
		
		return null;
	}

}
