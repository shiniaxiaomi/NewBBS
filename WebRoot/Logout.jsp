<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="Util.*"%>
        
<%

	session.setAttribute("admin", "false");
	String type=(String)session.getAttribute("type");
	
	FileUtil.writeTime(type, true);
	
	if(type!=null && type.equals("flat")){
		response.sendRedirect("articleFlat.jsp");
	}else if(type!=null && type.equals("tree")){
		response.sendRedirect("article.jsp");
	}
	

%>
    
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8">
<title>Insert title here</title>
</head>
<body>
注销用户
</body>
</html>