package mnsc.base.board.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mnsc.base.board.dao.member.MemberDao;
import mnsc.base.board.dto.member.MemberDto;
import mnsc.base.board.dto.member.SignInRequestDto;
import mnsc.base.board.dto.member.SignUpRequestDto;

@Service
public class MemberServiceImpl implements MemberService {

	/**
	 * member 데이터 접근 객체
	 */
	@Autowired
	MemberDao memberDao;
	
	// member 조회
	@Override
	public MemberDto findMember(SignInRequestDto requestDto) {
		return memberDao.findMember(requestDto);
	}

	// 아이디 중복확인
	@Override
	public Boolean checkExistenceId(String inputId) {
		return memberDao.checkExistenceId(inputId) > 0 ? false : true;
	}

	// member 저장 (회원가입)
	@Override
	public Boolean saveMember(SignUpRequestDto requestDto) {
		return (memberDao.saveMember(requestDto) > 0) ? true : false;
	}	
}
