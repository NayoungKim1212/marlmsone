package kr.happyjob.study.tut.model;

public class CheckGradesModel {
	
	//강의분류
	private int lec_id;
	
	//학생 ID
	private String std_id; 
	
	//시험마스터ID
	private int test_id;
	
	//시험문제ID
	private int que_id; 
	//시험명
	private String test_name;
	//강의분류ID
	private int lec_type_id;
	
	//강의분류명
	private String lec_type_name; 
	//수강인원
	private int pre_pnum;
	
	//로그인ID
	private String loginID;
	//패스여부
	private String pass; 
	//
	private int test_score; 
	
	private String lec_name; 
	
	private String start_date;
	
	private String end_date; 
	
	private String lecStatus;
	
	private int cnt;
	
	private int noTest;
	
	private String name;
	
	private String test_yn;
	
	private String tutor_id;
	
	public int getNoTest() {
		return noTest;
	}
	public void setNoTest(int noTest) {
		this.noTest = noTest;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getLecStatus() {
		return lecStatus;
	}
	public void setLecStatus(String lecStatus) {
		this.lecStatus = lecStatus;
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
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}
	public int getTest_id() {
		return test_id;
	}
	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}
	public int getQue_id() {
		return que_id;
	}
	public void setQue_id(int que_id) {
		this.que_id = que_id;
	}
	public String getTest_name() {
		return test_name;
	}
	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}
	public int getLec_type_id() {
		return lec_type_id;
	}
	public void setLec_type_id(int lec_type_id) {
		this.lec_type_id = lec_type_id;
	}
	public String getLec_type_name() {
		return lec_type_name;
	}
	public void setLec_type_name(String lec_type_name) {
		this.lec_type_name = lec_type_name;
	}
	public int getPre_pnum() {
		return pre_pnum;
	}
	public void setPre_pnum(int pre_pnum) {
		this.pre_pnum = pre_pnum;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getTest_score() {
		return test_score;
	}
	public void setTest_score(int test_score) {
		this.test_score = test_score;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTest_yn() {
		return test_yn;
	}
	public void setTest_yn(String test_yn) {
		this.test_yn = test_yn;
	}
	public String getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(String tutor_id) {
		this.tutor_id = tutor_id;
	}
	
	
	
	

}
