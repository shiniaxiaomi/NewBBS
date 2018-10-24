<%@page import="Util.FileUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<% 
request.setCharacterEncoding("utf-8");//设置以utf-8的形式提交到数据库

String type=request.getParameter("replyType");
String strId=request.getParameter("id");
int id=0;
if(strId!=null){
	id=Integer.parseInt(strId);
}
String strRootid=request.getParameter("rootid");
int rootid=0;
if(strRootid!=null){
	rootid=Integer.parseInt(strRootid);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>

<Script type="text/javascript">
	

	function LTrim(str){	//去掉左边的空格
		var i;
		for(i=0;i<str.length;i++){
			if(str.charAt(i)!=' ') break;
		}
		str=str.substring(i,str.length);
		return str;
	}
	
	function RTrim(str){	//去掉右边的空格
		var i;
		for(i=str.length-1;i>=0;i--){
			if(str.charAt(i)!=' ') break;
		}
		str=str.substring(0,i+1);
		return str;
	}
	
	function Trim(str){
		return LTrim(RTrim(str));
	}
	
	function check(){

		if(Trim(document.reply.title.value)==""){
			alert("标题不能为空!");
			document.reply.title.focus();
			return false;
		}
		
		if(Trim(document.reply.cout.value)==""){
			alert("内容不能为空!");
			document.reply.cout.focus();
			return false;
		}
		
		return true;
	
	}

</Script>


</head>
<body>

<form name="reply" action="ReplyOK.jsp?replyType=<%=type %>&rootid=<%=rootid %>" method="post" onsubmit="return check()">
	<input type="hidden" name="id" value="<%=id %>">
	<input type="hidden" name="rootid" value="<%=rootid %>">
	<table>
		<tr>
			<td>
				标题:<input type="text" name="title" size="60">
			</td>
		</tr>
		<tr>
			<td>
				内容:<textarea rows="12" cols="80" name="cout"></textarea>
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