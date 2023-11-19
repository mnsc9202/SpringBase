package mnsc.base.board.dto.board.post.comment;

public class PostCommentRequestDto {
	
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
	
	// 답글 관련
	/** 그룹 번호 */
	private Integer groupNo;
	
	/** 참조 번호 */
	private Integer ref;
	
	/** 행번호 */
	private Integer step;
	
	/** 깊이 */
	private Integer depth;

	public PostCommentRequestDto() {
	}

	public PostCommentRequestDto(Integer seq, Integer postNo, String writerId, String targetId, String content,
			Integer groupNo, Integer ref, Integer step, Integer depth) {
		super();
		this.seq = seq;
		this.postNo = postNo;
		this.writerId = writerId;
		this.targetId = targetId;
		this.content = content;
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