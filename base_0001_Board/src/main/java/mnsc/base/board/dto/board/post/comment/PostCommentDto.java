package mnsc.base.board.dto.board.post.comment;

public class PostCommentDto {

	/** 댓글 번호 */
	private Integer seq;
	
	/** 게시글 번호 */
	private Integer postNo;
	
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
	private Integer deleteAt;
	
	// 답글 관련
	/** 그룹 번호 */
	private Integer groupNo;
	
	/** 참조 번호 */
	private Integer ref;
	
	/** 행번호 */
	private Integer step;
	
	/** 깊이 */
	private Integer depth;

	public PostCommentDto() {
	}

	public PostCommentDto(Integer seq, Integer postNo, String writerId, String targetId, String content,
			String createdDate, String modifiedDate, String deletedDate, Integer deleteAt, Integer groupNo, Integer ref,
			Integer step, Integer depth) {
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
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getPostNo() {
		return postNo;
	}

	public void setPostNo(Integer postNo) {
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

	public Integer getDeleteAt() {
		return deleteAt;
	}

	public void setDeleteAt(Integer deleteAt) {
		this.deleteAt = deleteAt;
	}

	public Integer getGroupNo() {
		return groupNo;
	}

	public void setGroupNo(Integer groupNo) {
		this.groupNo = groupNo;
	}

	public Integer getRef() {
		return ref;
	}

	public void setRef(Integer ref) {
		this.ref = ref;
	}

	public Integer getStep() {
		return step;
	}

	public void setStep(Integer step) {
		this.step = step;
	}

	public Integer getDepth() {
		return depth;
	}

	public void setDepth(Integer depth) {
		this.depth = depth;
	}
}