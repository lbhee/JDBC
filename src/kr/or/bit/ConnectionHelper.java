package kr.or.bit;

import java.sql.Connection;
import java.sql.DriverManager;

/*
	<전체 프로젝트>
	 - 회원관리 : 전체조회, 조건조회, 회원삭제, 신규회원 삽입, 회원수정
	
	각각의 작업을 하기 위한 공통적인 작업요소
	 1. 드라이버 로딩
	 2. 연결객체 생성, 명령객체 생성
	 3. 자원해지
	반복적으로 사용
	
	================================
	개선(리팩토링 : 반복적인 코드의 제거)
	 - 모든 페이지가 가지고 있는 공통적인 요소를 한곳에 모으자.
	   공통적인 내용을 가지는 클래스를 만들자.
	 - 자주사용하는 함수 -> static > overloading > 다형성

*/
public class ConnectionHelper {
	
	public static Connection getConnection(String dsn) { //oracle, mysql.. 어떤 DB가 오던 연결가능하게 Connection인터페이스 사용
		Connection conn = null;
		try {
			if(dsn.equals("oracle")) {
				Class.forName("oracle.jdbc.OracleDriver");
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","BITUSER","1004");
			}else if(dsn.equals("mysql")) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://192.168.0.218:3306/sampledb?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=true","BITUSER","1004");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}

	//오버로딩
	public static Connection getConnetion(String dsn , String id , String pwd) {
		 Connection conn = null;
		 try {
			 if(dsn.equals("oracle")) {
		    Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.218:1521:xe",id,pwd);
		 }else if(dsn.equals("mysql")) {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    conn = DriverManager.getConnection("jdbc:mysql://192.168.0.218:3306/sampledb?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=true",id,pwd);
			 }
		 }catch (Exception e) {
			System.out.println(e.getMessage());
		 }
		 
		 return conn;
	}
}