package kr.happyjob.study.adv.model;

public class LecStdInfoVo {
	
	private int lec_id;			//강의 번호
	private String std_id;		//학생 아이디
	private String std_name;	//학생 이름
	private String srvy_yn;		//설문조사 유무
	private String apv_yn;		//수강신청 승인여부
	
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
	public String getStd_name() {
		return std_name;
	}
	public void setStd_name(String std_name) {
		this.std_name = std_name;
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
}
