<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mnsc.base.board.dto.member.MemberDto"%>
<%@page import="mnsc.base.board.dto.board.post.PostResponseDto"%>
<%@page import="mnsc.base.board.dto.board.post.comment.PostCommentResponseDto"%>
<%@page import="java.util.List"%>

<%
	/* 게시글 상세 */
	PostResponseDto postDetail = (PostResponseDto)request.getAttribute("postDetail");

	/* 로그인 정보 조회 */
	MemberDto loginUserInfo = (MemberDto)request.getSession().getAttribute("loginUserInfo");

	/* 	댓글 정보 조회 */
	List<PostCommentResponseDto> commentList = (List<PostCommentResponseDto>)request.getAttribute("postCommentList");
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
		<link rel="stylesheet" type="text/css" href="resources/css/postCommentStyle.css" />
		<!-- icons -->
		<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
		<title>mnsc</title>
	</head>
	
	<body>
		<div class="postDetailContainer">
			
			<!-- 게시글상세 관련 정보 --> 
			<div class="postDetailInfoWrapper">
				<div>
					<div class="postDetailTitle">
						<!-- 제목 -->
						<div><%=postDetail.getTitle()%></div>
					</div>
					
					<!-- 작성 정보 -->
					<div class="postDetailInfo">
						<div class="postDetailWriter">
							<!-- 작성자 -->
							<div><%=postDetail.getWriterName()%></div>
						</div>
						
						<div>
							<!-- 작성일 -->
							<div><%=postDetail.getCreatedDate() %></div>
							
							<!-- 조회수 -->
							<div>
								<span class="material-symbols-outlined">visibility</span>
								<div><%=postDetail.getReadCount() %></div>
							</div>
							
						</div>
					</div>
				</div>
				
				<!-- 구분선 -->
				<div class="postDetailInfoDivider">
					<div></div>
				</div>
				
				<!-- 내용 -->
				<div class="postDetailContent"><%=postDetail.getContent()%></div>
			</div>
			
			<!-- 버튼 -->
			<div class="optionButtonsWrapper">
				<!-- 목록 버튼 -->
				<button type="button" onclick="onPostListMoveBtnClick()">
					<span class="buttonIcon material-symbols-outlined">list</span>
					목록
				</button>
				
				<%
				if(loginUserInfo.getId().equals(postDetail.getWriter())){
				%>	
					<!-- 수정 버튼 -->
					<button type="button" onclick="onPostUpdateBtnClick()">
						<span class="buttonIcon material-symbols-outlined">edit</span>
						수정
					</button>
					
					<!-- 삭제 버튼 -->
					<button type="button" onclick="onPostDeleteBtnClick(<%=postDetail.getSeq() %>)">
						<span class="buttonIcon material-symbols-outlined">delete</span>
						삭제
					</button>
				<%
				}
				%>		
			</div>
			
			<!-- 댓글 -->
			<div class="postCommentTitleWrapper">
				<div>
					<span class="material-symbols-outlined">chat</span>
					댓글
				</div>
				
				<!-- 댓글 개수 -->
				<div id="postCommentCnt">
				<%if(commentList.size() > 0){ %>
					(<%=commentList.size() %>)
				<%} %>
				</div>
			</div>
			
			<!-- 댓글 목록-->
			<%
			if(commentList == null || commentList.size() == 0){
			%>
				<div class="commentListWrapper">
					<p>작성된 댓글이 없습니다</p>
				</div>		
			<%
			} else {
			%>
				<div class="commentListWrapper">
					<%
					for( int i =0 ; i < commentList.size() ; i ++ ){
						PostCommentResponseDto commentItem = commentList.get(i);
					%>
					
						<div class="commentItemWrapper" style="width: <%=(100 - 10 * commentItem.getDepth())%>%; min-width: 90%;">
							<!-- 댓글 정보 -->
							<div>
								<!-- 작성자 -->
								<div><%=commentItem.getWriterName() %></div>
								
								<!-- 내용 -->
								<textarea readonly><%=commentItem.getContent() %></textarea>
								
								<!-- 작성일 -->
								<div><%=commentItem.getCreatedDate() %></div>
							</div>
							
							<!-- 댓글 옵션 버튼 -->
							<div>
								<button type="button" onclick="onCommentReplyBtnClick(<%=i%>, <%=commentItem.getSeq()%>, '<%=commentItem.getWriterId()%>')">
									<span class="buttonIcon replyIcon material-symbols-outlined">reply</span>
									<span>답글</span>
								</button>
								<button type="button" onclick="onCommentEditBtnClick(<%=i%>, <%=commentItem.getSeq()%>, <%=commentItem.getPostNo()%>, `<%=commentItem.getContent()%>`, '<%=commentItem.getWriterId()%>')">
									<span class="buttonIcon material-symbols-outlined">edit</span>
									<span>수정</span>
								</button>
								<button type="button" onclick="onCommentDeleteBtnClick(<%=commentItem.getSeq()%>)">
									<span class="buttonIcon material-symbols-outlined">delete</span>
									<span>삭제</span>
								</button>
							</div>
							
							<!-- 답글 폼 -->
							<div id="commentReply_<%=i%>"></div>
						</div>
					<% } %>
				</div>
			<% } %>
			
			
			<!-- 댓글 작성 폼 -->
			<div class="commentWriteWrapper">
				<div>
					<!-- 작성자 -->
					<div><%=loginUserInfo.getName() %></div>
					
					<!-- 내용 -->
					<textarea class="commentContent" id="_commentContent"></textarea>
				</div>
				<!-- 작성 버튼 -->
				
				<button onclick="onCommentWriteBtnClick()">
					댓글 작성
				</button>
			</div>
		</div>
		
		<script type="text/javascript">
		
			/* document ready */
			$(() => {
				/* 댓글 높이 조절 */
				checkCommentHeight()
			})
			
			/* 댓글 높이 조절 */
			function checkCommentHeight(){
				// 기본 높이
				const defaultTextAreaHeight = 10
				
				$(".commentItemWrapper > div > textarea").each((index, item) => {
					const itemTextarea = $(item)
					
					// height 초기화
					itemTextarea.height("0px")
					
					// height 조절
					const scrollHeight = itemTextarea.prop("scrollHeight")
					itemTextarea.height(defaultTextAreaHeight + scrollHeight+ "px")
				})
			}
		
			/******************** 게시글 (post) ********************/
			/* 목록이동 버튼 클릭시 */
			function onPostListMoveBtnClick(){
				location.href=`${pageContext.request.contextPath}/findPostList.do`
			} 
		
			/* 수정 버튼 클릭시 */
			function onPostUpdateBtnClick(){
				// 게시글 수정 페이지로 이동
				location.href= `${pageContext.request.contextPath}/updatePost.do?seq=<%=postDetail.getSeq()%>`
			}
			
			/* 삭제 버튼 클릭시 */
			function onPostDeleteBtnClick(seq){
				const isCommentDelete = confirm("게시글을 삭제할까요?")
				
				if(!isCommentDelete) return 
				
				// 게시글 삭제
				$.ajax({
					url: `${pageContext.request.contextPath}/deletePost.do?seq=\${seq}`,
					type: "DELETE",
					success: () => {
						location.href=`${pageContext.request.contextPath}/findPostList.do`
					},
					error: () => {console.log("error")}
				})
			}
			
			
			/******************** 댓글 (comment) ********************/
			/* 댓글 목록 업데이트 */
			function updateCommentList(responseCommentList){
				// 작성내용 초기화
				$(".commentContent").val("")
				
				// 수정된 댓글 목록 html
				let arrangeCommentListHtmlString = "" 
				
				// 수정된 댓글 목록 작업
				if(responseCommentList == null || responseCommentList.length == 0){
					arrangeCommentListHtmlString += `
					<div class="commentListWrapper">
						<p>작성된 댓글이 없습니다</p>
					</div>	
					`
					// 댓글 수 변경
					$("#postCommentCnt").text("")
				}else{
					// 댓글 목록 변경
					for(let i = 0; i<responseCommentList.length; i++){
						const commentItem = responseCommentList[i]
						
						arrangeCommentListHtmlString +=
							`
							<div class="commentItemWrapper" style="width: \${100 - 10 * commentItem.depth}%; min-width: 90%;">
								<!-- 댓글 정보 -->
								<div>
									<!-- 작성자 -->
									<div>\${commentItem.writerName}</div>
									
									<!-- 내용 -->
									<textarea readonly>\${commentItem.content}</textarea>
									
									<!-- 작성일 -->
									<div>\${commentItem.createdDate}</div>
								</div>
								
								
								<!-- 댓글 옵션 버튼 -->
								<div>
									<button type="button" onclick="onCommentReplyBtnClick(\${i}, \${commentItem.seq}, '\${commentItem.writerId}')">
										<span class="buttonIcon replyIcon material-symbols-outlined">reply</span>
										<span>답글</span>
									</button>
									<button type="button" onclick="onCommentEditBtnClick(\${i}, \${commentItem.seq}, \${commentItem.postNo}, \`\${commentItem.content}\`, '\${commentItem.writerId}')">
										<span class="buttonIcon material-symbols-outlined">edit</span>
										<span>수정</span>
									</button>
									<button type="button" onclick="onCommentDeleteBtnClick(\${commentItem.seq})">
										<span class="buttonIcon material-symbols-outlined">delete</span>
										<span>삭제</span>
									</button>
								</div>
								<!-- 답글 폼 -->
								<div id="commentReply_\${i}"></div>
							</div>
							`
					}
					
					// 댓글 수 변경
					$("#postCommentCnt").text(`(\${responseCommentList.length})`)
				}
				
				
				// 댓글 목록 변경 (초기화 포함)
				$(".commentListWrapper").html(arrangeCommentListHtmlString)
				
				/* 댓글 높이 조절 */
				checkCommentHeight()
			}
			
			/* 댓글 작성 버튼 클릭시 */
			function onCommentWriteBtnClick(seq, targetId){
				// 댓글 작성
				$.ajax({
					url: `${pageContext.request.contextPath}/saveComment.do`,
					type: "POST",
					data: {
						seq: seq ?? null,
						postNo: <%=postDetail.getSeq()%>,
						writerId: "<%=loginUserInfo.getId()%>",
						targetId: `\${targetId ?? ""}`,
						content: $(".commentContent").val()
						
					},
					success: (responseCommentList) => {
						updateCommentList(responseCommentList)
						
						// 답글 ref 초기화
						replyCommentRef = null
					},
					error: () => {console.log("error")}
				})
			}
			
			/* 댓글 수정 버튼 클릭시 */
			function onCommentEditBtnClick(index, seq, postNo, content, targetId){
				const value = $(`.commentListWrapper > .commentItemWrapper:nth-child(\${index+1}) > div > textarea`).val()
				
				/*-------------------- 내용 (textarea) --------------------*/
				const textareaElement = $(`.commentListWrapper > .commentItemWrapper:nth-child(\${index+1}) > div > textarea`)
				// textarea의 readonly 속성 제거
				textareaElement.removeAttr("readonly")
				
				// css 추가
				textareaElement.addClass("textareaEdit")
				
				// 커서 이동 (글자 맨 끝)
				const position = textareaElement.val().length
				textareaElement[0].setSelectionRange(position, position)
				
				// textarea에 포커스
				textareaElement.focus()
				
				/*-------------------- 버튼 (btn) --------------------*/
				const btnGroup = $(`.commentListWrapper > .commentItemWrapper:nth-child(\${index+1}) > div:nth-child(2)`)
				const replyBtn = btnGroup.children("button:eq(0)")
				const editBtn = btnGroup.children("button:eq(1)")
				const deleteBtn = btnGroup.children("button:eq(2)")
				
				// 답글 제거
				replyBtn.remove()
				
				// 수정 버튼 내용 변경
				editBtn.children("span:eq(0)").html("done")
				editBtn.children("span:eq(1)").html("확인")
				editBtn.removeAttr("onclick")
				editBtn.attr("onclick", `onCommentEditDoneBtnClick(\${index}, \${seq}, \${postNo}, \`\${content}\`, '\${targetId}')`)

				
				// 삭제 버튼 내용 변경
				deleteBtn.children("span:eq(0)").html("close")
				deleteBtn.children("span:eq(1)").html("취소")
				deleteBtn.removeAttr("onclick")
				deleteBtn.attr("onclick", `onCommentEditCancelBtnClick(\${index}, \${seq}, \${postNo}, \`\${content}\`)`)
			}
			
			/* 댓글 수정 완료 버튼 클릭시 */
			function onCommentEditDoneBtnClick(index, seq, postNo, content, targetId){
				const textareaElement = $(`.commentListWrapper > .commentItemWrapper:nth-child(\${index+1}) > div > textarea`)
				/* 댓글 수정 */
				$.ajax({
					url: `${pageContext.request.contextPath}/updateComment.do`,
					type : "PUT",
 					data: {
 						seq: `\${seq}`, // 댓글 번호
						postNo: `\${postNo}`, // 게시물 번호
						content: textareaElement.val() // 댓글 내용
 					},
					success: (responseCommentList) => {
						// 댓글 옵션 버튼 초기화
						resetCommentOptionBtnGroup(index, seq, postNo, content, targetId)
						updateCommentList(responseCommentList)
					},
					error: () => {console.log("error")}
				})
			}
			
			/* 댓글 수정 취소 버튼 클릭시 */
			function onCommentEditCancelBtnClick(index, seq, boardNo, content){				
				/*-------------------- 내용 (textarea) --------------------*/
				const textareaElement = $(`.commentListWrapper > .commentItemWrapper:nth-child(\${index+1}) > div > textarea`)
				// 기존값으로 복원
				textareaElement.val(content)
				// textarea의 readonly 속성 추가
				textareaElement.attr("readonly", true)
				// css 제거
				textareaElement.removeClass("textareaEdit")
				// textarea에 포커스 해제
				textareaElement.focusout()
				
				/*-------------------- 버튼 (btn) --------------------*/
				// 댓글 옵션 버튼 초기화
				resetCommentOptionBtnGroup(index, seq, boardNo, content)
			}
			
			/* 댓급 옵션 버튼 초기화 */
			function resetCommentOptionBtnGroup(index, seq, postNo, content, targetId){
				let currentBtnGroup = $(`.commentListWrapper > .commentItemWrapper:nth-child(\${index+1}) > div:nth-child(2)`)
				// 버튼 그룹 요소 제거
				currentBtnGroup.children("button").remove()
				
				// 댓급 옵션 버튼 생성
				currentBtnGroup.append(getCommentOptionBtnGroup(index, seq, postNo, content, targetId))				
			}
			
			/* 댓글 옵션 버튼 그룹 */
			function getCommentOptionBtnGroup(index, seq, postNo, content, targetId){
				return (
						 `
							<button type="button" onclick="onCommentReplyBtnClick(\${index}, \${seq}, '\${targetId}')">
								<span class="buttonIcon replyIcon material-symbols-outlined">reply</span>
								<span>답글</span>
							</button>
							<button type="button" onclick="onCommentEditBtnClick(\${index}, \${seq}, \${postNo}, \`\${content}\`, '\${targetId}')">
								<span class="buttonIcon material-symbols-outlined">edit</span>
								<span>수정</span>
							</button>
							<button type="button" onclick="onCommentDeleteBtnClick(\${seq})">
								<span class="buttonIcon material-symbols-outlined">delete</span>
								<span>삭제</span>
							</button>
						`
						)	
			}
			
			/* 댓글 삭제 버튼 클릭시 */
			function onCommentDeleteBtnClick(seq){
				const isCommentDelete = confirm("댓글을 삭제할까요?")				
				if(!isCommentDelete) return
				
				// 댓글 삭제
				$.ajax({
					url: `${pageContext.request.contextPath}/deleteComment.do`,
					type : "DELETE",
 					data: {
 						seq: `\${seq}`, // 댓글 번호
 						postNo: <%=postDetail.getSeq()%> // 게시물 번호
 					},
					success: (responseCommentList) => {
						updateCommentList(responseCommentList)
					},
					error: () => {console.log("error")}
				})
			}
			
			
			/******************** 답글 (commentReply) ********************/
			// 답글 ref (참조)
			let replyCommentRef = null
			
			/* 답글 ref 확인 */
			function checkCommentRef(targetIndex){
				// 신규 답글 ref 설정
				$(".commentItemWrapper > div:nth-last-child(1)").each((index, item) => {
					const itemEl = $(item)
					
					// 답글 대상 el 여부 (답글작성 양식을 추가할 위치확인)
					const isTargetEl = itemEl.attr('id').split("_")[1] === `\${targetIndex}`

					// 답글 대상인 경우
					if(isTargetEl){
						// 이미 답글작성 양식이 열린 경우 (답글 ref가 있는 경우)
						if(replyCommentRef !== null){
							// 이전 답글작성 양식 해제
							replyCommentRef.children().remove()
							
							// 답글 대상이 답글 ref인 경우
							if(replyCommentRef.attr('id').split("_")[1] === `\${index}`){
								// 답글 ref 초기화 (답글작성 양식 닫기)
								replyCommentRef = null		
								return
							}							
						}
						
						// 대상 답글 설정
						replyCommentRef = itemEl
					}
				
				})
			}
			
			
			/* 답글 버튼 클릭시 */
			function onCommentReplyBtnClick(index, seq, targetId){
				// 답글 ref 확인
				checkCommentRef(index)
				
				// 답글 작성 양식 추가
				if(replyCommentRef !== null) {
					replyCommentRef.html(getCommentReply(seq, targetId))
					replyCommentRef.children().eq(0).children().eq(0).children(".commentContent").focus()
				}
			}
						
			/* 답글 작성 양식 */
			function getCommentReply(seq, targetId){
				return (
						`
						<div class="commentWriteWrapper">
							<div>
								<!-- 작성자 -->
								<div><%=loginUserInfo.getName() %></div>
								
								<!-- 내용 -->
								<textarea class="commentContent"></textarea>
							</div>
							<!-- 작성 버튼 -->
							
							<button onclick="onCommentWriteBtnClick(\${seq}, '\${targetId}')">
								답글 작성
							</button>
						</div>
						`
						)
			}
		</script>	
	</body>
</html>