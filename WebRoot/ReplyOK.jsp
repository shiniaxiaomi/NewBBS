<%@page import="Util.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<%@ page import="java.sql.*" %>


<% 
request.setCharacterEncoding("utf-8");//设置以utf-8的形式提交到数据库

String type=request.getParameter("replyType");

int id=Integer.parseInt(request.getParameter("id"));
int rootid=Integer.parseInt(request.getParameter("rootid"));
String title=request.getParameter("title");
String cout=request.getParameter("cout");

if(title==null){
	out.println(title);
	out.println("error!please use my bbs in the right way!");
	return ;
}else {
	title=title.trim();
}

if(cout==null){
	out.println(cout);
	out.println("error!please use my bbs in the right way!");
	return ;
}else {
	cout=cout.trim();
}


if(title.equals("")){
	out.println("title could not be empty!");
	return ;
}

if(cout.equals("")){
	out.println("cout could not be empty!");
	return ;
}

cout=cout.replaceAll("\n", "<br>");

Class.forName("com.mysql.jdbc.Driver");
String dbUrl="jdbc:mysql://localhost/bbs?user=root&password=123456";
Connection con=DriverManager.getConnection(dbUrl);

con.setAutoCommit(false);//取消自动提交

String sql="insert into article values(null,?,?,?,?,now(),0)";
Statement stmt=con.createStatement();
PreparedStatement pstmt=con.prepareStatement(sql);
pstmt.setInt(1, id);
pstmt.setInt(2, rootid);
pstmt.setString(3, title);
pstmt.setString(4, cout);
pstmt.executeUpdate();

stmt.execute("update article set isleaf=1 where id="+id);

con.commit();//手动提交
con.setAutoCommit(true);//回复现场

pstmt.close();
stmt.close();
con.close();

//response.sendRedirect("article.jsp");
%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>

回复成功,<font id="time" color="red" size="5">2</font>秒钟自动跳转到主页,如果没有跳转,请点击链接

<script language="JavaScript1.2" type="text/javascript">

<!--
function delayURL(url,time) {

	var delay=document.getElementById("time").innerHTML;
	if(delay>0){
		delay--;
		document.getElementById("time").innerHTML=delay;
	}else {
		window.top.location.href=url;
	}

    setTimeout("delayURL('" + url + "')", 1000);
    
    
    
}

function go() {

	var t="<%=type%>";

	if(t=="flat"){
		delayURL("articleDetailFlat.jsp?id=<%=rootid%>",2000);
	}else if(t=="tree"){
		delayURL("article.jsp",2000);
	}
}

go();

//-->

</script>

<%
if(type!=null && type.equals("tree")){
%>
<a href="article.jsp">主页</a>
<%
}else if(type!=null && type.equals("flat")){
%>
<a href="articleFlat.jsp">主页</a>
<%
}
%>


</body>
</html>