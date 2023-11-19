package mnsc.base.board.dao.member;

import mnsc.base.board.dto.member.MemberDto;
import mnsc.base.board.dto.member.SignInRequestDto;
import mnsc.base.board.dto.member.SignUpRequestDto;

public interface MemberDao {

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
	 * @return Integer 입력한 id와 같은 member 수
	 */
	Integer checkExistenceId(String inputId);
	
	/**
	 * member 저장 (회원가입)
	 * 
	 * @param requestDto 회원가입 요청 DTO
	 * @return Integer 회원가입한 member 수
	 */
	Integer saveMember(SignUpRequestDto requestDto);
}
