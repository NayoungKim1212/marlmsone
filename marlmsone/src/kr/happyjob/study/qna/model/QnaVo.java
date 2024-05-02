package kr.happyjob.study.qna.model;

public class QnaVo {
	
	private int qna_id;	//글번호. 자동 증가
	private String loginID;	// 작성자
	private String qna_title;//제목
	private String qna_con;	//내용
	private String regdate;	//등록일
	private int hit;	//조회수
	
	// 등록,수정,삭제 등 권한에 따른 처리 기능을 위해
	private String user_type;
	
	//상세출력 시 전달 데이터에 추가할 필드
	private boolean check;
	
	public QnaVo() {}
	
	
	
	public QnaVo(int qna_id, String loginID, String qna_title, String qna_con, String regdate, int hit, boolean check) {
		super();
		this.qna_id = qna_id;
		this.loginID = loginID;
		this.qna_title = qna_title;
		this.qna_con = qna_con;
		this.regdate = regdate;
		this.hit = hit;
		this.check = check;
	}



	public QnaVo(int qna_id, String loginID, String qna_title, String qna_con, String regdate, int hit,
			String user_type, boolean check) {
		super();
		this.qna_id = qna_id;
		this.loginID = loginID;
		this.qna_title = qna_title;
		this.qna_con = qna_con;
		this.regdate = regdate;
		this.hit = hit;
		this.user_type = user_type;
		this.check = check;
	}




	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public boolean isCheck() {
		return check;
	}
	public void setCheck(boolean check) {
		this.check = check;
	}
	public String getUserType() {
		return user_type;
	}
	public void setUserType(String userType) {
		this.user_type = userType;
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
	public String getQna_title() {
		return qna_title;
	}
	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}
	public String getQna_con() {
		return qna_con;
	}
	public void setQna_con(String qna_con) {
		this.qna_con = qna_con;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}

	
	
	
}
