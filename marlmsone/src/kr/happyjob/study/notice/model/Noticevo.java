package kr.happyjob.study.notice.model;

public class Noticevo {
	
	private int notice_id;		// 공지사항 번호 	-> 자동 증가
	private String loginID;		// 작성자 아이디 	-> 로그인 사용자 정보
	private String notice_tit;	// 공지사항 제목	-> 받은 내용		
	private String notice_con;	// 공지사항 내용	-> 받은 내용
	private String regdate;		// 작성일			-> 현재 날짜
	private int hit;			// 조회수			-> 0
	private String filename; 	//파일명
	private String physicalpath;//물리경로(로컬 주소)
	private String logicalpath;	//논리경로
	private int filesize;		//파일사이즈
	private String fileext;		//파일확장자
	private String file_yn; // 파일첨부 유무
	
	// 공지사항 출력 시 작성자 이름 출력을 위함
	private String name; 		// 작성자 이름	
	
	
	public Noticevo() {}

	
	public Noticevo(int notice_id, String loginID, String notice_tit, String notice_con, String regdate, int hit,
			String filename, String physicalpath, String logicalpath, int filesize, String fileext, String name) {
		super();
		this.notice_id = notice_id;
		this.loginID = loginID;
		this.notice_tit = notice_tit;
		this.notice_con = notice_con;
		this.regdate = regdate;
		this.hit = hit;
		this.filename = filename;
		this.physicalpath = physicalpath;
		this.logicalpath = logicalpath;
		this.filesize = filesize;
		this.fileext = fileext;
		this.name = name;
	}





	public String getFile_yn() {
		return file_yn;
	}


	public void setFile_yn(String file_yn) {
		this.file_yn = file_yn;
	}


	public int getNotice_id() {
		return notice_id;
	}


	public void setNotice_id(int notice_id) {
		this.notice_id = notice_id;
	}


	public String getLoginID() {
		return loginID;
	}


	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}


	public String getNotice_tit() {
		return notice_tit;
	}


	public void setNotice_tit(String notice_tit) {
		this.notice_tit = notice_tit;
	}


	public String getNotice_con() {
		return notice_con;
	}


	public void setNotice_con(String notice_con) {
		this.notice_con = notice_con;
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


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public String getPhysicalpath() {
		return physicalpath;
	}


	public void setPhysicalpath(String physicalpath) {
		this.physicalpath = physicalpath;
	}


	public String getLogicalpath() {
		return logicalpath;
	}


	public void setLogicalpath(String logicalpath) {
		this.logicalpath = logicalpath;
	}


	public int getFilesize() {
		return filesize;
	}


	public void setFilesize(int filesize) {
		this.filesize = filesize;
	}


	public String getFileext() {
		return fileext;
	}


	public void setFileext(String fileext) {
		this.fileext = fileext;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
