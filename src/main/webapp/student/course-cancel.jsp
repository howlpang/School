<%@page import="vo.Course"%>
<%@page import="dao.CourseDao"%>
<%@page import="vo.Registration"%>
<%@page import="dao.RegistrationDao"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	// 수강취소 처리를 한다.
	// 요청 URL
	// localhost/app5/student/course-cancel.jsp?rno=xxx
	
	// 세션에서 로그인된 사용자 정보 조회
	String loginType= (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	if(loginType == null){
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("수강신청취소","utf-8"));
		return;
	}
	// 3. 로그인된 사용자가 학생인지 체크하기
	if(!"STUDENT".equals(loginType)){
		response.sendRedirect("../home.jsp?err=deny&job="+URLEncoder.encode("수강신청취소","utf-8"));
	}
	// 4. 요청 파라미터 조회하기
	int registrationNo = Integer.parseInt(request.getParameter("rno"));
	
	// 5. 요청파라미터로 전달받은 수강신청번호로 수강신청 상세정보 조회한다.
	RegistrationDao registrationDao = RegistrationDao.getInstance();
	Registration reg = registrationDao.getRegistrationByRegNo(registrationNo);
	
	// 6. 상태정보를 "수강취소"로 변경하고, 테이블에 반영시킨다.
	reg.setStatus("수강취소");
	registrationDao.updateRegistration(reg);
	
	//7. 수강신청 정보에서 과정번호를 조회하고, 과정번호로 과정 상세정보를 조회한다.
	int courseNo = reg.getCourse().getNo();
	CourseDao courseDao = CourseDao.getInstance();
	Course course = courseDao.getCourseDetailByNo(courseNo);
	//8. 과정정보의 신청자수를 1감소시킨다.
	course.setReqCnt(course.getReqCnt() -1);
	courseDao.updateCourse(course);
	
	
	response.sendRedirect("course-registration-list.jsp");
%>