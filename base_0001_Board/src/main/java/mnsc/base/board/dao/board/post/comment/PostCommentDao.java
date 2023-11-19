package mnsc.base.board.dao.board.post.comment;

import java.util.HashMap;
import java.util.List;
import mnsc.base.board.dto.board.post.comment.PostCommentDto;
import mnsc.base.board.dto.board.post.comment.PostCommentRequestDto;
import mnsc.base.board.dto.board.post.comment.PostCommentResponseDto;

public interface PostCommentDao {
	
	/**
	 * 댓글 상세 내용 조회
	 * 
	 * @param seq 댓글 번호
	 * @return PostCommentResponseDto 댓글 상세 내용 응답 DTO
	 */
	PostCommentDto findPostComment(Integer seq);

	/**
	 * 댓글 목록 조회
	 * 
	 * @param postNo 게시물 번호
	 * @return List<PostCommentResponseDto> 댓글 목록 응답 DTO
	 */
	List<PostCommentResponseDto> findPostCommentList(Integer postNo);

	/**
	 * 댓글 저장
	 * 
	 * @param requestDto 댓글 저장 요청 DTO
	 * @return Integer 댓글 저장 개수
	 */
	Integer saveComment(PostCommentRequestDto requestDto);
	
	/**
	 * 답글 저장
	 * 
	 * @param requestDto 답글 저장 요청 DTO
	 * @return Integer 답글 저장 개수
	 */
	Integer saveCommentReply(PostCommentRequestDto requestDto);
	
	/**
	 * 댓글 step 변경
	 * 
	 * @param updateInfoMap 변경 정보 Map
	 * @return Integer 댓글 step 변경 개수
	 */
	Integer updateCommentStep(HashMap<String, Integer> updateInfoMap);

	/**
	 * 댓글 수정
	 * 
	 * @param requestDto 댓글 수정 요청 DTO
	 * @return Integer 댓글 수정 개수
	 */
	Integer updateComment(PostCommentRequestDto requestDto);
	
	/**
	 * 댓글 삭제
	 * 
	 * @param seq 댓글 번호
	 * @return Integer 댓글 삭제 개수
	 */
	Integer deleteComment(Integer seq);


}
