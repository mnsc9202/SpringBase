package mnsc.base.board.dto.board.post;

public class PostListRequestDto {
	
	/** 게시판 번호 */
	private Integer boardNo = 1;

	/** 검색 선택 옵션 */
	private String searchChoice;
	
	/** 검색어 */
	private String searchWord;
	
	/** 페이지당 게시글 개수 */
	private Integer pagePostCnt = 10;
	
	/** 선택한 페이지 번호 */
	private Integer selectPageIndex = 1;
	
	/** 페이지 시작번호 */
	private Integer pageStart;
	
	/** 페이지 끝번호 */
	private Integer pageEnd;

	public PostListRequestDto() {
	}

	public PostListRequestDto(Integer boardNo, String searchChoice, String searchWord, Integer pagePostCnt,
			Integer selectPageIndex, Integer pageStart, Integer pageEnd) {
		super();
		this.boardNo = boardNo;
		this.searchChoice = searchChoice;
		this.searchWord = searchWord;
		this.pagePostCnt = pagePostCnt;
		this.selectPageIndex = selectPageIndex;
		this.pageStart = pageStart;
		this.pageEnd = pageEnd;
	}
	
	public Integer getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(Integer boardNo) {
		this.boardNo = boardNo;
	}

	public String getSearchChoice() {
		return searchChoice;
	}

	public void setSearchChoice(String searchChoice) {
		this.searchChoice = searchChoice;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}

	public Integer getPagePostCnt() {
		return pagePostCnt;
	}

	public void setPagePostCnt(Integer pagePostCnt) {
		this.pagePostCnt = pagePostCnt;
	}

	public Integer getSelectPageIndex() {
		return selectPageIndex;
	}

	public void setSelectPageIndex(Integer selectPageIndex) {
		this.selectPageIndex = selectPageIndex;
	}

	public Integer getPageStart() {
		return pageStart;
	}

	public void setPageStart(Integer pageStart) {
		this.pageStart = pageStart;
	}

	public Integer getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(Integer pageEnd) {
		this.pageEnd = pageEnd;
	}	
}