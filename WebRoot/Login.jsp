<%@page import="Util.FileUtil"%>
<%@page import="java.awt.BufferCapabilities.FlipContents"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
String useName=request.getParameter("username");
String passWord=request.getParameter("password");
if(useName==null || !useName.equals("admin")){
	%>		
	<font color="black" size 20>用户名不正确</font>
	<%
}else if(passWord==null || !passWord.equals("admin")){
	%>		
	<font color="black" size 20>密码不正确</font>
	<%
}else {
	session.setAttribute("admin", "true");
	
	String type=(String)session.getAttribute("type");
	
	FileUtil.writeTime(type, true);
	
	if(type!=null && type.equals("flat")){
		response.sendRedirect("articleFlat.jsp");
	}else if(type!=null && type.equals("tree")){
		response.sendRedirect("article.jsp");
	}	
}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>后台管理</title>
<link href="./Login/login.css" rel="stylesheet" type="text/css">
</head>
<body>

<div class="login_box">
      <div class="login_l_img"><img src="./Login/login-img.png"></div>
      <div class="login">
          <div class="login_logo"><img src="./Login/login_logo.png"></div>
          <div class="login_name">
               <p style="height: 15px; ">后台管理系统 </p>
               <p>用户名:admin 密码:admin</p>
          </div>
          <form action="Login.jsp" method="post">          
              <input name="username" type="text" value="用户名" onfocus="this.value=&#39;&#39;" onblur="if(this.value==&#39;&#39;){this.value=&#39;用户名&#39;}">
              <span id="password_text" onclick="this.style.display=&#39;none&#39;;document.getElementById(&#39;password&#39;).style.display=&#39;block&#39;;document.getElementById(&#39;password&#39;).focus().select();">密码</span>
			  <input name="password" type="password" id="password" style="display:none;" onblur="if(this.value==&#39;&#39;){document.getElementById(&#39;password_text&#39;).style.display=&#39;block&#39;;this.style.display=&#39;none&#39;};">
              <input value="登录" style="width:100%;" type="submit">
          </form>
      </div>
</div>



</body>
</html>