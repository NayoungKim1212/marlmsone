package kr.happyjob.study.std.model;

public class TestResultVo {
	
	private int lec_id;			// 강의ID
	private String std_id;		// 수강생명
	private int test_num;		// 문제번호
	private int test_id;		// 시험ID
	private int answer;			// 정답
	private int submit_answer;	// 제출답
	private String chk_answer;	// 정답여부(C:정답, W:오답)
	
	private int que_id;			// 문제ID
	private String test_que;	// 문제
	private int que_ans;		// 정답
	private String que_ex1;		// 보기1
	private String que_ex2;		// 보기2
	private String que_ex3;		// 보기3
	private String que_ex4;		// 보기4
		
	
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
	public int getTest_num() {
		return test_num;
	}
	public void setTest_num(int test_num) {
		this.test_num = test_num;
	}
	public int getTest_id() {
		return test_id;
	}
	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	public int getSubmit_answer() {
		return submit_answer;
	}
	public void setSubmit_answer(int submit_answer) {
		this.submit_answer = submit_answer;
	}
	public String getChk_answer() {
		return chk_answer;
	}
	public void setChk_answer(String chk_answer) {
		this.chk_answer = chk_answer;
	}
	public int getQue_id() {
		return que_id;
	}
	public void setQue_id(int que_id) {
		this.que_id = que_id;
	}	
	public String getTest_que() {
		return test_que;
	}
	public void setTest_que(String test_que) {
		this.test_que = test_que;
	}
	public int getQue_ans() {
		return que_ans;
	}
	public void setQue_ans(int que_ans) {
		this.que_ans = que_ans;
	}
	public String getQue_ex1() {
		return que_ex1;
	}
	public void setQue_ex1(String que_ex1) {
		this.que_ex1 = que_ex1;
	}
	public String getQue_ex2() {
		return que_ex2;
	}
	public void setQue_ex2(String que_ex2) {
		this.que_ex2 = que_ex2;
	}
	public String getQue_ex3() {
		return que_ex3;
	}
	public void setQue_ex3(String que_ex3) {
		this.que_ex3 = que_ex3;
	}
	public String getQue_ex4() {
		return que_ex4;
	}
	public void setQue_ex4(String que_ex4) {
		this.que_ex4 = que_ex4;
	}
}