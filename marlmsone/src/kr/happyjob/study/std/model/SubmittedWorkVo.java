package kr.happyjob.study.std.model;

public class SubmittedWorkVo { 
	private int submit_id;	//과제번호
	private String std_id;       //과제 제출한 학생 아이디
	private int hwk_id;           // 과제번호
	private String submit_con;    // 과제내용
	private String submit_fname;  // 과제제출파일이름
	private String submit_url;    // 과제제출위치
	private String submit_fsize;  // 과제파일사이즈
	private String submit_date;   // 과제제출날짜
	
	/*수강 강의에 대한 정보를 가져오기 위해 필요한 필드 추가*/
	private int lec_id; // 강의번호
	private String lec_name;  // 강의명
	private String hwk_name;  // 과제명
	private String start;     //과제 시작일
	private String dead;      //과제 종료일
	private String hwk_url;   // 과제 파일 주소
	private String yn; // 과제 제출 여부
	
	/**풀생성자*/
	public SubmittedWorkVo(int submit_id, String std_id, int hwk_id, String submit_con, String submit_fname,
			String submit_url, String submit_fsize, String submit_date, int lec_id, String lec_name, String hwk_name,
			String start, String dead, String hwk_url, String yn) {
		super();
		this.submit_id = submit_id;
		this.std_id = std_id;
		this.hwk_id = hwk_id;
		this.submit_con = submit_con;
		this.submit_fname = submit_fname;
		this.submit_url = submit_url;
		this.submit_fsize = submit_fsize;
		this.submit_date = submit_date;
		this.lec_id = lec_id;
		this.lec_name = lec_name;
		this.hwk_name = hwk_name;
		this.start = start;
		this.dead = dead;
		this.hwk_url = hwk_url;
		this.yn = yn;
	}

	public int getSubmit_id() {
		return submit_id;
	}
	public void setSubmit_id(int submit_id) {
		this.submit_id = submit_id;
	}

	public String getYn() {
		return yn;
	}
	public void setYn(String yn) {
		this.yn = yn;
	}

	public String getStd_id() {
		return std_id;
	}

	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}

	public int getLec_id() {
		return lec_id;
	}

	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}

	public SubmittedWorkVo() {}
	





	public String getLoginID() {
		return std_id;
	}
	public void setLoginID(String loginID) {
		this.std_id = loginID;
	}
	public int getHwk_id() {
		return hwk_id;
	}
	public void setHwk_id(int hwk_id) {
		this.hwk_id = hwk_id;
	}
	public String getSubmit_con() {
		return submit_con;
	}
	public void setSubmit_con(String submit_con) {
		this.submit_con = submit_con;
	}
	public String getSubmit_fname() {
		return submit_fname;
	}
	public void setSubmit_fname(String submit_fname) {
		this.submit_fname = submit_fname;
	}
	public String getSubmit_url() {
		return submit_url;
	}
	public void setSubmit_url(String submit_url) {
		this.submit_url = submit_url;
	}
	public String getSubmit_fsize() {
		return submit_fsize;
	}
	public void setSubmit_fsize(String submit_fsize) {
		this.submit_fsize = submit_fsize;
	}
	public String getSubmit_date() {
		return submit_date;
	}
	public void setSubmit_date(String submit_date) {
		this.submit_date = submit_date;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getHwk_name() {
		return hwk_name;
	}
	public void setHwk_name(String hwk_name) {
		this.hwk_name = hwk_name;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getDead() {
		return dead;
	}
	public void setDead(String dead) {
		this.dead = dead;
	}
	public String getHwk_url() {
		return hwk_url;
	}
	public void setHwk_url(String hwk_url) {
		this.hwk_url = hwk_url;
	}
	
	
	
	
	
	
/*	private int hwk_id;
	private String hwk_name;
	private int lec_id;
	private String lec_name;
	private String tutor_id;
	private String name;
	private String start;
	private String dead;
	private String hwk_fname;
	private String hwk_url;
	private String hwk_con;
	private String loginID;
	private String submit_date;
	
	
	
	
	public int getHwk_id() {
		return hwk_id;
	}
	public void setHwk_id(int hwk_id) {
		this.hwk_id = hwk_id;
	}
	public String getHwk_name() {
		return hwk_name;
	}
	public void setHwk_name(String hwk_name) {
		this.hwk_name = hwk_name;
	}
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public String getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(String tutor_id) {
		this.tutor_id = tutor_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getDead() {
		return dead;
	}
	public void setDead(String dead) {
		this.dead = dead;
	}
	public String getHwk_fname() {
		return hwk_fname;
	}
	public void setHwk_fname(String hwk_fname) {
		this.hwk_fname = hwk_fname;
	}
	public String getHwk_url() {
		return hwk_url;
	}
	public void setHwk_url(String hwk_url) {
		this.hwk_url = hwk_url;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getSubmit_date() {
		return submit_date;
	}
	public void setSubmit_date(String submit_date) {
		this.submit_date = submit_date;
	}
	public String getHwk_con() {
		return hwk_con;
	}
	public void setHwk_con(String hwk_con) {
		this.hwk_con = hwk_con;
	}
	
	
	*/
	

}
