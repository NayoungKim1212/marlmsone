package kr.happyjob.study.employ.model;

import java.sql.Date;

public class EmploymentModel {

	private int employ_id; //취업관리ID
	private String std_id; //학생ID
	private String comp_name; //회사명
	private Date employ_day; //입사일
	private Date resign_day; //퇴사일
	private String wp_state; //재직상태
	private String reg_state; //이력서등록여부
	
	private String loginID;
	private String name;
	private String std_num;
	private String tel;
	private Date join_date;
	private String sex;
	private String mail;
	
	private int lec_id;
	private String lec_name;
	private Date start_date;
	private Date end_date;
	
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public int getLec_id() {
		return lec_id;
	}

	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
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

	public Date getJoin_date() {
		return join_date;
	}

	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}

	public String getLec_name() {
		return lec_name;
	}

	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}

	public int getEmploy_id() {
		return employ_id;
	}

	public void setEmploy_id(int employ_id) {
		this.employ_id = employ_id;
	}

	public String getStd_id() {
		return std_id;
	}

	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public Date getEmploy_day() {
		return employ_day;
	}

	public void setEmploy_day(Date employ_day) {
		this.employ_day = employ_day;
	}

	public Date getResign_day() {
		return resign_day;
	}

	public void setResign_day(Date resign_day) {
		this.resign_day = resign_day;
	}

	public String getWp_state() {
		return wp_state;
	}

	public void setWp_state(String wp_state) {
		this.wp_state = wp_state;
	}

	public String getReg_state() {
		return reg_state;
	}

	public void setReg_state(String reg_state) {
		this.reg_state = reg_state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getStd_num() {
		return std_num;
	}

	public void setStd_num(String std_num) {
		this.std_num = std_num;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	
	
}
