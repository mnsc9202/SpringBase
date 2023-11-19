package mnsc.base.board.dto.member;

public class MemberDto {

	/** 아이디 */
	private String id;
	
	/** 비밀번호 */
	private String pwd;
	
	/** 이름 */
	private String name;
	
	/** 이메일 */
	private String email;
	
	/** 권한 */
	private int auth;
	
	public MemberDto(String id, String pwd, String name, String email, int auth) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.auth = auth;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getEmail() {
		return email;
	}

	public int getAuth() {
		return auth;
	}
}
