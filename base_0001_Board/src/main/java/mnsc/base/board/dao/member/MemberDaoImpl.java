package mnsc.base.board.dao.member;

import java.util.HashMap;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import mnsc.base.board.dto.member.MemberDto;
import mnsc.base.board.dto.member.SignInRequestDto;
import mnsc.base.board.dto.member.SignUpRequestDto;

@Repository
public class MemberDaoImpl implements MemberDao {

	/**
	 * sql 세션
	 */
	@Autowired
	SqlSession session;
	
	String nameSpace = "Member.";
	
	// member 조회
	@Override
	public MemberDto findMember(SignInRequestDto requestDto) {
		return session.selectOne(nameSpace + "findMember", requestDto);
	}
	
	// 아이디 중복확인
	@Override
	public Integer checkExistenceId(String inputId) {
		return session.selectOne(nameSpace + "checkExistenceId", inputId);
	}

	// member 저장 (회원가입)
	@Override
	public Integer saveMember(SignUpRequestDto requestDto) {
		// 회원가입 요청정보 설정
		Map<String, Object> request = new HashMap<>();
		request.put("dto", requestDto);
		request.put("auth", 1);
		return session.insert(nameSpace + "saveMember", request);
	}	
}
