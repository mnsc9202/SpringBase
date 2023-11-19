package mnsc.base.board.dao.board.post.comment;

import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import mnsc.base.board.dto.board.post.comment.PostCommentDto;
import mnsc.base.board.dto.board.post.comment.PostCommentRequestDto;
import mnsc.base.board.dto.board.post.comment.PostCommentResponseDto;

@Repository
public class PostCommentDaoImpl implements PostCommentDao{

	/**
	 * sql 세션
	 */
	@Autowired
	SqlSession session;
	
	String nameSpace = "PostComment.";
	
	// 댓글 상세 내용 조회
	@Override
	public PostCommentDto findPostComment(Integer seq) {
		return session.selectOne(nameSpace + "findPostComment", seq);
	}
	
	// 댓글 목록 조회
	@Override
	public List<PostCommentResponseDto> findPostCommentList(Integer postNo) {
		return session.selectList(nameSpace + "findPostCommentList", postNo);
	}

	// 댓글 저장
	@Override
	public Integer saveComment(PostCommentRequestDto requestDto) {
		return session.insert(nameSpace + "saveComment", requestDto);
	}
	
	// 답글 저장
	@Override
	public Integer saveCommentReply(PostCommentRequestDto requestDto) {
		return session.insert(nameSpace + "saveCommentReply", requestDto);
	}	

	// 댓글 step 변경
	@Override
	public Integer updateCommentStep(HashMap<String, Integer> updateInfoMap) {
		return session.update(nameSpace + "updateCommentStep", updateInfoMap);
	}
	
	// 댓글 수정
	@Override
	public Integer updateComment(PostCommentRequestDto requestDto) {
		return session.update(nameSpace + "updateComment", requestDto);
	}

	// 댓글 삭제
	@Override
	public Integer deleteComment(Integer seq) {
		return session.update(nameSpace + "deleteComment", seq);
	}


	
}
