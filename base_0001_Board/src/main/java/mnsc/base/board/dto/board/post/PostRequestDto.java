package mnsc.base.board.dto.board.post;

public class PostRequestDto {
	
	/** 댓글 번호 */
	private int seq;
	
	/** 게시글 번호 */
	private int boardNo;
	
	/** 작성자 */
	private String writer;
	
	/** 제목 */
	private String title;
	
	/** 내용 */
	private String content;
	
	public PostRequestDto() {
	}

	public PostRequestDto(int seq, int boardNo, String writer, String title, String content) {
		super();
		this.seq = seq;
		this.boardNo = boardNo;
		this.writer = writer;
		this.title = title;
		this.content = content;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}