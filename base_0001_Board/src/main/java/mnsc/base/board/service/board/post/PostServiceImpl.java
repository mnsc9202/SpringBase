package mnsc.base.board.service.board.post;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mnsc.base.board.dao.board.post.PostDao;
import mnsc.base.board.dto.board.post.PostResponseDto;
import mnsc.base.board.dto.board.post.PostListRequestDto;
import mnsc.base.board.dto.board.post.PostRequestDto;

@Service
public class PostServiceImpl implements PostService{
	
	/**
	 * post 데이터 접근 객체
	 */
	@Autowired
	PostDao postDao;
	
	// 게시글 개수 조회
	@Override
	public Integer findPostListCnt(PostListRequestDto requestDto) {
		return postDao.findPostListCnt(requestDto);
	}

	// 게시글 목록 조회
	@Override
	public List<PostResponseDto> findPostList(PostListRequestDto requestDto) {
		return postDao.findPostList(requestDto);
	}

	// 게시글 저장
	@Override
	public Boolean savePost(PostRequestDto requestDto) {
		return postDao.savePost(requestDto) > 0 ? true : false;
	}

	// 게시글 상세내용 조회
	@Override
	public PostResponseDto findPostDetail(Integer seq) {
		return postDao.findPostDetail(seq);
	}
	
	// 게시글 수정
	@Override
	public Boolean updatePost(PostRequestDto requestDto) {
		return postDao.updatePost(requestDto) > 0 ? true : false;
	}

	// 게시글 삭제
	@Override
	public Boolean deletePost(Integer seq) {
		return postDao.deletePost(seq) > 0 ? true : false;
	}

	// 게시글 조회수 증가
	@Override
	public Boolean increaseReadCount(Integer seq) {
		return postDao.increaseReadCount(seq) > 0 ? true : false;
	}
		
}
