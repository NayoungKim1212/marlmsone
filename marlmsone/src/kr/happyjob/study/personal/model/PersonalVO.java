package kr.happyjob.study.personal.model;

public class PersonalVO {
	
	private String loginId;			// 로그인 아이디
	private String name;			// 이름
	private String password;		// 비밀번호
	private String tel;				// 전화번호
	private String mail;			// 이메일
	private String zipcode;			// 우편번호
	private String addr;			// 주소
	private String addr_dtl;		// 상세 주소
	private String regi_num;		// 주민번호
	private String resume_fname;	// 이력서 파일 이름
	private String resume_url;		// 이력서 파일 경로
	private String resume_fsize;	// 이력서 파일 사이즈
	
	
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddr_dtl() {
		return addr_dtl;
	}
	public void setAddr_dtl(String addr_dtl) {
		this.addr_dtl = addr_dtl;
	}
	public String getRegi_num() {
		return regi_num;
	}
	public void setRegi_num(String regi_num) {
		this.regi_num = regi_num;
	}
	public String getResume_fname() {
		return resume_fname;
	}
	public void setResume_fname(String resume_fname) {
		this.resume_fname = resume_fname;
	}
	public String getResume_url() {
		return resume_url;
	}
	public void setResume_url(String resume_url) {
		this.resume_url = resume_url;
	}
	public String getResume_fsize() {
		return resume_fsize;
	}
	public void setResume_fsize(String resume_fsize) {
		this.resume_fsize = resume_fsize;
	}

}
