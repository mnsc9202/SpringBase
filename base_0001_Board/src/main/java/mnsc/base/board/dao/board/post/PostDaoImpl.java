package mnsc.base.board.dao.board.post;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import mnsc.base.board.dto.board.post.PostResponseDto;
import mnsc.base.board.dto.board.post.PostListRequestDto;
import mnsc.base.board.dto.board.post.PostRequestDto;

@Repository
public class PostDaoImpl implements PostDao{
	
	/**
	 * sql 세션
	 */
	@Autowired
	SqlSession session;
	
	String nameSpace = "Post.";
	
	// 게시글 개수 조회
	@Override
	public Integer findPostListCnt(PostListRequestDto requestDto) {
		return session.selectOne(nameSpace + "findPostListCnt", requestDto);
	}

	// 게시글 목록 조회
	@Override
	public List<PostResponseDto> findPostList(PostListRequestDto requestDto) {
		return session.selectList(nameSpace + "findPostList", requestDto);
	}

	// 게시글 저장
	@Override
	public Integer savePost(PostRequestDto requestDto) {
		return session.insert(nameSpace + "savePost", requestDto);
	}

	// 게시글 상세내용 조회
	@Override
	public PostResponseDto findPostDetail(Integer seq) {
		return session.selectOne(nameSpace + "findPostDetail", seq);
	}
	
	// 게시글 수정
	@Override
	public Integer updatePost(PostRequestDto requestDto) {
		return session.update(nameSpace + "updatePost", requestDto);
	}

	// 게시글 삭제
	@Override
	public Integer deletePost(Integer seq) {
		return session.update(nameSpace + "deletePost", seq);
	}

	// 게시글 조회수 증가
	@Override
	public Integer increaseReadCount(Integer seq) {
		return session.update(nameSpace + "increaseReadCount", seq);
	}

}
