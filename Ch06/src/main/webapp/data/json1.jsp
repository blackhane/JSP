<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//JSON 데이터 생성
	String jsonData = "{\"uid\":\"a101\", \"name\":\"홍길동\", \"hp\":\"010-1111-2222\", \"age\":\"20\"}";
	//JSON 데이터 출력
	out.print(jsonData);
%>