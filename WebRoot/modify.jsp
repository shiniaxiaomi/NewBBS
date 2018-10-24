<%@page import="Util.FileUtil"%>
<%@page import="java.io.File"%>
<%@page import="Util.DB"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("utf-8");//设置以utf-8的形式提交到数据库

String admin=(String)session.getAttribute("admin");
if(admin==null || !admin.equals("true")){
	response.sendRedirect("Login.jsp");
	return;
}
%>


<%
String modifyType=request.getParameter("modifyType");

String modify=request.getParameter("modify");
if(modify!=null && modify.equals("true")){

	String title=request.getParameter("title");
	String cont=request.getParameter("cont");
	int id=Integer.parseInt(request.getParameter("id"));

	Connection con=DB.getCon();
	PreparedStatement pstmt=con.prepareStatement("update article set title=?,cont=? where id=?");
	pstmt.setString(1, title);
	pstmt.setString(2, cont);
	pstmt.setInt(3, id);
	pstmt.executeUpdate();
		
	DB.close(pstmt);
	DB.close(con);
	
	if(modifyType!=null){
		if(modifyType.equals("flat")){
			response.sendRedirect("articleFlat.jsp");
		}else if(modifyType.equals("flatDetail")){
			
			String url="articleDetailFlat.jsp?id="+request.getParameter("rootid");
			
			response.sendRedirect(url);
		}else if(modifyType.equals("tree")){
			response.sendRedirect("article.jsp");
		}
	}
	
	
	
	return ;
}
%>


<% 
int id=Integer.parseInt(request.getParameter("id"));

Connection con=DB.getCon();

Statement stmt=DB.creatStmt(con);
ResultSet rs=stmt.executeQuery("select * from article where id="+id);
rs.next();
String title=rs.getString("title");
String cont=rs.getString("cont");

rs.close();
stmt.close();
con.close();


%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>


<form name="modify" action="modify.jsp" method="post" onsubmit="return check()">
	<input type="hidden" name="id" value="<%=id %>">
	<input type="hidden" name="modify" value="true">
	<input type="hidden" name="rootid" value="<%=request.getParameter("rootid") %>">
	<input type="hidden" name="modifyType" value="<%=modifyType %>">
	<table>
		<tr>
			<td>
				标题:<input type="text" name="title" size="60" value="<%=title %>">
			</td>
		</tr>
		<tr>
			<td>
				内容:<textarea rows="12" cols="80" name="cont" size="60"><%=cont %></textarea>
			</td>
		</tr>
		<tr>	
			<td>
				<input type="submit" value="提交">
			</td>
		</tr>
	</table>


</form>



</body>
</html>