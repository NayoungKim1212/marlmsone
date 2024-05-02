package kr.happyjob.study.std.model;

public class TestUserVo {
	
	private int lec_id;			// 강의ID
	private String lec_name;	// 강의명
	private String tut_name;	// 강사명
	
	private int test_id;		// 시험ID
	private String test_name;	// 시험명
	
	private String std_id;		// 수강생명
	private String pass;		// 시험결과(P:Pass, F:Fail)	
	private int test_score;		// 시험점수	
	private String test_date;	// 시험 응시일
 
	
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
	public String getTut_name() {
		return tut_name;
	}
	public void setTut_name(String tut_name) {
		this.tut_name = tut_name;
	}
	public int getTest_id() {
		return test_id;
	}
	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}
	public String getTest_name() {
		return test_name;
	}
	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}
	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
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
	public String getTest_date() {
		return test_date;
	}
	public void setTest_date(String test_date) {
		this.test_date = test_date;
	}
}