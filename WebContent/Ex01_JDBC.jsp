<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--
	JDBC
		1. Java를 통해서 Oracle 연결 하고 CRUD 작업
		
		2. 어떤한 DB 소프트웨어 사용 결정 (Oracle , mysql , ms-sql) 
		   제품에 맞는 드라이버필요 (각 벤더 사이트에서 다운로드 받아서 사용)
		   오라클다운받으면 드라이버설치되어있음.  >> ojdbc6.jar >> 프로젝트에서 WebContent - WEB-INF - lib에 드라이버 넣는다.
		   C:\oraclexe\app\oracle\product\11.2.0\server\jdbc\lib
		   
		   MYSQL사용한다면 드라이버 설치 필요 -> https://www.mysql.com/products/connector
		   
		3. Cmd 기반의 Java Project 에서는 드라이버 사용하기 위해서 참조 
		   java Build Path (jar 추가) 하는 작업
		   드라이버 사용준비 완료 >> 드라이버 사용할 수 있도록 메모리 (new ..)
		   class.forName("class 이름") >> new 동일한 효과 : jdk1.6버전 이상부터는 자동화되었음.
		    
		4. JAVA ( JDBC API)
		   import java.sql.*; 제공하는 자원 (대부분의 자원은 : interface , class)
		   개발자는 interface 를 통해서 작업 ( 궁긍증 : why interface 일까? hint)java 뿐만 아니라 다양한 언어 사용 )
		5. DB연결 -> 명령 -> 실행 -> 처리 -> 자원해제
		   명령 (CRUD) : select , insert , update , delete
		   처리 : select 화면 출력할꺼야 아니야 난 확인만 ...........
		   자원해제 (성능)
	
	*연결 문자열 (ConnectionString) 설정
	 채팅 (client -> server 연결하기 위해서)
	 네트워크 DB (서버 IP , PORT , SID(전역 데이터베이스 이름) , 접속계정 , 접속 비번)
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>부서번호</th><th>부서명</th><th>부서위치</th>
		</tr>
	
		<%
			Class.forName("oracle.jdbc.OracleDriver"); //jdk1.6버전 이상부터는 자동으로 로딩됨.
			Connection conn = null; //Connection인터페이스
			
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","BITUSER","1004");
			//jdbc:oracle:thin:@192.168.0.60:1521:xe
			//접속이 성공되면 new연결객체 생성 -> 이객체의 주소를 리턴한다.(Connection인터페이스에게)
			
			//.getConnection을 통해서 생성되는 연결객체는 무엇을 구현하고 있을까?
			//다형성(JDCB API) - oracle을 쓰든, mysql을 쓰든 가능하다.
			//Myconn implements Connection
			//Oracleconn impliments Connection
			
			//이렇게 되면 확장성이 힘들다. 오라클만 가능하다. 
			//OracleConnection conn = null;
			//conn = DriverManager.getConnection 
			
			out.print("false(정상연결) : " + conn.isClosed()); //연결됬으면 false
			//conn.close();
			//out.print(conn.isClosed()); //연결끊어지면 true
			
			//명령(CRUD)
			Statement stmt = conn.createStatement();
			
			//명령
			String sql = "select deptno, dname, loc from dept";
			
			//실행
			ResultSet rs = stmt.executeQuery(sql); //DB서버에서 실행되고 결과를 생성
			//ResultSet 연결된 DB서버의 데이터를 조회할 수 있다.
			
			//처리(화면에 출력)
			while(rs.next()) { //생성된 row가 있니(데이터가있니?)
				//System.out.println(rs.getInt("deptno") + " / " + rs.getString("dname") + " / " + rs.getString("loc"));
		%>
			<tr>
				<td><%=rs.getInt("deptno") %></td>
				<td><%=rs.getString("dname") %></td>
				<td><%=rs.getString("loc") %></td>
			</tr>
		<%
			}
			
			stmt.close();
			rs.close();
			conn.close();
			out.print("True(연결해제) : " + conn.isClosed());
		%>
	</table>
</body>
</html>