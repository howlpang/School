<%@page import="dao.ProfessorDao"%>
<%@page import="vo.Student"%>
<%@page import="dao.StudentDao"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 요청 파라미터 값 조회
	String type = request.getParameter("type");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
		//사용자 인증하기
		StudentDao studentDao = StudentDao.getInstance();
		//ProfessorDao professorDao = ProfessorDao.getInstance();
		boolean isExist = false;
		String dbPassword = null;
	
	
		//사용자 정보가 존재하는지 체크
		if("STUDENT".equals(type)){
		Student student = studentDao.getStudentById(id);
		if(student != null){
			isExist= true;
			dbPassword = student.getPassword();
		
		}
			
		}else if("PROFESSOR".equals(type)){
			//Professor professor = professorDao.getProfessorById(id);
			//if(professor != null){
			//	isExist= true;
			//dbPassword = professor.getPassword();			
		//	}
		}	
		
		// 비밀번호가 일치하는지 체크
		if(!isExist){
			response.sendRedirect("loginform.jsp?err=fail");
			return;
		}
		if(!dbPassword.equals(password)){
			response.sendRedirect("loginform.jsp?err=fail");
			return;
		}
		
		//사용자 인증이 완료되면 세션에 로그인타입과 로그인아이디를 저장하기
		session.setAttribute("loginType", type);
		session.setAttribute("loginId", id);
	
		// 재요청 URL 응답 보내기
		response.sendRedirect("home.jsp");
%>