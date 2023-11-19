package mnsc.base.board.dao.board.post;

import java.util.List;
import mnsc.base.board.dto.board.post.PostResponseDto;
import mnsc.base.board.dto.board.post.PostListRequestDto;
import mnsc.base.board.dto.board.post.PostRequestDto;

public interface PostDao {
	
	/**
	 * 게시글 개수 조회
	 * 
	 * @param requestDto 게시글 목록 요청 DTO
	 * @return Integer 게시글 개수
	 */
	Integer findPostListCnt(PostListRequestDto requestDto);
	
	/**
	 * 게시글 목록 조회
	 * 
	 * @param requestDto 게시글 목록 요청 DTO
	 * @return List<PostResponseDto> 게시글 목록 응답 DTO
	 */
	List<PostResponseDto> findPostList(PostListRequestDto requestDto);
	
	/**
	 * 게시글 저장
	 * 
	 * @param requestDto 게시글 저장 요청 DTO
	 * @return Integer 게시글 저장 개수
	 */
	Integer savePost(PostRequestDto requestDto);

	/**
	 * 게시글 상세내용 조회
	 * 
	 * @param seq 게시글 고유 번호
	 * @return PostDetailResponseDto 게시글 상세내용 응답 DTO
	 */
	PostResponseDto findPostDetail(Integer seq);
	
	/**
	 * 게시글 수정
	 * 
	 * @param requestDto 게시글 수정 요청 DTO
	 * @return Integer 게시글 수정 개수
	 */
	Integer updatePost(PostRequestDto requestDto);
	
	/**
	 * 게시글 삭제
	 * 
	 * @param seq 게시글 고유 번호
	 * @return Integer 게시글 삭제 개수
	 */
	Integer deletePost(Integer seq);
	
	/**
	 * 게시글 조회수 증가
	 * 
	 * @param seq 게시글 고유 번호
	 * @return Integer 게시글 수정 개수
	 */
	Integer increaseReadCount(Integer seq);
}
