package kr.happyjob.study.surveyMgt.model;

import java.util.Date;

public class SurveyMgtVo {
	
	private int lec_id;					//강의번호
	private String std_id;				//학생 아이디
//	private char srvy_yn;				//설문조사 응시 여부
	private String srvy_yn;				//설문조사 응시 여부
	private char apv_yn;				//승인 여부
	private int survey_percentage;	//설문조사 참여 비율

	private String lec_name;			//강의 이름
	private Date start_date;			//강의 시작일
	private Date end_date;				//강의 종료일
	private int progress_rate;			//진도율 - 수정 필요
	private String tutor_loginID;		//강사 아이디
	private String tutor_name;			//강사 이름
	private String std_name;			//학생 이름
	
	private int review_num_1;
	private int review_num_2;
	private int review_num_3;
	private int review_num_4;
	private int review_num_5;
	private int review_num;
	private int que_num;
	private String review;
	private String que;
	
	
	
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public String getStd_id() {
		return std_id;
	}
	public void setStd_id(String std_id) {
		this.std_id = std_id;
	}
	public String getSrvy_yn() {
		return srvy_yn;
	}
	public void setSrvy_yn(String srvy_yn) {
		this.srvy_yn = srvy_yn;
	}
	public char getApv_yn() {
		return apv_yn;
	}
	public void setApv_yn(char apv_yn) {
		this.apv_yn = apv_yn;
	}
	public int getSurvey_percentage() {
		return survey_percentage;
	}
	public void setSurvey_percentage(int survey_percentage) {
		this.survey_percentage = survey_percentage;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
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
	public int getProgress_rate() {
		return progress_rate;
	}
	public void setProgress_rate(int progress_rate) {
		this.progress_rate = progress_rate;
	}
	public String getTutor_loginID() {
		return tutor_loginID;
	}
	public void setTutor_loginID(String tutor_loginID) {
		this.tutor_loginID = tutor_loginID;
	}
	public String getTutor_name() {
		return tutor_name;
	}
	public void setTutor_name(String tutor_name) {
		this.tutor_name = tutor_name;
	}
	public String getStd_name() {
		return std_name;
	}
	public void setStd_name(String std_name) {
		this.std_name = std_name;
	}
	public int getReview_num_1() {
		return review_num_1;
	}
	public void setReview_num_1(int review_num_1) {
		this.review_num_1 = review_num_1;
	}
	public int getReview_num_2() {
		return review_num_2;
	}
	public void setReview_num_2(int review_num_2) {
		this.review_num_2 = review_num_2;
	}
	public int getReview_num_3() {
		return review_num_3;
	}
	public void setReview_num_3(int review_num_3) {
		this.review_num_3 = review_num_3;
	}
	public int getReview_num_4() {
		return review_num_4;
	}
	public void setReview_num_4(int review_num_4) {
		this.review_num_4 = review_num_4;
	}
	public int getReview_num_5() {
		return review_num_5;
	}
	public void setReview_num_5(int review_num_5) {
		this.review_num_5 = review_num_5;
	}
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public int getQue_num() {
		return que_num;
	}
	public void setQue_num(int que_num) {
		this.que_num = que_num;
	}
	public String getReview() {
		return review;
	}
	public void setReview(String review) {
		this.review = review;
	}
	public String getQue() {
		return que;
	}
	public void setQue(String que) {
		this.que = que;
	}
	

}
