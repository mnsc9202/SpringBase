<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="shortcut icon" href="resources/image/favicon.ico">
		<!-- jquery -->
		<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="resources/css/color.css" />
		<link rel="stylesheet" type="text/css" href="resources/css/memberStyle.css" />
		<!-- cookie -->
		<script src="resources/js/js.cookie.js"></script>
		<title>mnsc</title>
	</head>

	<body>
		<div class="loginContainer">
			<div class="loginTitle">MNSC</div>
			
			<!-- 로그인 관련 입력 정보 -->
			<form class="loginFormWrapper" id="loginForm">
				<input type="text" placeholder="아이디" id="inputId" name="id" oninput="onInputId()"/>
				<input type="password" placeholder="비밀번호"  id="inputPwd" name="pwd"/>
			</form>
			
			<!-- 아이디 저장버튼 -->
			<div class="saveIdToggleWrapper">
				<input type="checkbox" id="saveIdToggle"/>아이디 저장
			</div>
			
			<!-- 입력정보 오류내용 -->
			<div id="checkInputError"></div>
			
			<!-- 로그인 버튼 -->
			<button type="button" class="loginBtn" onclick="onLoginBtnClick()">로그인</button>		
		</div>
		
		<div class="optionWrapper">
			<!-- 회원가입 -->
			<a class="signUpBtn" href="signUp.do">회원가입</a>	
		</div>
	
		<script type="text/javascript">
		
			/* document ready */
			$(() => {
				// 저장된 아이디 조회
				const userId = $.cookie("userId")
				
				// 저장된 아이디 설정
				if(userId != null){
					$("#inputId").val(userId)
					$("#saveIdToggle").prop("checked", true)
				}
			})
			
			/* 아이디 입력시 */
			function onInputId(){
				// 입력한 id 조회
				const inputId = $("#inputId").val().trim()
				
				// 입력값 확인 후 에러 메시지 해제
				if(inputId !== ""){
					$("#checkInputError").text("")
				}				
			}
		
			/* 로그인 버튼 클릭시 */
			function onLoginBtnClick() {
				// 입력한 id, pwd 조회
				const inputId = $("#inputId").val().trim()
				const inputPwd = $("#inputPwd").val().trim()
				
				// 입력값 확인 (빈값 여부)
				if(inputId === ""){
					$("#checkInputError").text("아이디를 입력하지 않았습니다")
					return
				}else if(inputPwd === ""){
					$("#checkInputError").text("비밀번호를 입력하지 않았습니다")
					return
				}
				
				// 입력한 id, pwd 조회 (배열)
				const loginForm = $("#loginForm").serializeArray()
				
				// 입력 정보를 통한 로그인
				$.ajax({
					url: `${pageContext.request.contextPath}/signIn.do`,
					type: "POST",
					data: loginForm,
					success: (response) => {
						// 로그인 성공
						if(response){
							// 아이디 저장여부 확인
							checkSaveUserId()
							
							// 게시판 이동
							location.href = `${pageContext.request.contextPath}/findPostList.do` 
						}
						// 로그인 실패
						else{
							// 입력한 pwd 초기화
							$("#inputPwd").val("")
							$("#checkInputError").text("아이디 또는 비밀번호를 확인해주세요")
						}
					},
					error: () => {console.log("error")}
				})				
			}
			
			/* 아이디 저장여부 확인 */
			function checkSaveUserId(){
				const inputId = $("#inputId").val().trim()
				const cookiePath = `${pageContext.request.contextPath}/login.do`
				
				// 아이디 저장 toggle 확인
				if($("#saveIdToggle").is(":checked")){
					// 쿠키에 저장(7일, 로그인 요청경로)
					$.cookie("userId", inputId, {expires:7, path: cookiePath})
				} else{
					$.removeCookie("userId", {path: cookiePath})
				}
			}			
		</script>		
	</body>
</html>