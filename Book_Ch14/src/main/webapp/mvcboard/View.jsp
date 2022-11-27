<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>파일 첨부형 게시판</title>
	</head>
	<body>
		<h2>파일 첨부형 게시판 - 상세 보기(View)</h2>
		<table border="1" width="90%">
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<!-- 게시글 정보 -->
			<tr>
				<td>번호</td>
				<td>idx</td>
				<td>작성자</td>
				<td>name</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td>postdate</td>
				<td>조회수</td>
				<td>visitcount</td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3">title</td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3" height="100">content</td>
			</tr>
			<!-- 첨부파일 -->
			<tr>
				<td>첨부파일</td>
				<td>ofile [다운로드]</td>
				<td>다운로드수</td>
				<td>downcount</td>
			</tr>
			<!-- 하단 메뉴(버튼) -->
			<tr>
				<td colspan="4" align="center">
					<button>수정하기</button>
					<button>삭제하기</button>
					<button>목록 바로가기</button>
				</td>
			</tr>
		</table>
	</body>
</html>