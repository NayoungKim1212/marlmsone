package kr.happyjob.study.tut.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.std.model.MyTestInfoVo;

import kr.happyjob.study.std.model.TestUserVo;
import kr.happyjob.study.std.model.TestResultVo;

import kr.happyjob.study.std.model.TestDetailVo;
import kr.happyjob.study.tut.model.TutTestInfoVo;



public interface TutTestInfoService {
	
	/** 강사의 시험출제 목록 조회 */
	public List<TutTestInfoVo> tutTestList(Map<String, Object> paramMap) throws Exception;
	
	/** 강사의 시험출제 목록 카운트 조회 */
	public int tutTestListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 시험지 생성 (문제은행 추출) */
	public List<TestDetailVo> generateTest(Map<String, Object> paramMap) throws Exception;
	
	/** 시험지 등록 */
	public int registerTest(Map<String, Object> paramMap) throws Exception;
	
	/** 시험지 상세보기 */
	public List<TestDetailVo> tutTestDetail(Map<String, Object> paramMap) throws Exception;
	
	

	
	/** 나의 시험응시 목록 조회 */
	public List<MyTestInfoVo> myTestList(Map<String, Object> paramMap) throws Exception;
	
	/** 나의 시험응시 목록 카운트 조회 */
	public int myTestListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 나의 시험문제 항목 조회 */
	public List<TestDetailVo> testItemList(Map<String, Object> paramMap) throws Exception;
	
	/** 나의 시험문제 항목 카운트 조회 */
	public int testItemListCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시(제출) */	
	public int submitTest(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시 결과 조회  */	
	public TestUserVo searchTestUser(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시 상세결과 조회 */	
	public List<TestResultVo> searchTestResult(Map<String, Object> paramMap) throws Exception;
	
	/** 시험응시 상세결과 카운트 조회 */
	public int searchTestResultCnt(Map<String, Object> paramMap) throws Exception;
}