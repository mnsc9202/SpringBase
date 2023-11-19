package mnsc.base.board.dto.member;

public class SignUpRequestDto {

	/** 아이디 */
	private String id;
	
	/** 비밀번호 */
	private String pwd;
	
	/** 이름 */
	private String name;
	
	/** 이메일 */
	private String email;

	public SignUpRequestDto(String id, String pwd, String name, String email) {
		super();
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}	
}
