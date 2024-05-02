package kr.happyjob.study.tut.model;

import java.util.Date;

public class TutorLectureDto {
	private int lec_id;
	private String lec_name;
	private String tutor_id;
	private String tutor_name;
	private int lecrm_id;
	private String lecrm_name;
	private Date start_date;
	private Date end_date;
	private int pre_pnum;
	private int max_pnum;
	private int process_day;

	public int getProcess_day() {
		return process_day;
	}

	public void setProcess_day(int process_day) {
		this.process_day = process_day;
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

	public String getTutor_name() {
		return tutor_name;
	}

	public void setTutor_name(String tutor_name) {
		this.tutor_name = tutor_name;
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

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getEnd_date() {
		return end_date;
	}

	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}

	public int getPre_pnum() {
		return pre_pnum;
	}

	public void setPre_pnum(int pre_pnum) {
		this.pre_pnum = pre_pnum;
	}

	public int getMax_pnum() {
		return max_pnum;
	}

	public void setMax_pnum(int max_pnum) {
		this.max_pnum = max_pnum;
	}
	
	
	
}
