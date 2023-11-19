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
		<title>mnsc</title>
	</head>
	
	<body>
		<div class="signUpContainer">
			<div class="signUpTitle">회원가입</div>
			
			<!-- 회원가입 관련 입력 정보 -->
			<form class="signUpFormWrapper" id="signUpForm">
				<input type="text" placeholder="아이디" id="joinId" name="id" onBlur="onCheckInputValueBlur(event)" />
				<input type="password" placeholder="비밀번호"  id="joinPwd" name="pwd" onBlur="onCheckInputValueBlur(event)"/>
				<input type="text" placeholder="이름"  id="joinName" name="name" onBlur="onCheckInputValueBlur(event)"/>
				<input type="email" placeholder="이메일"  id="joinEmail" name="email" onBlur="onCheckInputValueBlur(event)"/>				
			</form>
			
			<!-- 입력정보 오류내용 -->
			<div id="checkInputError"></div>
			
			<div class="optionButtonsWrapper">
				<!-- 가입 버튼 -->
				<button type="button" class="ceateAccountBtn" onclick="onCreateAccountBtnClick()">가입</button>
				
				<!-- 취소 버튼 -->
				<button type="button" class="ceateAccountCancleBtn" onclick="onCreateAccountCancleBtnClick()">취소</button>
			</div>
		</div>
		
		<script type="text/javascript">
		
			/* 에러 메시지 */
			const defaultErrorMessageOfId = "아이디는 5~20자의 영문 소문자, 숫자만 사용가능합니다"
			const existenceErrorMessageOfId = "사용할 수 없는 아이디입니다"
			
			/* 입력값 에러, 정규식 목록 */
			let checkInputRegexList = [
				{
					name: "id",
					reg:/^[a-z0-9]{5,20}$/,
					errorMessage: defaultErrorMessageOfId,
					isError:true
				},
				{
					name: "pwd",
					reg:/^(\w|[!@#$%]){8,15}$/,
					errorMessage: "비밀번호는 8~15자의 영문 대/소문자, 숫자, 특수문자(!@#$%)만 사용가능합니다",
					isError:true
				},
				{
					name:"name",
					reg:/^[가-힣]{2,5}|[a-zA-Z]{2,40}$/,
					errorMessage: "한글은 2~5자, 영어는 2~40자만 입력가능합니다",
					isError:true
				},
				{
					name:"email",
					reg:/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/,
					errorMessage: "이메일은 이메일형식(mnsc@mnsc.com)으로 입력가능합니다",
					isError:true
				}
			]
		
			/* 아이디 중복확인 */
			function checkExistenceId(id){
				let isExistence = false // 중복여부
				
				// 중복확인
				$.ajax({
					url: `${pageContext.request.contextPath}/checkExistenceId.do`,
					type: "GET",
					data: {inputId: id},
					async: false,
					success: (response) => {
						// 입력한 아이디가 사용불가능한 경우
						if(!response){
							$("#checkInputError").text(existenceErrorMessageOfId)
							isExistence = true
						}
					},
					error: () => {console.log("error")}
				})
				return isExistence
			}
		
			/* 입력값 확인 */
			function onCheckInputValueBlur(event){
				const target = event.target // input 대상
				const targetName = target.name // input name
				const targetValue = target.value // input value
				
				// checkInputRegexList에서 입력한 input에 해당하는 객체 조회
				let findEl = checkInputRegexList.find((el) => el.name == targetName)
				
				if(findEl){
					// 정규식 확인
					const regMatchResult = findEl.reg.test(targetValue)
					
					// 정규식에 매칭되는 경우
					if(regMatchResult){
						// 에러 메시지 초기화
						$("#checkInputError").text("")
						
						// 아이디 중복확인
						if(targetName == "id"){
							const isExistenceId = checkExistenceId(targetValue)
							
							// 중복된 아이디가 있을 경우
							if(isExistenceId) {
								findEl = {...findEl, isError: true, errorMessage: existenceErrorMessageOfId}
							}else{
								findEl = {...findEl, isError: false, errorMessage: defaultErrorMessageOfId}
							}
						}else{
							findEl = {...findEl, isError: false}								
						}
					}
					
					// 정규식에 매칭되지 않는 경우
					else{
						// id의 경우 기본 에러메시지로 설정
						if(targetName == "id"){
							findEl = {...findEl, errorMessage: defaultErrorMessageOfId}
						}
						findEl = {...findEl, isError: true}
						$("#checkInputError").text(findEl.errorMessage)
					}
					
					// 변경된 객체로 checkInputRegexList에 저장
					checkInputRegexList = checkInputRegexList.map((el) => {
											if(el.name == findEl.name){
												return findEl
											}else{
												return el
											}})
				}
			}
			
			/* 로그인 페이지 이동 */
			function moveLoginPage(){
				location.href=`${pageContext.request.contextPath}/login.do`
			}
			
			/* 가입 성공시 */
			function successCreateAccount(){
				$("#signUpForm").remove() // form 제거

				// 안내 배경 너비 설정
				$(".signUpContainer").css({"min-width" : "300px"})
			
				// 가입완료 문구 추가
				const text = $(".signUpTitle").text()
				$(".signUpTitle").text(text + "이\n 완료되었습니다")
				
				// 버튼 내용 변경
				$(".ceateAccountBtn").text("확인")
				$(".ceateAccountBtn").removeAttr("onclick")
				$(".ceateAccountBtn").attr("onclick", "moveLoginPage()")
				
				// 버튼 스타일 변경
				$(".ceateAccountBtn").css({
					"border-top-right-radius" : "5px",
					"border-bottom-right-radius" : "5px"
				})
				
				// 버튼 삭제 (취소)
				$(".ceateAccountCancleBtn").remove()
			}
		
			/* 가입 버튼 클릭시 */
			function onCreateAccountBtnClick(){
				// 입력값 조회 (배열)
				 const joinForm = $("#signUpForm").serializeArray()
				
				// 빈값 확인
				for(let i=0; i<joinForm.length; i++){
					if(joinForm[i].value.trim() === ""){
						const name = joinForm[i].name
						const targetId = "join" + name[0].toUpperCase() + name.slice(1) // ex) "join" + "I" + "d" => "joinId"
						const targerPlaceHolder = $("#"+targetId).attr('placeholder')
						$("#checkInputError").text(targerPlaceHolder + "을(를) 입력하지 않았습니다")
						break
					}
				}
			
				// error 확인
				for(element of checkInputRegexList){
					if(element.isError) {
						$("#checkInputError").text(element.errorMessage)
						return
					}
				}
				
				// 가입, 취소 버튼 클릭 방지
				$(".ceateAccountBtn").prop("disabled", true)
				$(".ceateAccountCancleBtn").prop("disabled", true)
				
				// 입력내용 저장
				$.ajax({
					url: `${pageContext.request.contextPath}/signUp.do`,
					type: "POST",
					data: joinForm,
					success: (response) => {
						// 성공시
						if(response){
							successCreateAccount()
							// 가입, 취소 버튼 클릭 방지 해제
							$(".ceateAccountBtn").prop("disabled", false)
							$(".ceateAccountCancleBtn").prop("disabled", false)	
						}
						// 실패시
						else{
							$("#checkInputError").text("가입에 실패했습니다")	
						}
						
					},
					error: () => {console.log("error")}
				})
			}
			
			/* 가입 취소 버튼 클릭시 */
			function onCreateAccountCancleBtnClick(){
				location.replace(`${pageContext.request.contextPath}/login.do`)
			}		
		</script>
	</body>
</html>