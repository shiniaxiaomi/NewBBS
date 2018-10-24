<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.swing.text.AbstractDocument.LeafElement"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,java.sql.*,Util.*" %>

<% 
request.setCharacterEncoding("utf-8");//设置以utf-8的形式提交到数据库

session.setAttribute("type", "flat");

boolean logined=false;
String admin=(String)session.getAttribute("admin");
if(admin!=null && admin.equals("true")){
	logined=true;
}
%>

<%
List<Article> articles=new ArrayList<Article>();

final int PAGE_SIZE=8;
int pageNo=1;
String strPageNo=request.getParameter("pageNo");
if(strPageNo!=null && !strPageNo.trim().equals("")){
	try{
		pageNo=Integer.parseInt(strPageNo);
	}catch(NumberFormatException e){
		pageNo=1;
	}
}

if(pageNo<=0)	pageNo=1;
int totalPages=0;
Connection con=DB.getCon();
String sql_1="select count(*) from article where pid=0";
Statement stmtPage=DB.creatStmt(con);
ResultSet rsPage=DB.executeQuery(stmtPage, sql_1);
rsPage.next();
int totalRecords=rsPage.getInt(1);
if(totalRecords%PAGE_SIZE==0){
	totalPages=totalRecords/PAGE_SIZE;
}else{
	totalPages=totalRecords/PAGE_SIZE+1;
}
if(pageNo>totalPages) pageNo=totalPages;


int startPos=(pageNo-1)*PAGE_SIZE;
String sql="select * from article where pid=0 order by pdate limit "+startPos+","+PAGE_SIZE;
Statement stmt=DB.creatStmt(con);
ResultSet rs=DB.executeQuery(stmt, sql);
while(rs.next()){
	Article a=new Article();
	a.setId(rs.getInt("id"));
	a.setPid(rs.getInt("pid"));
	a.setRootid(rs.getInt("rootid"));
	a.setTitle(rs.getString("title"));
	a.setCont(rs.getString("cont"));
	a.setLeaf(rs.getInt("isleaf")==0?true:false);
	a.setPdate(rs.getTimestamp("pdate"));
	articles.add(a);
	
}

DB.close(rsPage);
DB.close(stmtPage);
DB.close(rs);
DB.close(stmt);
DB.close(con);
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>BBS首页</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?forumID=20">
<script language="JavaScript" type="text/javascript" src="images/common.js"></script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td width="140"><a href=""><img src="images/header-left.gif" alt="Java|Java世界_中文论坛|ChinaJavaWorld技术论坛" border="0"></a></td>
      <td><img src="images/header-stretch.gif" alt="" border="0" height="57" width="100%"></td>
      <td width="1%"><img src="images/header-right.gif" alt="" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-forumpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="98%"><p class="jive-breadcrumbs">论坛: Java语言*初级版
            (模仿)</p>
          <p class="jive-description"> 探讨Java语言基础知识,基本语法等 大家一起交流 共同提高！谢绝任何形式的广告 </p>
          </td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
  
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><a href="http://bbs.chinajavaworld.com/post%21default.jspa?forumID=20"><img src="images/post-16x16.gif" alt="发表新主题" border="0" height="16" width="16"></a></td>
          <td class="jive-icon-label"><a id="jive-post-thread" href="post.jsp?replyType=flat">发表新主题</a> </td>
		  <td><a href="Login.jsp">登入</a></td>
          <td>&nbsp;&nbsp;<a href="Logout.jsp">注销</a> </td>
          <td>&nbsp;&nbsp;<a href="articleFlat.jsp" >平板展示</a> </td>
          <td>&nbsp;&nbsp;<a href="article.jsp" >树状展示</a> </td>
        </tr>
        
      </tbody>
    </table> 
    
    
 
          

    
  </div>
  <br>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td><span class="nobreak"> 总共<%=totalPages %>页:-
          <span class="jive-paginator"> [ 
	          	<a href="articleFlat.jsp?pageNo=<%=pageNo-1 %>">上一页</a> | 
	          	
	          	<%
	          	int size=5;
	          	int start=1;
	          	int stop=5;
	          	
	          	while(pageNo>stop){
	          		start+=size;
	          		stop+=size;
	          	}
	          	
	          	for(int i=start;i<=stop;i++){
	          		if(i>totalPages) break;
	          	%>
	          		<a href="articleFlat.jsp?pageNo=<%=i %>" class=""><%=i %></a> 
	          	<%
	          	}
	          	%>
	          	
	          	| <a href="articleFlat.jsp?pageNo=<%=pageNo+1 %>">下一页</a> ] 
	          	<a href="articleFlat.jsp?pageNo=1">首页</a> | 
	          	<a href="articleFlat.jsp?pageNo=<%=totalPages %>">尾页</a> |
	          	第<%=pageNo %>页
          	</span> </span> </td>
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div class="jive-thread-list">
            <div class="jive-table">
              <table summary="List of threads" cellpadding="0" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th class="jive-first" colspan="3"> 主题 </th>
                    <th class="jive-author"> <nobr> 作者
                      &nbsp; </nobr> </th>
                    <th class="jive-view-count"> <nobr> 浏览
                      &nbsp; </nobr> </th>
                    <th class="jive-msg-count" nowrap="nowrap"> 回复 </th>
                    <th class="jive-last" nowrap="nowrap"> 最新帖子 </th>
                  </tr>
                </thead>
                <tbody>
                
                    <%
					for(Iterator<Article> it=articles.iterator();it.hasNext();){
						Article a=it.next();
						String preStr="";
						for(int i=0;i<a.getGrade();i++){
							preStr+="----";
						}
					%>
						<tr class="jive-even">
	                    <td class="jive-first" nowrap="nowrap" width="2%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16"></td>
	                    <%
	                    if(logined){
	                    %>
	                    	<td nowrap="nowrap" width="1%" style="width: 43px; ">
	                    		<a href="modify.jsp?id=<%=a.getId() %>&modifyType=<%="flat" %>">更改</a><br>
	                    		<a href="Delete.jsp?id=<%=a.getId() %>&pid=<%=a.getPid() %>&deleteType=<%="flat" %>">删除</a>
	                 	    </td>
	                    <%
	                    }
	                    %>
	                    <td class="jive-thread-name" width="60%"><a id="jive-thread-1" href="articleDetailFlat.jsp?id=<%=a.getId() %>"><%=preStr+a.getTitle() %></a></td>
	                    <td class="jive-author" nowrap="nowrap" width="10%"><span class=""> <a href="">陆英杰</a></span></td>
	                    <td class="jive-view-count" width="6%"> 10000</td>
	                    <td class="jive-msg-count" width="6%"> 1000</td>
	                    <td class="jive-last" nowrap="nowrap" ><div class="jive-last-post"> <%=new java.text.SimpleDateFormat("yyyy-mm-dd hh:mm:ss").format(a.getPdate()) %> <br>
	                    </tr>    
					<%
					}
                    %> 

                </tbody>
              </table>
            </div>
          </div>
          <div class="jive-legend"></div></td>
      </tr>
    </tbody>
  </table>
  <br>
  <br>
</div>
</body>
</html>
