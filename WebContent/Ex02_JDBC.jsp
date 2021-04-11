<%@page import="java.util.Scanner"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 지금 작업은 원래 servlet(자바코드)에서 하는 작업이다. --> 
   
<%
	//1. 인터페이스 생성
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	//예외처리
	try{
		//2. 드라이버 로딩(자동화)
		Class.forName("oracle.jdbc.OracleDriver");
		System.out.println("Oracle 로딩..");
		
		//3. 연결객체 생성
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","BITUSER","1004");
		System.out.println("연결여부 : flase = " + conn.isClosed());
		
		//4. 명령객체 생성
		stmt = conn.createStatement();
		
		//4.1 parameter 설정 (선택옵션)
		String job = "";
		Scanner sc = new Scanner(System.in);
		System.out.println("직종입력");
		job = sc.nextLine();
		
		//4.2 명령구문생성
		String sql = "select empno, ename, job from emp where job='" + job + "'"; //where job=''
		
		//5. 명령실행
		//DQL(select) -> stmt.executeQuery(sql) >> return ResultSet 타입의 객체주소를 리턴
		//DML(insert, delete, update) -> stmt.executeUpdate() >> return 반영된 행의 개수(결과집합x)
		//                                                        --> delete from emp; 실행하면 return 14		
		rs = stmt.executeQuery(sql);	
		
		/*
			<명령처리>
			DQL(select) : 1. 결과가 없는 경우 (where empno=111)
						  2. 결과가 1건인 경우 (PK, Unique 컬럼 조회 : where empno=7788)
						  3. 결과가 여러건인 경우 (select empno, ename from where deptno=20)
		
		
		1. 간단하고 단순한 방법 (단점 : 결과집합이 없는 경우에 대한 로직처리가 안된다.)
		
			while(rs.next()) { // 너 결과row가 있니? 없으면 while문을 타지 않는다.
				//rs.getInt("empno"); 출력
			}
		
			
		2. 결과가 있는 경우와 없는 경우를 처리(단점 : 데이터 1건밖에 조회되지 않는다. 반복x)
		
			if(rs.next()){
				//rs.getInt("empno"); 출력
			}else {
				//조회된 데이터가 없습니다.
			}
		
		*/
		
		//6. 명령처리 (1번 2번의 장점을 합해서 이렇게 사용한다!)
		if(rs.next()){
			
			do{
				//컬럼의 순서 [1][2][3][4] -> rs.getInt(1) 이렇게써도 출력가능하다.
				System.out.println(rs.getInt("empno") + "," + rs.getString("ename") + "," + rs.getString("job"));
			}while(rs.next()); 
			
		}else {
			System.out.println("조회된 데이터가 없습니다.");
		}
		
	}catch(Exception e){
		System.out.println(e.getMessage());
	}finally{
		//7. 자원해제
		try{
			stmt.close();
			rs.close();
			conn.close();
		}catch(Exception e){
			
		}
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>