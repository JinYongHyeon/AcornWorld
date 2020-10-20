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
		
		
		HttpSession session = request.getSession(false);
		MemberVO nowMemberInfo = (MemberVO) session.getAttribute("mvo");
		// 주소 변경 여부 확인
		// updateAddress == " " 로 확인시 문제 발생함.
		if(updateAddress.contentEquals(" ")) {
			updateAddress = nowMemberInfo.getAddress();
		}
		// 비밀번호 변경 여부 확인
		if (updatePassword =="") {
			updatePassword = nowMemberInfo.getPassword();
		}
		
		MemberVO updateMember 
		= new MemberVO(updateId, updatePassword, updateName, updateAddress,
				updateEmail, null, null, null, null);
		
		// 회원정보 DB 데이터 수정
		MemberDAO.getInstance().updateMemberInfo(updateMember);
		
		// session에 있는 mvo값 덮어 쓰기
		MemberVO memberVO = MemberDAO.getInstance().login(updateId, updatePassword);
		session.setAttribute("mvo", memberVO);
	
		return "redirect:front?command=main";
	}

}
