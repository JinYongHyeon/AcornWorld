package org.dotoryWorld.controller;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.dotoryWorld.model.MemberDAO;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet(name = "profileUpload", urlPatterns = { "/profileUpload" })
public class ToryProfileImgUploadController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 역할 : MemberDAO에 프로필 주소값 Text를 보내고, MultipartRequest 서버에 이미지 파일을 등록을한다. cos
	 * 라이브러리를 이용하여 MultipartRequest 이미지 업로드 방식
	 * MultipartRequest(request,저장고간,최대용량,한글인코딩,같은이름파일 처리방법 :
	 * DefaultFileRenamePolicy : 자동적으로 중복체크)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session =request.getSession(false);
		if(session == null || session.getAttribute("mvo")==null) response.sendRedirect("front?command=main");

		 String path = request.getSession().getServletContext().getRealPath("/resources/img/profile/");// 최종 주소

		MultipartRequest mutipartRequest = new MultipartRequest(request, path, 10 * 1024 * 1024, "UTF-8",
				new DefaultFileRenamePolicy());
		File profileImg = mutipartRequest.getFile("profileImg");
		String id = mutipartRequest.getParameter("id");
		String message = "실패";
		try {
			int count = MemberDAO.getInstance().toryProfileImgUpload(id, profileImg.getName());// 아이디, 프로필 이미지 Url
			if (count != 0)
				message = profileImg.getName();
			session.setAttribute("mvo",MemberDAO.getInstance().addToryHomeInformation(id));
			
			request.setAttribute("responsebody", message);
			request.getRequestDispatcher("/AjaxView").forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("views/error.jsp");
		}
	}
	
	

}
