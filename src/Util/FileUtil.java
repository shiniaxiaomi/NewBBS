package Util;

import java.io.FileWriter;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;

public class FileUtil {
	
	static FileWriter writer;
	
	public static void writeTime(Object obj,boolean b){
		
		Date date = new Date() ;
		DateFormat time = DateFormat.getDateTimeInstance();
		String s = time.format(date);
		
		if(obj==null){
			FileUtil.writeOnce(s+" : "+"传进来的参数是一个null值\r\n", true);
		}else {
			FileUtil.writeOnce(s+" : "+obj.toString()+"\r\n", true);
		}
	}
	
	public static void writeOnce(Object obj,boolean b){//只写一次
		
		try {
			writer = new FileWriter("C:/Users/lyj80/Desktop/buff.txt",b);
			writer.write(obj.toString()+"\r\n");
			writer.flush();
			writer.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public static void newWriter(boolean b){
		
		try {
			writer = new FileWriter("C:/Users/lyj80/Desktop/buff.txt",b);
		} catch (IOException e) {
			e.printStackTrace();
		}
	
	}

	public static void write(String str){ 
	
	    try {
	        writer.write(str+"\r\n");
	        
	    } catch (IOException e) {
	        e.printStackTrace();
	    }	
		
	}
	
	public static void close(){
		
		try {
			writer.flush();
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
}
