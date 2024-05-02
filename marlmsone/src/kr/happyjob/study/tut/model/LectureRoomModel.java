package kr.happyjob.study.tut.model;

public class LectureRoomModel {
		
		private int lecrm_id;			// 강의실 ID
		private String lecrm_name;		// 강의실 명
		private String lecrm_size;		// 강의실 사이즈 (제곱미터 / 평)
		private int lecrm_snum;			// 강의실 자리수
		private String lecrm_note;		// 강의 비고
		
		private int equ_id;				// 장비 ID
		private String equ_name;		// 장비 이름
		private int equ_num;			// 장비 개수
		private String equ_note;		// 장비 비고
		
		
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
		public String getLecrm_size() {
			return lecrm_size;
		}
		public void setLecrm_size(String lecrm_size) {
			this.lecrm_size = lecrm_size;
		}
		public int getLecrm_snum() {
			return lecrm_snum;
		}
		public void setLecrm_snum(int lecrm_snum) {
			this.lecrm_snum = lecrm_snum;
		}
		public String getLecrm_note() {
			return lecrm_note;
		}
		public void setLecrm_note(String lecrm_note) {
			this.lecrm_note = lecrm_note;
		}
		public int getEqu_id() {
			return equ_id;
		}
		public void setEqu_id(int equ_id) {
			this.equ_id = equ_id;
		}
		public String getEqu_name() {
			return equ_name;
		}
		public void setEqu_name(String equ_name) {
			this.equ_name = equ_name;
		}
		public int getEqu_num() {
			return equ_num;
		}
		public void setEqu_num(int equ_num) {
			this.equ_num = equ_num;
		}
		public String getEqu_note() {
			return equ_note;
		}
		public void setEqu_note(String equ_note) {
			this.equ_note = equ_note;
		}

		
		
	

}
