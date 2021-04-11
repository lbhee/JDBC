<%@page import="kr.or.bit.SingletonHelper"%>
<%@page import="kr.or.bit.ConnectionHelper"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	conn = ConnectionHelper.getConnection("oracle");
	System.out.println(conn);
	//conn.close();
	
	conn = ConnectionHelper.getConnetion("oracle", "hr", "1004"); //오버로딩
	System.out.println(conn); //위와 같은 객체일까? 다르다!
	
	
	//5개의 페이지에서 모두 DB연결이 필요할때 >> ConnectionHelper.getConnection("oracle");
	//5개의 객체를 생성하지말고 하나의 연결객체를 만들어서 사용하면 되지 않을까?
	//singleton (학습용/실제현업에서는 DB작업에서 싱글톤을 쓰지않는다!)
	Connection conn2 = null;
	conn2 = SingletonHelper.getConnection("oracle");
	
	Connection conn3 = null;
	conn3 = SingletonHelper.getConnection("oracle");
	
	System.out.println(conn2);
	System.out.println(conn3);
	System.out.println(conn2 == conn3);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	연결여부 : <%=conn.isClosed() %><br>
	
	재정의   : <%=conn.toString() %><br>
	ProductName : <%=conn.getMetaData().getDatabaseProductName() %><br>
	ProductVersion : <%=conn.getMetaData().getDatabaseProductVersion() %><br>
</body>
</html>