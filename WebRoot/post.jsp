<%@page import="Util.*"%>
<%@page import="com.mysql.jdbc.EscapeTokenizer"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@ page import="java.sql.*" %>

<% 
request.setCharacterEncoding("utf-8");//设置以utf-8的形式提交到数据库


String replyType=(String)request.getParameter("replyType");


String action =(String)request.getParameter("post");

if(action!=null && action.equals("post")){


	String title=(String)request.getParameter("title");
	String cout=(String)request.getParameter("cout");
	
		
	cout=cout.replaceAll("\n", "<br>");
	
	Connection con =DB.getCon();
	
	con.setAutoCommit(false);//取消自动提交
	
	String sql="insert into article values(null,0,?,?,?,now(),0)";
	Statement stmt=con.createStatement();
	PreparedStatement pstmt=con.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);

	pstmt.setInt(1, -1);
	pstmt.setString(2, title);
	pstmt.setString(3, cout);
	pstmt.executeUpdate();
	
	ResultSet rsKey=pstmt.getGeneratedKeys();
	rsKey.next();
	int key=rsKey.getInt(1);
	rsKey.close();
	stmt.executeUpdate("update article set rootid="+key+" where id="+key);

	con.commit();//手动提交
	con.setAutoCommit(true);//回复现场
	
	pstmt.close();
	stmt.close();
	con.close();
	
	if(replyType!=null){
		if(replyType.equals("flat")){
			response.sendRedirect("articleFlat.jsp");
		}else if(replyType.equals("tree")){
			response.sendRedirect("article.jsp");
		}
	}
	
	return ;
	
}

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

<form action="post.jsp" method="post">
	<input type="hidden" name="post" value="post">
	<input type="hidden" name="replyType" value="<%=replyType%>">	
	<table>
		<tr>
			<td>
				新主题标题:<input type="text" name="title" size="60">
			</td>
		</tr>
		<tr>
			<td>
				新主题内容:<textarea rows="12" cols="80" name="cout"></textarea>
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