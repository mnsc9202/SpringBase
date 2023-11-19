package mnsc.base.board.service.board.post.comment;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mnsc.base.board.dao.board.post.comment.PostCommentDao;
import mnsc.base.board.dto.board.post.comment.PostCommentDto;
import mnsc.base.board.dto.board.post.comment.PostCommentRequestDto;
import mnsc.base.board.dto.board.post.comment.PostCommentResponseDto;

@Service
public class PostCommentServiceImpl implements PostCommentService {
	
	/**
	 * postComment 데이터 접근 객체
	 */
	@Autowired
	PostCommentDao postCommentDao;

	// 댓글 목록 조회
	@Override
	public List<PostCommentResponseDto> findPostCommentList(Integer boardNo) {
		
		return postCommentDao.findPostCommentList(boardNo);
	}

	// 댓글 저장
	@Override
	public Boolean saveComment(PostCommentRequestDto requestDto) {
		// requestDto의 writerId, targetId, content, boardNo, ref만 입력됨
		// 댓글, 답글 구분 (댓글: false, 답글: true)
		Boolean isCommentReply = "".equals(requestDto.getTargetId()) ? false : true;
		
		// 답글 작성시 정보 설정
		if(isCommentReply) {
			// 답글 대상 seq
			Integer targetBoardCommentSeq = requestDto.getSeq();
			
			// 답글 대상 정보
			PostCommentDto targetBoardCommentDto = postCommentDao.findPostComment(targetBoardCommentSeq);
			Integer targetBoardCommentRef = targetBoardCommentDto.getRef();
			
			// 답글 작성 정보 수정
			requestDto.setRef(targetBoardCommentRef == null ? targetBoardCommentRef : targetBoardCommentSeq);
			requestDto.setGroupNo(targetBoardCommentDto.getGroupNo());
			requestDto.setStep(targetBoardCommentDto.getStep());
			requestDto.setDepth(targetBoardCommentDto.getDepth());
			
			// 답글 추가
			Boolean commentWriteResult = postCommentDao.saveCommentReply(requestDto) > 0 ? true : false;
			
			// 댓글 step 변경
			updateCommentStep(requestDto);			
			
			return commentWriteResult;
		}
		// 댓글 작성시
		else {
			Boolean commentWriteResult = postCommentDao.saveComment(requestDto) > 0 ? true : false;
			return commentWriteResult;
		}
	}
	
	// 댓글 step 변경
	public void updateCommentStep(PostCommentRequestDto requestDto) {
		// 업데이트 정보 설정
		HashMap<String, Integer> updateInfoMap = new HashMap<>();
		updateInfoMap.put("postNo", requestDto.getPostNo());
		updateInfoMap.put("ref", requestDto.getRef());
		updateInfoMap.put("step",requestDto.getStep());
		updateInfoMap.put("seq",requestDto.getSeq());
		updateInfoMap.put("groupNo",requestDto.getGroupNo());
		
		postCommentDao.updateCommentStep(updateInfoMap);
	}

	// 댓글 수정
	@Override
	public Boolean updateComment(PostCommentRequestDto requestDto) {
		return postCommentDao.updateComment(requestDto) > 0 ? true : false;
	}
	
	// 댓글 삭제
	@Override
	public Boolean deleteComment(Integer seq) {
		return postCommentDao.deleteComment(seq) > 0 ? true : false;
	}
}
