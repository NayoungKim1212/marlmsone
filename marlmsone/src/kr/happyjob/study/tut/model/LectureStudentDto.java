package kr.happyjob.study.tut.model;

import java.util.Date;

public class LectureStudentDto {

	private int lec_Id;
	private String lec_name;
	private String std_id;
	private String student_name;
	private String student_number;
	private String student_tel;
	private String student_sex;
	private String student_mail;
	private String student_addr;
	private String join_date;
	private String survey_yn;
	private String approve_yn;
	private String  startDate;
	private String endDate;
	
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}

	public String getStudent_number() {
		return student_number;
	}
	public void setStudent_number(String student_number) {
		this.student_number = student_number;
	}
	public int getLec_Id() {
		return lec_Id;
	}
	public void setLec_Id(int lec_Id) {
		this.lec_Id = lec_Id;
	}
	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public String getStudent_tel() {
		return student_tel;
	}
	public void setStudent_tel(String student_tel) {
		this.student_tel = student_tel;
	}
	public String getStudent_sex() {
		return student_sex;
	}
	public void setStudent_sex(String student_sex) {
		this.student_sex = student_sex;
	}
	public String getStudent_mail() {
		return student_mail;
	}
	public void setStudent_mail(String student_mail) {
		this.student_mail = student_mail;
	}
	public String getStudent_addr() {
		return student_addr;
	}
	public void setStudent_addr(String student_addr) {
		this.student_addr = student_addr;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public String getSurvey_yn() {
		return survey_yn;
	}
	public void setSurvey_yn(String survey_yn) {
		this.survey_yn = survey_yn;
	}
	public String getApprove_yn() {
		return approve_yn;
	}
	public void setApprove_yn(String approve_yn) {
		this.approve_yn = approve_yn;
	}
	
	
	
}
