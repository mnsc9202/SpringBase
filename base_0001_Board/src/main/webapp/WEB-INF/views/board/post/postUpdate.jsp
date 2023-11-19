<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mnsc.base.board.dto.board.post.PostResponseDto"%>
<%@page import="mnsc.base.board.dto.member.MemberDto"%>

<%
	/* 게시글 상세 */
	PostResponseDto postDetail = (PostResponseDto)request.getAttribute("postDetail");

	/* 로그인 정보 조회 */
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
		<div class="postDetailContainer">
			
			<!-- 게시글수정 관련 정보 --> 
			<form id="postEditForm" action="updatePost.do" method="post" class="postDetailInfoWrapper" >
				<!-- put 방식 적용 -->
				<input type="hidden" name="_method" id="_put" value="put"/>
				<div>
					<input type="number" id="seq" name="seq" value="<%=postDetail.getSeq()%>" hidden>
					<div class="postDetailTitle">
						<!-- 제목 -->
						<input type="text" id="title" name="title" placeholder="제목을 입력해 주세요." value="<%=postDetail.getTitle()%>">
					</div>
				</div>
				
				<!-- 구분선 -->
				<div class="postDetailInfoDivider">
					<div></div>
				</div>
				
				<!-- 내용 -->
				<textarea rows="" cols="" id="content" name="content" placeholder="내용을 입력해 주세요." class="postDetailContent"><%=postDetail.getContent()%></textarea>
			</form>
			
			<!-- 입력정보 오류내용 -->
			<div id="checkInputError"></div>
			
			<div class="optionButtonsWrapper">
			<%
			if(loginUserInfo.getId().equals(postDetail.getWriter())){
			%>	
				<!-- 수정 버튼 -->
				<button type="button" class="postWriteBtn" onclick="onPostUpdateBtnClick()">
					<span class="buttonIcon material-symbols-outlined">edit</span>
					수정
				</button>
				
				<!-- 삭제 버튼 -->
				<button type="button" class="postDeleteBtn" onclick="onPostEditCancleBtnClick(<%=postDetail.getSeq()%>)">
					<span class="buttonIcon material-symbols-outlined">close</span>
					취소
				</button>
			<%
			}
			%>			
			</div>
		</div>
		
		<script type="text/javascript">
		
			/* 수정 버튼 클릭시 */
			function onPostUpdateBtnClick(){
				// 입력한 제목, 내용 조회
				const title = $("#title").val().trim()
				const content = $("#content").val().trim()
				
				// 입력값 확인 (빈값 여부)
				if(title === ""){
					$("#checkInputError").text("제목을 입력해주세요")
				}else if (content === ""){
					$("#checkInputError").text("내용을 입력해주세요")
				}else{
					$("#postEditForm").submit()					
				}
			}
			
			/* 취소 버튼 클릭시 */
			function onPostEditCancleBtnClick(seq){
				location.href=`${pageContext.request.contextPath}/findPostDetail.do?seq=\${seq}`
			}
		</script>

	</body>
</html>