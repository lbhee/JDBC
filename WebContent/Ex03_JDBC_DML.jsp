<%@page import="java.util.Scanner"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	/*
		DML (insert, update, delete)
		JDBC API를 통해서 작업
		 1. 결과 집합이 없다.
		 2. 반영된 행의 수를 리턴한다.
		 
		 update emp set sal = 0 실행                      -> return 14
		 update emp set sal = 100 where empno = 1111 실행 -> return 0
		
		KEY POINT
		1. oracle DME (developer, dbever, cmd 등) Tool에서 작업하면 기본 옵션이 commit or rollback 강제한다.
		2. JDBC API에서 DML작업을 하면 default가 auto commint이다.
		3. java코드에서 delete from emp 실행하면 자동commit..DB에 실반영
		4. commit과 rollback을 명시적으로 자바코드에서 제어가능하다. (필요하다면 auto commit속성을 false로 바꾸면 된다.)
		
		<트렌젝션 : 하나의 논리적인 단위로 묶기>
		시작
			A계좌 인출(update)
			...
			B계좌 입금(update)
		종료	
	*/
	
	/*
	create table dmlemp
	as select * from emp;

	select * from dmlemp;
	
	alter table dmlemp
	add constraint pk_dmemp_empno primary key(empno);
	*/
	
	Connection conn = null;
	Statement stmt = null;
	//DML작업은결과집합이 없으므로 ResultSet이 필요없다.
	
	try{
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","BITUSER","1004");
		System.out.println("연결여부 : flase = " + conn.isClosed());
		
		stmt = conn.createStatement();
		
		
		//INSERT
		
		int empno = 0;
		String ename = "";
		int deptno = 0;
		
		Scanner sc = new Scanner(System.in);
		System.out.println("사번 입력");
		empno = Integer.parseInt(sc.nextLine());
		
		System.out.println("이름 입력");
		ename = sc.nextLine();
		
		System.out.println("부서번호 입력");
		deptno = Integer.parseInt(sc.nextLine());
		
		//insert into emp(empno, ename, deptno) values(200, '홍길동' 30);
		String sql = "insert into dmlemp(empno, ename, deptno)";
		sql += "values(" + empno + ",'" + ename + "'," + deptno + ")"; //옛날방법...
		
		int resultrow = stmt.executeUpdate(sql);
		 
		
		//UPDATE
		/*
		int deptno = 50; //20-> 반영행 6개, 50 -> 반영된 행이 없습니다.
		String sql = "update dmlemp set sal = 0 where deptno=" + deptno;
		int resultrow = stmt.executeUpdate(sql);
		*/
		
		
		//DELETE
		/* 
		int deptno = 20; 
		String sql = "delete from dmlemp where deptno=" + deptno;
		int resultrow = stmt.executeUpdate(sql);
		*/
		
		if(resultrow > 0) {
			System.out.println("반영된 행의 수 : " + resultrow);
		}else {
			//**예외가 생긴것이 아니라 반영된 행이 없다는 것이다.**
			System.out.println("반영된 행이 없습니다.");
		}

	}catch(Exception e){
		//**예외발생에 대한 코드처리는 여기서 해줘야한다.**
		//컬럼명 불일치, 테이블명 불일치, 제약사항(PK, Unique)일 때
		System.out.println(e.getMessage());
	}finally{
		if(stmt != null)try {stmt.close();}catch (Exception e) {}
		if(conn != null)try {conn.close();}catch (Exception e) {}
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