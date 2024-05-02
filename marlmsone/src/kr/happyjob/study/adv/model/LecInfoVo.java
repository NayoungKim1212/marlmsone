package kr.happyjob.study.adv.model;

public class LecInfoVo {	

	private int lec_id;			//강의 번호 - 자동 증가
	private String tutor_id;	//강사 아이디	
	private int lecrm_id;		//강의실 아이디
	private String lec_name;	//강의명
	private int max_pnum;		//최대 인원
	private int pre_pnum;		//수강 인원
	private String start_date;	//개강일
	private String end_date;	//종강일
	private int process_day;	//과정일수
	private String lec_goal;	//수업 목표
	private String lec_sort;	//강의 분류
	private int test_id;		//시험 아이디
	private String test_start;	//시험 시작일
	private String test_end;	//시험 마감일
	
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public String getTutor_id() {
		return tutor_id;
	}
	public void setTutor_id(String tutor_id) {
		this.tutor_id = tutor_id;
	}
	public int getLecrm_id() {
		return lecrm_id;
	}
	public void setLecrm_id(int lecrm_id) {
		this.lecrm_id = lecrm_id;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public int getMax_pnum() {
		return max_pnum;
	}
	public void setMax_pnum(int max_pnum) {
		this.max_pnum = max_pnum;
	}
	public int getPre_pnum() {
		return pre_pnum;
	}
	public void setPre_pnum(int pre_pnum) {
		this.pre_pnum = pre_pnum;
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
	public int getProcess_day() {
		return process_day;
	}
	public void setProcess_day(int process_day) {
		this.process_day = process_day;
	}
	public String getLec_goal() {
		return lec_goal;
	}
	public void setLec_goal(String lec_goal) {
		this.lec_goal = lec_goal;
	}
	public String getLec_sort() {
		return lec_sort;
	}
	public void setLec_sort(String lec_sort) {
		this.lec_sort = lec_sort;
	}
	public int getTest_id() {
		return test_id;
	}
	public void setTest_id(int test_id) {
		this.test_id = test_id;
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
}
