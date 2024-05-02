package kr.happyjob.study.test.model;

public class TestModel {
	
	//강의ID
	private int lec_id;

	//학생ID
	private String std_id;
	
	//시험ID
	private int test_id;
	
	//문제ID
	private int que_id;
	
	//강의분류ID
	private int lec_type_id;
	
	//강의분류명
	private String lec_type_name;

	//문제
	private String test_que;
	
	//정답
	private int que_ans;
	
	//보기1
	private String que_ex1;

	// 보기2
	private String que_ex2;

	// 보기3
	private String que_ex3;

	// 보기4
	private String que_ex4;
	
	//시험명
	private String test_name;
	
	//총문항수 
	private int cnt;
	
	//테스트점수
	private int test_sco;
	
	//사용여부
	private String use_yn;
	

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

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

	public int getTest_id() {
		return test_id;
	}

	public void setTest_id(int test_id) {
		this.test_id = test_id;
	}

	public int getQue_id() {
		return que_id;
	}

	public void setQue_id(int que_id) {
		this.que_id = que_id;
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

	public String getTest_name() {
		return test_name;
	}

	public void setTest_name(String test_name) {
		this.test_name = test_name;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public int getTest_sco() {
		return test_sco;
	}

	public void setTest_sco(int test_sco) {
		this.test_sco = test_sco;
	}
}
