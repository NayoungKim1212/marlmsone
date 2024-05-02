package kr.happyjob.study.login.model;


public class LgnInfoModel {


	//사용자 이메일
	private String user_email;
	
	//로그인 ID
	private String loginID;
	
	//비밀번호
	private String password;
	
	// 사용자 로그인 ID
	private String lgn_id;
	
	// 사용자 로그인 PW
	private String pwd;
	
	// 사용자 시스템 ID
	private String usr_sst_id;
	
	// 사용자 성명
	private String usr_nm;
	
	// 로그인 사용자 권한       mng: 관리자       gnr: 일반
	private String mem_author;

	// 1팀 필요컬럼 추가
	private String user_type;
	private String use_yn;
	private String tel;
	private String sex;
	private String zipcode;
	private String addr;
	private String addr_dtl;
	private String join_date;
	private String regi_num;

	
	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLgn_id() {
		return lgn_id;
	}

	public void setLgn_id(String lgn_id) {
		this.lgn_id = lgn_id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getUsr_sst_id() {
		return usr_sst_id;
	}

	public void setUsr_sst_id(String usr_sst_id) {
		this.usr_sst_id = usr_sst_id;
	}

	public String getUsr_nm() {
		return usr_nm;
	}

	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}

	public String getMem_author() {
		return mem_author;
	}

	public void setMem_author(String mem_author) {
		this.mem_author = mem_author;
	}

	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
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

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getRegi_num() {
		return regi_num;
	}

	public void setRegi_num(String regi_num) {
		this.regi_num = regi_num;
	}

	
	

}
