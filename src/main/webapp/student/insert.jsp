<%@page import="vo.Dept"%>
<%@page import="dao.StudentDao"%>
<%@page import="vo.Student"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 학생으로 회원가입 시킨다.
	int grade = Integer.parseInt(request.getParameter("grade"));
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	
	
	//회원가입 업무로직 수행
	StudentDao studentDao = StudentDao.getInstance();
	Student savedStudent= studentDao.getStudentById(id);
	
	// 아이디 중복체크
		if (savedStudent != null) {	// 아이디 중복 발생
			response.sendRedirect("form.jsp?err=dup");
			return;
		}
	// 요청파라미터값을 Student객체를 생성해서 담기
	Student student = new Student();
	student.setGrade(grade);
	student.setId(id);
	student.setPassword(password);
	student.setName(name);
	Dept dept = new Dept();
	dept.setNo(deptNo);
	student.setDept(dept);
	// 학생정보를 테이블에 저장하기
	studentDao.insertStudent(student);
	
	response.sendRedirect("../home.jsp");
%>