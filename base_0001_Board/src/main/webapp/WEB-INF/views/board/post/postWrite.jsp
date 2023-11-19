<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mnsc.base.board.dto.member.MemberDto"%>

<!-- 로그인 정보 조회 -->
<%
	MemberDto loginUserInfo = (MemberDto)request.getSession().getAttribute("loginUserInfo");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="shortcut icon" href="resources/image/favicon.ico">
		<!-- jquery -->
		<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="resources/css/color.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/postStyle.css" />
		
		<!-- icons -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
		<title>mnsc</title>
	</head>
	
	<body>
		<div class="postWriteContainer">
			<div class="postWriteTitle">
				<span class="material-symbols-outlined">contract_edit</span>
				글쓰기
			</div>
			
			<!-- 게시글작성 관련 입력 정보 --> 
			<form id="postWriteForm" action="savePost.do" method="post" class="postWriteFormWrapper">
				<div>
					<input type="text" id="writer" name="writer" value="<%=loginUserInfo.getId()%>" readonly hidden>
					<input type="text" id="boardNo" name="boardNo" value="1" readonly hidden>
				</div>
				<input type="text" id="title" name="title" placeholder="제목을 입력해 주세요.">
				<textarea rows="" cols="" id="content" name="content" placeholder="내용을 입력해 주세요."></textarea>
			</form>
			
			<!-- 입력정보 오류내용 -->
			<div id="checkInputError"></div>
			
			<div class="optionButtonsWrapper">
				<!-- 작성 버튼 -->
				<button type="button" onclick="onPostWriteBtnClick()">
					<span class="buttonIcon material-symbols-outlined">done</span>
					작성
				</button>
				
				<!-- 취소 버튼 -->
				<button type="button" onclick="onPostWriteCancleBtnClick()">
					<span class="buttonIcon material-symbols-outlined">close</span>
					취소
				</button>			
			</div>
			
		</div>
		
		<script type="text/javascript">
		
			/* 작성 버튼 클릭시 */
			function onPostWriteBtnClick(){
				// 입력한 제목, 내용 조회
				const title = $("#title").val().trim()
				const content = $("#content").val().trim()
				
				// 입력값 확인 (빈값 여부)
				if(title === ""){
					$("#checkInputError").text("제목을 입력해주세요")
				}else if (content === ""){
					$("#checkInputError").text("내용을 입력해주세요")
				}else{
					$("#postWriteForm").submit()				
				}				
			}
			
			/* 취소 버튼 클릭시 */
			function onPostWriteCancleBtnClick(){
				location.href=`${pageContext.request.contextPath}/findPostList.do`
			}			
		</script>
	</body>
</html>