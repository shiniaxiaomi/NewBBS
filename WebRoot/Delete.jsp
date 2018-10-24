<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="java.sql.*" %>

<%
String admin=(String)session.getAttribute("admin");
if(admin==null || !admin.equals("true")){
	response.sendRedirect("Login.jsp");
	return;
}
%>

<%!
private void delete(Connection con,int id){//递归
	
	Statement stmt=null;
	ResultSet rs=null;
	
	try{
		stmt=con.createStatement();
		String sql="select * from article where pid="+id;
		rs=stmt.executeQuery(sql);
		while(rs.next()){
			delete(con,rs.getInt("id"));
		}
		stmt.executeUpdate("delete from article where id="+id);
		
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		try{
			if(rs!=null){
				rs.close();
				rs=null;
			}
			if(stmt!=null){
				stmt.close();
				stmt=null;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
}
%>


<% 
String type=request.getParameter("deleteType");
int id=Integer.parseInt(request.getParameter("id"));
int pid=Integer.parseInt(request.getParameter("pid"));

Class.forName("com.mysql.jdbc.Driver");
String dbUrl="jdbc:mysql://localhost/bbs?user=root&password=123456";
Connection con=DriverManager.getConnection(dbUrl);

con.setAutoCommit(false);//取消自动提交


delete(con,id);
Statement stmt=con.createStatement();
ResultSet rs=stmt.executeQuery("select count(*) from article where pid="+pid);
rs.next();
int count=rs.getInt(1);

rs.close();
stmt.close();

if(count<=0){
	Statement stmtUpdate=con.createStatement();
	stmtUpdate.executeUpdate("update article set isleaf=0 where id="+pid);
	stmtUpdate.close();
}


con.commit();//手动提交
con.setAutoCommit(true);//回复现场

con.close();




if(type!=null && type.equals("tree")){
	response.sendRedirect("article.jsp");
}else if(type!=null && type.equals("flat")){
	response.sendRedirect("articleFlat.jsp");
}else if(type!=null && type.equals("flatDetail")){

	String url="articleDetailFlat.jsp?id="+pid;

	response.sendRedirect(url);
}



%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>