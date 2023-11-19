package mnsc.base.board.controller.member;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import mnsc.base.board.dto.member.MemberDto;
import mnsc.base.board.dto.member.SignInRequestDto;
import mnsc.base.board.dto.member.SignUpRequestDto;
import mnsc.base.board.service.member.MemberService;

@Controller
public class MemberController {
	
	/**
	 * member 서비스
	 */
	@Autowired
	MemberService memberService;
	
	
	/****************************** 로그인 ******************************/
	
	/**
	 * 로그인 화면 이동
	 * 
	 * @return login.jsp 로그인 화면
	 */
	@RequestMapping(value = "login.do", method = RequestMethod.GET)
	public String login() {
		return "/member/login";
	}
	
	/**
	 * 로그인 member 조회
	 * 
	 * @param requestDto 로그인 요청 DTO
	 * @param request 서블릿
	 * @return Boolean 요청 member 존재 여부
	 */
	@RequestMapping(value="signIn.do", method = RequestMethod.POST)
	@ResponseBody
	public Boolean signIn(SignInRequestDto requestDto, HttpServletRequest request) {
		// member 조회
		MemberDto memberDto = memberService.findMember(requestDto);
		
		// 요청 정보에 맞는 member가 없는 경우
		if(memberDto == null) {
			return false; 
		}
		
		// 세션 저장
		request.getSession().setAttribute("loginUserInfo", memberDto);
		return true;
	}
	
	
	/****************************** 회원가입 ******************************/
	
	/**
	 * 회원가입 화면 이동
	 * 
	 * @return signUp.jsp 회원가입 화면
	 */
	@RequestMapping(value="signUp.do", method = RequestMethod.GET)
	public String signUp() {
		return "/member/signUp";
	}
	
	/**
	 * 아이디 중복확인
	 * 
	 * @param inputId 입력한 id
	 * @return Boolean id 사용가능 여부
	 */
	@RequestMapping(value="checkExistenceId.do", method = RequestMethod.GET)
	@ResponseBody
	public Boolean checkExistenceId(String inputId) {
		return memberService.checkExistenceId(inputId);
	}
	
	/**
	 * member 저장 (회원가입)
	 * 
	 * @param requestDto 회원가입 요청 DTO
	 * @return Boolean member 회원가입 여부
	 */
	@RequestMapping(value="signUp.do", method = RequestMethod.POST)
	@ResponseBody
	public Boolean signUp(SignUpRequestDto requestDto) {
		return memberService.saveMember(requestDto);
	}	
}
