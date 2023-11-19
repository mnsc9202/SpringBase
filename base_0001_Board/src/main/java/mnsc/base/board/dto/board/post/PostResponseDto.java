package mnsc.base.board.dto.board.post;

public class PostResponseDto {

	/** 게시글 번호 */
	private int seq;
	
	/** 게시판 번호 */
	private int boardNo;
	
	/** 작성자 */
	private String writer;
	
	/** 제목 */
	private String title;
	
	/** 내용 */
	private String content;
	
	/** 작성일 */
	private String createdDate;
	
	/** 수정일 */
	private String modifiedDate;
	
	/** 삭제여부 */
	private int deleteAt;

	/** 조회수 */
	private int readCount;
	
	// join
	/** 작성자 이름 */
	private String writerName;
	
	/** 댓글 개수 */
	private int  commentCount;

	public PostResponseDto() {
	}

	public PostResponseDto(int seq, int boardNo, String writer, String title, String content, String createdDate,
			String modifiedDate, int deleteAt, int readCount, String writerName, int commentCount) {
		super();
		this.seq = seq;
		this.boardNo = boardNo;
		this.writer = writer;
		this.title = title;
		this.content = content;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
		this.deleteAt = deleteAt;
		this.readCount = readCount;
		this.writerName = writerName;
		this.commentCount = commentCount;
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

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(String modifiedDate) {
		this.modifiedDate = modifiedDate;
	}

	public int getDeleteAt() {
		return deleteAt;
	}

	public void setDeleteAt(int deleteAt) {
		this.deleteAt = deleteAt;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getWriterName() {
		return writerName;
	}

	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
}
