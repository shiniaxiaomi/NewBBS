<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javax.swing.text.AbstractDocument.LeafElement"%>
<%@ page language="java" contentType="text/html; charset=gbk" pageEncoding="gbk"%>
<%@ page import="java.util.*,java.sql.*,Util.*" %>

<% 
request.setCharacterEncoding("gbk");//������gbk����ʽ�ύ�����ݿ�

boolean logined=false;
String admin=(String)session.getAttribute("admin");
if(admin!=null && admin.equals("true")){
	logined=true;
}
%>

<%
String strId=request.getParameter("id");
if(strId==null || strId.trim().equals("")){
	out.println("Error ID!");
	return;
}
int id=0;
try{
	id=Integer.parseInt(strId);
}catch(NumberFormatException e){
	out.println("Error ID Again!");
	return;
}




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
String sql_1="select count(*) from article where rootid= "+id;
Statement stmtPage=DB.creatStmt(con);
ResultSet rsPage=DB.executeQuery(stmtPage, sql_1);
rsPage.next();
int totalRecords=rsPage.getInt(1);
totalPages=totalRecords/PAGE_SIZE+1;
if(pageNo>totalPages) pageNo=totalPages;


int startPos=(pageNo-1)*PAGE_SIZE;
String sql="select * from article where rootid= "+id+" order by pdate limit "+startPos+","+PAGE_SIZE;
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
/*
int rootid=0;
if(articles.size()>0){
	Article a=articles.get(0);
	if(a!=null){
		rootid=a.getRootid();
	}
}*/


DB.close(rsPage);
DB.close(stmtPage);
DB.close(rs);
DB.close(stmt);
DB.close(con);

int num;
String strNum=request.getParameter("num");
if(strNum==null){
	num=0;
}else{
	try{
		num=Integer.parseInt(strNum);
	}catch(NumberFormatException e){
		num=0;
	}
}

if(num>(totalPages-1)*PAGE_SIZE){
	num=(totalPages-1)*PAGE_SIZE;
}



