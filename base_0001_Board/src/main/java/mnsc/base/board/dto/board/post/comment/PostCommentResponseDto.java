package mnsc.base.board.dto.board.post.comment;

public class PostCommentResponseDto {

	/** 댓글 번호 */
	private int seq;
	
	/** 게시글 번호 */
	private int postNo;
	
	/** 작성자 아이디 */
	private String writerId;
	
	/** 대상자 아이디 */
	private String targetId;
	
	/** 댓글 내용 */
	private String content;
	
	/** 작성일 */
	private String createdDate;
	
	/** 수정일 */
	private String modifiedDate;
	
	/** 삭제일 */
	private String deletedDate;
	
	/** 삭제 여부 */
	private int deleteAt;
	
	// 답글 관련
	/** 그룹 번호 */
	private int groupNo;
	
	/** 참조 번호 */
	private int ref;
	
	/** 행번호 */
	private int step;
	
	/** 깊이 */
	private int depth;
	
	// join
	/** 작성자 이름 */
	private String writerName;
	
	/** 대상자 이름 */
	private String targetName;
	
	public PostCommentResponseDto() {
	}

	public PostCommentResponseDto(int seq, int postNo, String writerId, String targetId, String content,
			String createdDate, String modifiedDate, String deletedDate, int deleteAt, int groupNo, int ref, int step,
			int depth, String writerName, String targetName) {
		super();
		this.seq = seq;
		this.postNo = postNo;
		this.writerId = writerId;
		this.targetId = targetId;
		this.content = content;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
		this.deletedDate = deletedDate;
		this.deleteAt = deleteAt;
		this.groupNo = groupNo;
		this.ref = ref;
		this.step = step;
		this.depth = depth;
		this.writerName = writerName;
		this.targetName = targetName;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getWriterId() {
		return writerId;
	}

	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
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

	public String getDeletedDate() {
		return deletedDate;
	}

	public void setDeletedDate(String deletedDate) {
		this.deletedDate = deletedDate;
	}

	public int getDeleteAt() {
		return deleteAt;
	}

	public void setDeleteAt(int deleteAt) {
		this.deleteAt = deleteAt;
	}

	public int getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getStep() {
		return step;
	}

	public void setStep(int step) {
		this.step = step;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public String getWriterName() {
		return writerName;
	}

	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}
}