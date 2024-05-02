package kr.happyjob.study.std.model;


public class StdLearningMaterialsModel {

	private int learn_data_id; // 자료ID
	private int lec_id; // 강의ID
	private String learn_tit; // 제목
	private String learn_con; // 내용
	private String w_date; // 작성일
	private String learn_fname; // 첨부파일명
	private String learn_url; // 파일경로
	private String learn_fsize; // 파일사이즈
	private String lec_name; // 강의 이름
	
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public int getLearn_data_id() {
		return learn_data_id;
	}
	public void setLearn_data_id(int learn_data_id) {
		this.learn_data_id = learn_data_id;
	}
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public String getLearn_tit() {
		return learn_tit;
	}
	public void setLearn_tit(String learn_tit) {
		this.learn_tit = learn_tit;
	}
	public String getLearn_con() {
		return learn_con;
	}
	public void setLearn_con(String learn_con) {
		this.learn_con = learn_con;
	}
	public String getW_date() {
		return w_date;
	}
	public void setW_date(String w_date) {
		this.w_date = w_date;
	}
	public String getLearn_fname() {
		return learn_fname;
	}
	public void setLearn_fname(String learn_fname) {
		this.learn_fname = learn_fname;
	}
	public String getLearn_url() {
		return learn_url;
	}
	public void setLearn_url(String learn_url) {
		this.learn_url = learn_url;
	}
	public String getLearn_fsize() {
		return learn_fsize;
	}
	public void setLearn_fsize(String learn_fsize) {
		this.learn_fsize = learn_fsize;
	}
	
	
}
