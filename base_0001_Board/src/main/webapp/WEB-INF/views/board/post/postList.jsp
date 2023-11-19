<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mnsc.base.board.dto.board.post.PostResponseDto"%>
<%@page import="mnsc.base.board.dto.board.post.PostListRequestDto"%>
<%@page import="java.util.List"%>

<%
	/* 게시글 목록 조회 */
	List<PostResponseDto> postList = (List<PostResponseDto>)request.getAttribute("postList");

	/* 검색정보 조회 */
	PostListRequestDto searchRequest = (PostListRequestDto)request.getAttribute("searchRequest");

	/* 게시물 개수(페이징 x) 조회 */
	Integer postListCnt = (Integer)request.getAttribute("postListCnt");
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
		<div class="postListContainer">
			<div class="postListTitle" onclick="onPostListTitle()">
				<span class="material-symbols-outlined">article</span>
				전체글
			</div>
			
			<!-- 내용 -->
			<div class="contentWrapper">
				<!-- 헤더 -->
				<div class="contentHeader">
					<div>제목</div>
					<div>작성자</div>
					<div>조회수</div>
					<div>작성일</div>
				</div>
				
				<%
				if(postList == null || postList.size() == 0){
				%>
				<div class="contentEmpty">
					<%
					if(searchRequest.getSearchWord() == null){
					%>
						작성된 글이 없습니다
					<%
					}else{
					%>
						'<%=searchRequest.getSearchWord()%>'로 검색된 결과가 없습니다 
					<%
					}
					%>
				</div>
				<%
				} else {
					for(PostResponseDto post: postList){
				%>
						<div class="postWrapper">
							<!-- 제목 -->
							<div>
								<div onclick="onPostTitleClick(<%=post.getSeq()%>)">
									<%=post.getTitle() %>
								</div>
								
								<!-- 댓글 개수 -->
								<%if(post.getCommentCount() > 0){%>
									<div>(<%=post.getCommentCount()%>)</div>
								<%} %>
							</div>
							
							<!-- 작성자 이름 -->
							<div>
								<%=post.getWriterName()%>
							</div>
							
							<!-- 조회수 -->
							<div>
								<%=post.getReadCount() %>
							</div>
							
							<!-- 작성일 -->
							<div>
								<%=post.getCreatedDate().split(" ")[0] %>
							</div>
						</div>
						
						<%
					}
				}
				%>
			</div>
			
			<!-- 페이징 -->
			<div class="pagingWrapper">
				<!-- 이전 페이지 버튼 -->
				<div onclick="onMovePrevPageBtnClick()">
					<span class="material-symbols-outlined">navigate_before</span>
				</div>
				
				<!-- 페이지 버튼 -->
				<div class="pageBtnWrapper">
				</div>
				
				<!-- 다음 페이지 버튼 -->
				<div onclick="onMoveNextPageBtnClick()">
					<span class="material-symbols-outlined">navigate_next</span>
				</div>
			</div>
			
			<!-- 검색 -->
			<div class="searchWrapper">
				<!-- 검색 옵션 -->
				<select id="searchChoice">
					<option value="title">제목</option>
					<option value="content">내용</option>
					<option value="writer">작성자</option>
				</select>
				
				<!-- 검색어 입력 -->
				<input type="text" id="searchWord">
				
				<!-- 검색 버튼 -->
				<button type="button" class="searchBtn" onclick="onSearchBtnClick()">
					<span  class="material-symbols-outlined" >search</span>
					검색
				</button>
			</div>

			<!-- 입력정보 오류내용 -->
			<div class="checkInputErrorWrapper">
				<div id="checkInputError"></div>
			</div>
			
			<!-- 글쓰기 버튼 -->
			<div class="optionButtonsWrapper" >
				<button type="button" onclick="onWriteBtnClick()">
					<span class="buttonIcon material-symbols-outlined">edit</span>
					글쓰기
				</button>
			</div>
		</div>
		
		<script type="text/javascript">
			
			/* document ready */
			$(() => {
				// 페이징 버튼 생성
				onCreatePagingBtn()
				
				// 검색 옵션 초기화
				<%if(searchRequest.getSearchChoice() != null){%>
					$("#searchChoice > option").each((index, item) => {
						const searchChoice = $(item).val()
						if(searchChoice === "<%=searchRequest.getSearchChoice()%>"){
							$(item).attr("selected", true)
						}
					})
				<%}%>
				
				// 검색어 초기화
				<%if(searchRequest.getSearchWord() != null){%>
					$("#searchWord").val("<%=searchRequest.getSearchWord()%>")
				<%}%>
				
			})
		
			/* 글쓰기 버튼 클릭시 */
			function onWriteBtnClick(){
				location.href=`${pageContext.request.contextPath}/savePost.do`
			}
			
			/* 게시글 제목 클릭시 */
			function onPostTitleClick(seq){
				location.href=`${pageContext.request.contextPath}/findPostDetail.do?seq=\${seq}`
			}
			
			/* 검색 버튼 클릭시 */
			function onSearchBtnClick(){
				// 선택, 입력한 검색옵션
				const searchChoice = $("#searchChoice").val()
				const searchWord = $("#searchWord").val()
				
				// 검색어 확인
				if(searchWord.trim() === ""){
					$("#checkInputError").text("올바른 검색어로 입력해주시기 바랍니다")
					return
				}
				
				// 검색옵션 전달
				location.href = `${pageContext.request.contextPath}/findPostList.do?searchChoice=` + searchChoice + "&searchWord=" + searchWord	
			}
			
			/* 전체글 클릭시 */
			function onPostListTitle(){
				location.href = `${pageContext.request.contextPath}/findPostList.do`
			}
			
			/******************** 페이징 (paging) ********************/
			// 게시글 총 개수
			const totalPostSize = <%=postListCnt%> stSize)
			
			// 페이지당 게시글 개수
			const pagePostCnt = <%=searchRequest.getPagePostCnt()%>
					
			// 선택한 페이지 번호
			let selectPageIndex = <%=searchRequest.getSelectPageIndex()%>
					
			// 최대 페이지 번호
			const maxSelectPageIndex = Math.ceil(totalPostSize/pagePostCnt)
				
			// 최대 페이징버튼 개수
			const maxPageBtnCnt = 5
			
			// 페이징 번호
			let pagingIndex = Math.ceil(selectPageIndex/maxPageBtnCnt)
				
			// 최소 페이징 번호
			const minPagingIndex = 1
			
			// 최대 페이징 번호
			const maxPagingIndex = maxSelectPageIndex < maxPageBtnCnt ? 1 : Math.ceil(maxSelectPageIndex/maxPageBtnCnt)
				
			/* 이전 페이지 이동 버튼 클릭시 */
			function onMovePrevPageBtnClick(){
				// 페이징 번호 변경
				const arrangePagingIndex = pagingIndex - 1
				if(arrangePagingIndex < minPagingIndex) return
				pagingIndex = (arrangePagingIndex < minPagingIndex) ? minPagingIndex : arrangePagingIndex
				
				// 선택한 페이지 번호 변경
				selectPageIndex = (pagingIndex) * maxPageBtnCnt
				
				// 페이지 이동
				movePage()
			}
			
			/* 다음 페이지 이동 버튼 클릭시 */
			function onMoveNextPageBtnClick(){
				// 페이징 번호 변경
				const arrangePagingIndex = pagingIndex + 1
				if(arrangePagingIndex > maxPagingIndex) return
				pagingIndex = (arrangePagingIndex > maxPagingIndex) ? maxPagingIndex : arrangePagingIndex
				
				// 선택한 페이지 번호 변경
				selectPageIndex = (pagingIndex - 1) * maxPageBtnCnt + 1
				
				// 페이지 이동
				movePage()
			}
			
			/* 페이징 버튼 클릭시 */
			function onPagingBtnClick(selectIndex){
				selectPageIndex = selectIndex
				
				// 페이지 이동
				movePage()
			}
			
			/* 페이징 버튼 생성 */
			function onCreatePagingBtn(){
				// 페이징 버튼 html
				let pagingBtnHtmlString = ""
				
				// 페이징 버튼 생성 개수
				let loopCnt = 0
				if(pagingIndex < maxPagingIndex){
					loopCnt = maxPageBtnCnt
				}else{
					if(maxPagingIndex === 1){
						loopCnt = maxSelectPageIndex
					}else{						
						loopCnt = maxSelectPageIndex % maxPageBtnCnt
					}
				}

				for(let i=0; i < loopCnt; i++){
					// 페이징 버튼 번호
					const arrangePagingIndex = ((pagingIndex - 1) * maxPageBtnCnt) + i + 1
					pagingBtnHtmlString +=
						`
						<div onclick="onPagingBtnClick(\${arrangePagingIndex})" class="\${(arrangePagingIndex===selectPageIndex) ? 'selectPagingBtn' :''}">
							\${arrangePagingIndex}
						</div>
						`
				}
				// 페이징 버튼 생성				
				$(".pageBtnWrapper").html(pagingBtnHtmlString)
				
				// 이전 페이지 이동버튼 disable 확인
				if(pagingIndex===1) {
					$(".pagingWrapper > div:nth-child(1)").removeAttr("onclick")
					$(".pagingWrapper > div:nth-child(1)").addClass("movePageBtnDisable")
				}else{
					$(".pagingWrapper > div:nth-child(1)").attr("onclick","onMovePrevPageBtnClick()")
					$(".pagingWrapper > div:nth-child(1)").removeClass("movePageBtnDisable")
				}
				
				// 다음 페이지 이동버튼 disable 확인
				if(pagingIndex === maxPagingIndex){
					$(".pagingWrapper > div:nth-last-child(1)").removeAttr("onclick")
					$(".pagingWrapper > div:nth-last-child(1)").addClass("movePageBtnDisable")	
				}else{
					$(".pagingWrapper > div:nth-last-child(1)").attr("onclick","onMoveNextPageBtnClick()")
					$(".pagingWrapper > div:nth-last-child(1)").removeClass("movePageBtnDisable")	
				}
			}
			
			// 페이지 이동
			function movePage(){
				const searchChoice = "<%=searchRequest.getSearchChoice()%>"
				const searchWord = "<%=searchRequest.getSearchWord()%>"
				
				// 검색 조건 입력값 확인
				if(searchChoice == "null" && searchWord == "null"){
					location.href = `${pageContext.request.contextPath}/findPostList.do?selectPageIndex=\${selectPageIndex}`	
				}else{
					location.href = `${pageContext.request.contextPath}/findPostList.do?selectPageIndex=\${selectPageIndex}&searchChoice=\${searchChoice}&searchWord=\${searchWord}`
				}
			}
		</script>
	</body>
</html>