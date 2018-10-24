package Util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.util.Date;

public class DB {
	
	public static void main(String[] args) {

		
		
		
		String sql="select * from article where pid=0";
		Connection con=DB.getCon();
		Statement stmt=DB.creatStmt(con);
		ResultSet rs=DB.executeQuery(stmt, sql);
		
		FileUtil.newWriter(false);
		
		try {
			while(rs.next()){
				
				FileUtil.write(rs.getString("title"));

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		FileUtil.close();
		
		FileUtil.writeOnce("写入完毕", true);


	}

	public static Connection getCon(){
		
		Connection con=null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");

			String dbUrl="jdbc:mysql://localhost/bbs?user=root&password=123456";
			con=DriverManager.getConnection(dbUrl);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return con;
	}
	
	
	public static Statement creatStmt(Connection con){
		Statement stmt=null;
		
		try {
			stmt=con.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return stmt;
	}
	
	public static ResultSet executeQuery(Statement stmt,String sql){
		
		ResultSet rs=null;
		
		try {
			rs=stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rs;
	}
	
	
	public static void close(Connection con){
		
		if(con!=null){
			
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			con=null;
		}
		
	}
	
	public static void close(Statement stmt){
		
		if(stmt!=null){
			
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			stmt=null;
		}
		
	}
	
	
	public static void close(ResultSet rs){
		
		if(rs!=null){
			
			try {
				rs.close();
			} catch (SQLException 
					e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			rs=null;
		}
		
	}
	
//	public void iii(){
//		
//		ArrayList<Article> articles=new ArrayList<Article>();
//		Iterator<Article> it=articles.iterator();
//		
//		
//	}
	
	
}















