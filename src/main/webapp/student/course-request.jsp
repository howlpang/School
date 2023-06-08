<%@page import="vo.Student"%>
<%@page import="vo.Registration"%>
<%@page import="vo.Course"%>
<%@page import="dao.CourseDao"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 과정 신청을 처리한다.
	// 요청 URL
	//localhost/app5/student/course-request.jsp?cno=xxx
	
	// 세션에서 로그인된 사용자 정보 조회
	String loginType= (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	if(loginType == null){
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("수강신청","utf-8"));
		return;
	}
	// 3. 로그인된 사용자가 학생인지 체크하기
	if(!"STUDENT".equals(loginType)){
		response.sendRedirect("../home.jsp?err=deny&job="+URLEncoder.encode("수강신청","utf-8"));
	}
	//4. 요청파라미터 값 조회하기
	int courseNo = Integer.parseInt(request.getParameter("cno"));
	// 5. 요청파라미터로 전달받은 값을 Registration객체를 생성해서 담기
	CourseDao courseDao = CourseDao.getInstance();
	Course course = courseDao.getCourseDetailByNo(courseNo);
	// 6. 모집인원과 신청자수 체크하기
	if(course.getQuota() == course.getReqCnt()){
		response.sendRedirect("course-list.jsp?err=full");
		return;
	}
	//7. Registraion객체를 생성해서 과정정보와 학생정보 담기
	Registration registration = new Registration();
	registration.setCourse(course);
	
	Student student = new Student();
	student.setId(loginId);
	registration.setStudent(student);
	
	//8. 수강신청 처리
	RegistrationDao registraionDao = RegistrationDao.getInstance();
	registraionDao.insertRegistraion(registration);
	
	//9. 해당과정의 신청자수를 1증가 시키고, 테이블에 반영시키기
	course.setReqCnt(course.getReqCnt() + 1);
	courseDao.updateCourse(course);
	
	//10. 재요청 URL 응답
	response.sendRedirect("course-registration-list.jsp");
	
%>