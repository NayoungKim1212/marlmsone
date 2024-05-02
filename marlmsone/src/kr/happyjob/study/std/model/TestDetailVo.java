package kr.happyjob.study.std.model;

public class TestDetailVo {
	
	private int test_id;			// 시험ID
	private String test_name;		// 시험명
	private int que_id;				// 문제ID
	private int test_num;			// 문제번호

	private int lec_id;			 	// 강의ID
	private String lec_name;		// 강의명
	private int lec_type_id;		// 강의분류ID
	private String lec_type_name;	// 강의분류명
	
	private String test_que;		// 문제
	private String que_ans;			// 정답
	private String que_ex1;			// 보기1
	private String que_ex2;			// 보기2
	private String que_ex3;			// 보기3
	private String que_ex4;			// 보기4
	
	public int getTest_id() {
		return test_id;
	}
	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}
	public String getTest_name() {
		return test_name;
	}
	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}
	public int getQue_id() {
		return que_id;
	}
	public void setQue_id(int que_id) {
		this.que_id = que_id;
	}
	public int getTest_num() {
		return test_num;
	}
	public void setTest_num(int test_num) {
		this.test_num = test_num;
	}
	public int getLec_id() {
		return lec_id;
	}
	public void setLec_id(int lec_id) {
		this.lec_id = lec_id;
	}
	public String getLec_name() {
		return lec_name;
	}
	public void setLec_name(String lec_name) {
		this.lec_name = lec_name;
	}
	public int getLec_type_id() {
		return lec_type_id;
	}
	public void setLec_type_id(int lec_type_id) {
		this.lec_type_id = lec_type_id;
	}
	public String getLec_type_name() {
		return lec_type_name;
	}
	public void setLec_type_name(String lec_type_name) {
		this.lec_type_name = lec_type_name;
	}
	public String getTest_que() {
		return test_que;
	}
	public void setTest_que(String test_que) {
		this.test_que = test_que;
	}
	public String getQue_ans() {
		return que_ans;
	}
	public void setQue_ans(String que_ans) {
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
