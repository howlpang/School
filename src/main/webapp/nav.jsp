<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	//1. 세션에 저장된 로그인 타입, 로그인 아이디 조회하기
	String loginType = (String) session.getAttribute("loginType");
	String loginId = (String) session.getAttribute("loginId");
	
	//2. 요청파라미터 조회하기
	String menu = request.getParameter("menu");
%>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark mb-3">
	<div class="container">
    	<ul class="navbar-nav me-auto">
        	<li class="nav-item"><a class="nav-link <%="홈".equals(menu)? "active" : "" %>" href="/app5/home.jsp">홈</a></li>
<%
	if("STUDENT".equals(loginType)){
%>        	
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle <%="학생".equals(menu)? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	학생
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app5/student/course-list.jsp">모든 과정 조회</a></li>
            		<li><a class="dropdown-item" href="/app5/student/course-registration-list.jsp">신청현황 조회</a></li>
          		</ul>
        	</li>   
<%
	} else if("PROFESSOR".equals(loginType)){
%>     	
			<li class="nav-item dropdown ">
          		<a class="nav-link dropdown-toggle <%="교수".equals(menu)? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	교수
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app5/professor/course-list.jsp">개설한 과정 조회</a></li>
            		<li><a class="dropdown-item" href="/app5/professor/course-form.jsp">과정 등록</a></li>
          		</ul>
        	</li>
<%
	}
%>        	
      	</ul>
 <%
 	if(loginType !=null){
 %>	
 	<span class="navbar-text me-5">
 		<strong class="text-white bolder"><%=loginId %></strong>님 환영합니다.
 	</span>	
 <% 		
 	}
 %>     	
      	<ul class="navbar-nav">
<%
	if(loginType == null){
%>      	
         	<li class="nav-item"><a class="nav-link <%="로그인".equals(menu)? "active" : "" %> " href="/app5/loginform.jsp">로그인</a></li>
			<li class="nav-item dropdown">
          		<a class="nav-link dropdown-toggle <%="회원가입".equals(menu)? "active" : "" %>" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            	사용자 등록
          		</a>
          		<ul class="dropdown-menu">
            		<li><a class="dropdown-item" href="/app5/student/form.jsp">학생</a></li>
            		<li><a class="dropdown-item" href="/app5/professor/form.jsp">교수</a></li>
          		</ul>
        	</li>
<%
	}else {
%>        	
         	<li class="nav-item"><a class="nav-link " href="/app5/logout.jsp">로그아웃</a></li>
<%
	}
%>         	
      	</ul>
   	</div>
</nav>