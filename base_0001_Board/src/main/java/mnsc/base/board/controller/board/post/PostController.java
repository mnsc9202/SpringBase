package mnsc.base.board.controller.board.post;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import mnsc.base.board.dto.board.post.PostResponseDto;
import mnsc.base.board.dto.board.post.PostListRequestDto;
import mnsc.base.board.dto.board.post.PostRequestDto;
import mnsc.base.board.dto.board.post.comment.PostCommentResponseDto;
import mnsc.base.board.service.board.post.PostService;
import mnsc.base.board.service.board.post.comment.PostCommentService;

@Controller
public class PostController {
	
	/**
	 * 게시글 서비스
	 */
	@Autowired
	PostService postService;
	
	/**
	 * 게시글 댓글 서비스
	 */
	@Autowired
	PostCommentService postCommentService;

	
	/****************************** 게시글 내용 ******************************/
	
	/**
	 * 게시글 목록 조회
	 * 
	 * @param model 모델
	 * @param requestDto 게시글 목록 요청 DTO
	 * @return postList.jsp 게시글 목록 화면
	 */
	@RequestMapping(value="findPostList.do", method = RequestMethod.GET)
	public String findPostList(Model model, PostListRequestDto requestDto) {
		
		// 요청사항 설정
		Integer selectPageIndex = requestDto.getSelectPageIndex(); // 선택한 페이지 번호 
		Integer pagePostCnt = requestDto.getPagePostCnt(); // 페이지당 게시글 개수
		Integer pageStart = (selectPageIndex - 1) * pagePostCnt + 1; // 조회할 페이지 시작번호 
		Integer pageEnd = selectPageIndex * pagePostCnt; // 조회할 페이지 끝번호
		requestDto.setPageStart(pageStart);
		requestDto.setPageEnd(pageEnd);
		
		// 게시판 목록 조회, 전달
		List<PostResponseDto> postList = postService.findPostList(requestDto);
		model.addAttribute("postList", postList);

		// 검색 정보 전달
		model.addAttribute("searchRequest", requestDto);
		
		// 게시글 개수 조회 (페이징 x), 전달
		Integer postListCnt = postService.findPostListCnt(requestDto);
		model.addAttribute("postListCnt", postListCnt);
		
		return "/board/post/postList";
	}
	
	/**
	 * 게시글 작성화면으로 이동
	 * 
	 * @return postWrite.jsp 게시글 작성 화면
	 */
	@RequestMapping(value = "savePost.do", method = RequestMethod.GET)
	public String savePost() {
		return "/board/post/postWrite";
	}
	
	/**
	 * 게시글 저장
	 * 
	 * @param requestDto 게시글작성 요청 DTO
	 * @return controller
	 */
	@RequestMapping(value = "savePost.do", method = RequestMethod.POST)
	public String savePost(PostRequestDto requestDto) {	
		// 게시글 저장
		postService.savePost(requestDto);
		
		return "redirect:/findPostList.do";
	}
	
	/**
	 * 게시글 상세내용 조회
	 * 
	 * @param model 모델
	 * @param seq 게시글 고유 번호
	 * @return postDetail.jsp 게시글 상세화면
	 */
	@RequestMapping(value = "findPostDetail.do", method = RequestMethod.GET)
	public String findPostDetail(Model model, Integer seq) {		
		// 게시글 조회수 증가
		postService.increaseReadCount(seq);
		
		// 상세내용 조회, 전달
		PostResponseDto postDetail = postService.findPostDetail(seq);
		model.addAttribute("postDetail", postDetail);
		
		// 댓글 목록 조회, 전달
		List<PostCommentResponseDto> boardCommentList = postCommentService.findPostCommentList(seq);
		model.addAttribute("postCommentList", boardCommentList);
		
		return "/board/post/postDetail";
	}
	
	/**
	 * 게시글 수정화면으로 이동
	 * 
	 * @param model 모델
	 * @param seq 게시글 고유 번호
	 * @return postUpdate.jsp 게시글 수정화면
	 */
	@RequestMapping(value = "updatePost.do", method = RequestMethod.GET)
	public String updatePost(Model model, Integer seq) {
		// 게시글 상세내용 조회
		PostResponseDto postDetail = postService.findPostDetail(seq);
		
		// 게시글 상세내용 전달
		model.addAttribute("postDetail", postDetail);
		
		return "/board/post/postUpdate";
	}
	
	/**
	 * 게시글 수정
	 * 
	 * @param requestDto 게시글 수정 요청 DTO
	 * @return controller
	 */
	@RequestMapping(value = "updatePost.do", method = RequestMethod.PUT)
	public String updatePost(PostRequestDto requestDto) {
		// 게시글 수정
		postService.updatePost(requestDto);
		
		return "redirect:/findPostDetail.do?seq=" + requestDto.getSeq();
	}
	
	/**
	 * 게시글 삭제
	 * 
	 * @param seq 게시글 고유번호
	 * @return Boolean 게시글 삭제
	 */
	@RequestMapping(value = "deletePost.do", method = RequestMethod.DELETE)
	@ResponseBody
	public Boolean deletePost(Integer seq) {
		return postService.deletePost(seq);
	}
	
}
