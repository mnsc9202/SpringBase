package mnsc.base.board.controller.board.post.comment;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import mnsc.base.board.dto.board.post.comment.PostCommentRequestDto;
import mnsc.base.board.dto.board.post.comment.PostCommentResponseDto;
import mnsc.base.board.service.board.post.comment.PostCommentService;

@Controller
public class PostCommentController {

	/**
	 * 게시글 댓글 서비스
	 */
	@Autowired
	PostCommentService postCommentService;
	
	/**
	 * 댓글 저장
	 * 
	 * @param requestDto 댓글 저장 요청 DTO
	 * @return List<PostCommentResponseDto> 댓글 응답 DTO
	 */
	@RequestMapping(value = "saveComment.do", method = RequestMethod.POST)
	@ResponseBody
	public List<PostCommentResponseDto> saveComment(PostCommentRequestDto requestDto) {
		
		// 댓글 저장
		postCommentService.saveComment(requestDto);
		
		return postCommentService.findPostCommentList(requestDto.getPostNo());
	}
	
	/**
	 * 댓글 수정
	 * 
	 * @param requestDto 댓글 수정 요청 DTO
	 * @return List<PostCommentResponseDto> 댓글 응답 DTO
	 */
	@RequestMapping(value = "updateComment.do", method = RequestMethod.PUT)
	@ResponseBody
	public List<PostCommentResponseDto> updateComment(PostCommentRequestDto requestDto) {

		// 댓글 수정
		postCommentService.updateComment(requestDto);
		
		return postCommentService.findPostCommentList(requestDto.getPostNo());
	}
	
	/**
	 * 댓글 삭제
	 * 
	 * @param seq 댓글 번호
	 * @param postNo 게시글 번호
	 * @return List<PostCommentResponseDto> 댓글 응답 DTO
	 */
	@RequestMapping(value = "deleteComment.do", method = RequestMethod.DELETE)
	@ResponseBody
	public List<PostCommentResponseDto> deleteComment(Integer seq, Integer postNo) {
		
		// 댓글 삭제
		postCommentService.deleteComment(seq);
				
		return postCommentService.findPostCommentList(postNo);
	}
}
