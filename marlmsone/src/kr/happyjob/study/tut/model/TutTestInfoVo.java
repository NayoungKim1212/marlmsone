package kr.happyjob.study.tut.model;

public class TutTestInfoVo {
	
	private int lec_id;
	private String lec_name;
	private int lec_type_id;
	private String lec_type_name;
	private String start_date;
	private String end_date;	
	
	private String tut_id;
	private String tut_name;
	private int test_id;
	private String test_name;	
	private String test_start;
	private String test_end;
	private String test_yn;
	private String pass;
	private String test_score;
	private String test_date;
	
	
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
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
	public String getTut_id() {
		return tut_id;
	}
	public void setTut_id(String tut_id) {
		this.tut_id = tut_id;
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
	public String getTest_start() {
		return test_start;
	}
	public void setTest_start(String test_start) {
		this.test_start = test_start;
	}
	public String getTest_end() {
		return test_end;
	}
	public void setTest_end(String test_end) {
		this.test_end = test_end;
	}
	public String getTest_yn() {
		return test_yn;
	}
	public void setTest_yn(String test_yn) {
		this.test_yn = test_yn;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getTest_score() {
		return test_score;
	}
	public void setTest_score(String test_score) {
		this.test_score = test_score;
	}
	public String getTest_date() {
		return test_date;
	}
	public void setTest_date(String test_date) {
		this.test_date = test_date;
	}
}