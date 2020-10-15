package org.dotoryWorld.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dotoryWorld.model.MemberDAO;

public class IdCheckController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		boolean flag=MemberDAO.getInstance().idcheck(id);
		// 사용불가한 아이디
		String result="fail";
		if(flag==false)
			//사용가능한 아이디
			result="ok";		
		request.setAttribute("responsebody", result);
		//ajax 방식으로 응답 
		return "AjaxView";
	}
}
