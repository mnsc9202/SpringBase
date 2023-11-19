package mnsc.base.board.service.member;

import mnsc.base.board.dto.member.MemberDto;
import mnsc.base.board.dto.member.SignInRequestDto;
import mnsc.base.board.dto.member.SignUpRequestDto;

public interface MemberService {

	/**
	 * member 조회
	 * 
	 * @param requestDto 로그인 요청 DTO
	 * @return MemberDto member DTO
	 */
	MemberDto findMember(SignInRequestDto requestDto);
	
	/**
	 * 아이디 중복확인
	 * 
	 * @param inputId 입력한 id
	 * @return Boolean id 사용가능 여부
	 */
	Boolean checkExistenceId(String inputId);
	
	/**
	 * member 저장 (회원가입)
	 * 
	 * @param requestDto 회원가입 요청 DTO
	 * @return Boolean member 저장 결과
	 */
	Boolean saveMember (SignUpRequestDto requestDto);
}
