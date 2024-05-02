package kr.happyjob.study.std.model;

public class MyLecInfoVo {
	
	private int 	lec_id;
	private String 	lec_name;
	private int 	lec_type_id;
	private String 	lec_type_name;
	private String 	tut_id;
	private String 	tut_name;
	private int 	lecrm_id;
	private String 	lecrm_name;
	private String 	start_date;
	private String 	end_date;
	
	private String	lec_goal;
	private String 	week;
	private String 	learn_goal;
	private String 	learn_con;
	
	private String 	srvy_yn;
	private String 	apv_yn;
	private String 	test_yn;
	
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
	public int getLecrm_id() {
		return lecrm_id;
	}
	public void setLecrm_id(int lecrm_id) {
		this.lecrm_id = lecrm_id;
	}
	public String getLecrm_name() {
		return lecrm_name;
	}
	public void setLecrm_name(String lecrm_name) {
		this.lecrm_name = lecrm_name;
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
	public String getWeek() {
		return week;
	}
	public void setLeck_goal(String lec_goal) {
		this.lec_goal = lec_goal;
	}
	public String getLec_goal() {
		return lec_goal;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getLearn_goal() {
		return learn_goal;
	}
	public void setLearn_goal(String learn_goal) {
		this.learn_goal = learn_goal;
	}
	public String getLearn_con() {
		return learn_con;
	}
	public void setLearn_con(String learn_con) {
		this.learn_con = learn_con;
	}
	public String getSrvy_yn() {
		return srvy_yn;
	}
	public void setSrvy_yn(String srvy_yn) {
		this.srvy_yn = srvy_yn;
	}
	public String getApv_yn() {
		return apv_yn;
	}
	public void setApv_yn(String apv_yn) {
		this.apv_yn = apv_yn;
	}
	public String getTest_yn() {
		return test_yn;
	}
	public void setTest_yn(String test_yn) {
		this.test_yn = test_yn;
	}
}