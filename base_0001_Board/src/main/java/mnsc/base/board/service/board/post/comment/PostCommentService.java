package mnsc.base.board.service.board.post.comment;

import java.util.List;
import mnsc.base.board.dto.board.post.comment.PostCommentRequestDto;
import mnsc.base.board.dto.board.post.comment.PostCommentResponseDto;

public interface PostCommentService {

	/**
	 * 댓글 목록 조회
	 * 
	 * @param postNo 게시글 번호
	 * @return List<PostCommentResponseDto> 댓글 응답 DTO
	 */
	List<PostCommentResponseDto> findPostCommentList(Integer postNo);

	/**
	 * 댓글 저장
	 * 
	 * @param requestDto 댓글 저장 요청 DTO
	 * @return Boolean 댓글 저장 여부
	 */
	Boolean saveComment(PostCommentRequestDto requestDto);

	/**
	 * 댓글 수정
	 * 
	 * @param requestDto 댓글 수정 요청 DTO
	 * @return Boolean 댓글 수정 여부
	 */
	Boolean updateComment(PostCommentRequestDto requestDto);
	
	/**
	 * 댓글 삭제
	 * 
	 * @param seq 댓글 번호
	 * @return Boolean 댓글 삭제 여부
	 */
	Boolean deleteComment(Integer seq);

}
