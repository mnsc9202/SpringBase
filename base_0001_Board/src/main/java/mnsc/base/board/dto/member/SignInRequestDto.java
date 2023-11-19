package mnsc.base.board.dto.member;

public class SignInRequestDto {
	/** 아이디 */
	private String id;
	
	/** 비밀번호 */
	private String pwd;
	
	public SignInRequestDto(String id, String pwd) {
		super();
		this.id = id;
		this.pwd = pwd;
	}
}
