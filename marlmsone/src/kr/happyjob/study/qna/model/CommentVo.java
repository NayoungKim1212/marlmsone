package kr.happyjob.study.qna.model;

public class CommentVo {
	
	private int rv_id;	//pk 댓글번호. 자동 증가
	private int qna_id;	// Q&A 글번호. fk 
	private String loginID;//댓글 작성자 아이디
	private String rv_con;	//댓글내용
	private String regdate;	//등록일

	
	public CommentVo() {
	}


	public CommentVo(int rv_id, int qna_id, String loginID, String rv_con, String regdate) {
		super();
		this.rv_id = rv_id;
		this.qna_id = qna_id;
		this.loginID = loginID;
		this.rv_con = rv_con;
		this.regdate = regdate;
	}


	public int getRv_id() {
		return rv_id;
	}


	public void setRv_id(int rv_id) {
		this.rv_id = rv_id;
	}


	public int getQna_id() {
		return qna_id;
	}


	public void setQna_id(int qna_id) {
		this.qna_id = qna_id;
	}


	public String getLoginID() {
		return loginID;
	}


	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}


	public String getRv_con() {
		return rv_con;
	}


	public void setRv_con(String rv_con) {
		this.rv_con = rv_con;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	


}
