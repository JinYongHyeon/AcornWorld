<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.*"%>
<%@page import="java.util.UUID"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	//파일정보
	String sFileInfo = "";
	//파일명을 받는다 - 일반 원본파일명
	String filename = request.getHeader("file-name");
	//파일 확장자
	String filename_ext = filename.substring(filename.lastIndexOf(".") + 1);
	//확장자를소문자로 변경
	filename_ext = filename_ext.toLowerCase();

	//이미지 검증 배열변수
	String[] allow_file = { "jpg","jpeg" ,"png", "bmp", "gif" };

	//돌리면서 확장자가 이미지인지 
	int cnt = 0;
	for (int i = 0; i < allow_file.length; i++) {
		if (filename_ext.equals(allow_file[i])) {
			cnt++;
		}
	}

	//이미지가 아님
	if (cnt == 0) {
		out.println("NOTALLOW_" + filename);
	} else {
		//이미지이므로 신규 파일로 디렉토리 설정 및 업로드   
		//파일 기본경로
		String dftFilePath = request.getSession().getServletContext().getRealPath("/");
		//파일 기본경로 _ 상세경로
		String filePath = dftFilePath + "resources" + File.separator + "img" + File.separator;
		//String filePath2 =  "C:"+File.separator+"Users"+File.separator+"yonghyeon"+File.separator+"DotoryWorld"+File.separator+"dotoryWorld"+File.separator+"WebContent"+File.separator+"resources"+File.separator+"img"+File.separator;
		File file = new File(filePath);
		//File file2 = new File(filePath2);
		if (!file.exists()) {
			file.mkdirs();
		}//else if(!file2.exists()){
		//	file2.mkdirs();
	//	}
		String realFileNm = "";
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String today = formatter.format(new java.util.Date());
		realFileNm = today + UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
		String rlFileNm = filePath + realFileNm;
		//String rlFileNm2 = filePath2 + realFileNm;
		///////////////// 서버에 파일쓰기 ///////////////// 
		InputStream is = request.getInputStream();
		OutputStream os = new FileOutputStream(rlFileNm);
		//OutputStream os2 = new FileOutputStream(rlFileNm2);
		int numRead;
		byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
		while ((numRead = is.read(b, 0, b.length)) != -1) {
			os.write(b, 0, numRead);
		//	os2.write(b, 0, numRead);
		//System.out.println(filePath2);
			
		}
		if (is != null) {
			is.close();
		}
		os.flush();
		//os2.flush();
		os.close();
		//os2.close();
		///////////////// 서버에 파일쓰기 /////////////////

		// 정보 출력
		sFileInfo += "&bNewLine=true";	
		sFileInfo += "&sFileName=" + filename;	
		sFileInfo += "&sFileURL=/dotoryWorld/resources/img/"+realFileNm;
		out.println(sFileInfo);
	}
%>