%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java����_������̳|ChinaJavaWorld������̳ : ��ѧjava��һ���⣡��������ܰ�æһ�� ...</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?threadID=744236">
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td width="140"><a href="http://bbs.chinajavaworld.com/index.jspa"><img src="images/header-left.gif" alt="Java|Java����_������̳|ChinaJavaWorld������̳" border="0"></a></td>
      <td><img src="images/header-stretch.gif" alt="" border="0" height="57" width="100%"></td>
      <td width="1%"><img src="images/header-right.gif" alt="" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-flatpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><p class="jive-breadcrumbs"> <a href="articleFlat.jsp">������ҳ</a> </p>
          <p class="jive-page-title"> ����: </p></td>
        <td width="1%"><div class="jive-accountbox"></div></td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><a href="http://bbs.chinajavaworld.com/post%21reply.jspa?threadID=744236"><img src="images/reply-16x16.gif" alt="�ظ�������" border="0" height="16" width="16"></a></td>
          <td class="jive-icon-label"><a id="jive-reply-thread" href="reply.jsp?rootid=<%=id %>&replyType=<%="flat" %>">�ظ�������</a> </td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>


  	 <td><span class="nobreak"> �ܹ�<%=totalPages %>ҳ:-
          <span class="jive-paginator"> [ 
	          	<a href="articleDetailFlat.jsp?pageNo=<%=pageNo-1 %>&id=<%=id %>&num=<%=num-PAGE_SIZE%>">��һҳ</a> | 
	          	
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
	          		<a href="articleDetailFlat.jsp?pageNo=<%=i %>&id=<%=id %>&num=<%=(i-1)*PAGE_SIZE%>" class=""><%=i %></a> 
	          	<%
	          	}
	          	%>
	          	
	          	| <a href="articleDetailFlat.jsp?pageNo=<%=pageNo+1 %>&id=<%=id %>&num=<%=num+PAGE_SIZE%>">��һҳ</a> ] 
	          	<a href="articleDetailFlat.jsp?pageNo=1&id=<%=id %>&num=<%=0%>">��ҳ</a> | 
	          	<a href="articleDetailFlat.jsp?pageNo=<%=totalPages %>&id=<%=id %>&num=<%=(totalPages-1)*PAGE_SIZE%>">βҳ</a> |
	          	��<%=pageNo %>ҳ
          	</span> </span> </td>
  
          	
          	
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div id="jive-message-holder">
            <div class="jive-message-list">
              <div class="jive-table">
                <div class="jive-messagebox">
                
                
                <%
				for(Iterator<Article> it=articles.iterator();it.hasNext();){
					Article a=it.next();
				%>
                
                  <table summary="Message" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tbody>
                      <tr id="jive-message-780144" class="jive-odd" valign="top">
                        <td class="jive-first" width="1%">
						<!-- ������Ϣ��table -->
						<table border="0" cellpadding="0" cellspacing="0" width="150">
                            <tbody>
                              <tr>
                                <td><table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tbody>
                                      <tr valign="top">
                                        <td style="padding: 0px;" width="1%"><nobr> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=215489" title="ŵ���׿�">ŵ���׿�</a> </nobr> </td>
                                        <td style="padding: 0px;" width="99%"><img class="jive-status-level-image" src="images/level3.gif" title="��������" alt="" border="0"><br>
                                        </td>
                                      </tr>
                                    </tbody>
                                  </table>
                                  <img class="jive-avatar" src="images/avatar-display.png" alt="" border="0"> <br>
                                  <br>
                                  <span class="jive-description"> ����:
                                  34 <br>
                                  ����: 100<br>
                                  ע��:
                                  07-5-10 <br>
                                  <a href="http://blog.chinajavaworld.com/u/215489" target="_blank"><font color="red">�����ҵ�Blog</font></a> </span> </td>
                              </tr>
                            </tbody>
                          </table>
						  <!--������Ϣtable����-->
						  
						  </td>
                        <td class="jive-last" width="99%"  " style="width: 868px; "><table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tbody>
                              <tr valign="top">
                                <td width="90%" >
                                <% 
                                String str="";
                                if(num==0){
                                	str="¥��:--------���� : ";
                                }else {
                                	str="��"+num+"¥:--------���� : ";
                                }
                                %>
                                <%=str+a.getTitle() %>
                                </td>

                                     <td class="jive-icon" style="width: 96px; "><img src="images/reply-16x16.gif"  border="0" height="16" width="16">
                                     	<a href="reply.jsp?id=<%=a.getId() %>&rootid=<%=a.getRootid() %>&replyType=flat" title="�ظ�������">�ظ�</a>  
                                     	
                                     	<% 
                                     	
                                     	//FileUtil.writeTime(logined, true);
                                     	if(logined){
                                     	%>
                                     		&nbsp;&nbsp;<a href="modify.jsp?id=<%=a.getId() %>&modifyType=<%="flatDetail" %>&rootid=<%=a.getRootid() %>">����</a> 
                                     		&nbsp;&nbsp;<a href="Delete.jsp?id=<%=a.getId() %>&pid=<%=a.getPid() %>&deleteType=<%="flatDetail" %>">ɾ��</a>                          	
                                     	<%
                                     	}
                                     	%>
                                     	
                                     	
                                     </td>
 
                              </tr>
                              <tr>
                                <td colspan="4" style="border-top: 1px solid rgb(204, 204, 204);"><br>
                                 	 ����:<%=a.getCont() %> <br>
                                  <br>
                                </td>
                              </tr>
                              <tr>
                                <td colspan="4" style="font-size: 9pt;"><img src="images/sigline.gif"><br>
                                  <font color="#568ac2">ѧ�����ǿ�������飬Ը�����һ���ܴ��еõ����֣�</font> <br>
                                </td>
                              </tr>
                        
                            </tbody>
                          </table></td>
                      </tr>
                    </tbody>
                  </table>
                  
                  <%
                  num++;
                  }
                  %>
                  
                </div>
              </div>
            </div>
            <div class="jive-message-list-footer">
              <table border="0" cellpadding="0" cellspacing="0" width="100%">
                <tbody>
                  <tr>
                    <td nowrap="nowrap" width="1%"></td>
                    <td align="center" width="98%"><table border="0" cellpadding="0" cellspacing="0">
                        <tbody>
                          <tr>
                            <td><a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20"><img src="images/arrow-left-16x16.gif" alt="���ص������б�" border="0" height="16" hspace="6" width="16"></a> </td>
                            <td><a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20">���ص������б�</a> </td>
                          </tr>
                        </tbody>
                      </table></td>
                    <td nowrap="nowrap" width="1%">&nbsp;</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div></td>
        
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>
